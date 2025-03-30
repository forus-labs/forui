import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:sugar/core.dart';

import '../../../registry.dart';
import 'command.dart';

const _header = '''
/// Generated by Forui CLI.
///
/// Modify the generated function bodies to create your own custom style.
/// Then, call the modified functions and pass the results to your FThemeData.
/// 
/// ### Example
///
/// Generated style (this):
/// ```dart
/// FDividerStyles dividerStyles({required FColorScheme colorScheme, required FStyle style}) => FDividerStyles(
///   horizontalStyle: dividerStyle(
///     colorScheme: colorScheme,
///     style: style,
///     padding: FDividerStyle.defaultPadding.horizontalStyle,
///   ),
///   verticalStyle: dividerStyle(
///     colorScheme: colorScheme,
///     style: style,
///     padding: FDividerStyle.defaultPadding.verticalStyle,
///   ),
/// );
/// 
/// FDividerStyle dividerStyle({
///   required FColorScheme colorScheme,
///   required FStyle style,
///   required EdgeInsetsGeometry padding,
/// }) => FDividerStyle(color: colorScheme.secondary, padding: padding, width: style.borderWidth);
/// ```
///
/// File that contains your `FThemeData`:
/// ```dart
/// import 'package:my_application/styles/divider_styles.dart' // Your generated file
///
/// FThemeData(
///  colorScheme: FThemes.zinc.light.colorScheme,
///  style: FThemes.zinc.light.style,
///  dividerStyles: dividerStyles(
///    colorScheme: FThemes.zinc.light.colorScheme,
///    style: FThemes.zinc.light.style,
///   ),
/// );
/// ```
library;

import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
''';

final _formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

extension GenerateStyles on StyleCreateCommand {
  void generateStyles(
    List<String> arguments, {
    required bool color,
    required bool input,
    required bool all,
    required bool force,
    required String output,
  }) {
    final paths = <String, List<String>>{};
    final existing = <String>{};

    for (final style in all ? registry.keys.toList() : arguments) {
      final fileName = registry[style]!.type.substring(1).toSnakeCase();
      final path = output.endsWith('.dart') ? output : '$output${Platform.pathSeparator}$fileName.dart';

      (paths[path] ??= []).add(style);
      if (File(path).existsSync()) {
        existing.add(path);
      }
    }

    if (!force && existing.isNotEmpty) {
      _prompt(existing, input: input);
    }

    _generate(paths);

    // TODO: Update link to the documentation.
    console
      ..writeLine()
      ..write('See https://forui.dev/docs/cli/style-usage for how to use the generated styles.')
      ..writeLine();
  }

  void _prompt(Set<String> existing, {required bool input}) {
    console
      ..write('Found ${existing.length} file(s) that already exist.')
      ..writeLine();

    if (!input) {
      exit(0);
    }

    while (true) {
      console
        ..writeLine()
        ..write('Overwrite these files?')
        ..writeLine()
        ..write('  1 - Overwrite')
        ..writeLine()
        ..write('  2 - Cancel')
        ..writeLine()
        ..write('  3 - List existing files')
        ..writeLine();

      switch (console.readLine(cancelOnBreak: true)) {
        case null:
          exit(0);
        case final line when int.tryParse(line) == 2:
          exit(0);
        case final line when int.tryParse(line) == 3:
          console
            ..writeLine()
            ..write('Existing files:')
            ..writeLine();
          for (final path in existing) {
            console
              ..write('  $path')
              ..writeLine();
          }
          continue;
        case final line when int.tryParse(line) == 1:
          return;
        default:
          console
            ..write('Invalid option. Please enter a number between 1 and 3.')
            ..writeLine();
          continue;
      }
    }
  }

  void _generate(Map<String, List<String>> paths) {
    console
      ..write('${console.supportsEmoji ? '⏳' : '[Waiting]'} Creating styles...')
      ..writeLine()
      ..writeLine();

    for (final MapEntry(key: path, value: styles) in paths.entries) {
      final buffer = StringBuffer(_header);

      if (registry[styles.singleOrNull] case Registry(:final closure)) {
        _reduce(buffer, closure, many: false);
      } else {
        for (final style in styles) {
          _reduce(buffer, registry[style]!.closure, many: true);
        }
      }

      File(path)
        ..createSync(recursive: true)
        ..writeAsStringSync(_formatter.format(buffer.toString()));

      console
        ..write('${console.supportsEmoji ? '✅' : '[Done]'} $path')
        ..writeLine();
    }
  }

  void _reduce(StringBuffer buffer, List<String> closure, {required bool many}) {
    final root = registry[closure.first.toLowerCase()]!;

    if (many) {
      buffer
        ..writeln('extension Custom${root.type} on Never {')
        ..write('static ');
    }
    buffer.writeln(root.source);

    for (final nested in closure.skip(1)) {
      if (many) {
        buffer.write('static ');
      }
      final style = registry[nested.toLowerCase()]!;
      buffer.write('${style.source.substring(0, style.position)}_${style.source.substring(style.position)}\n');
    }

    if (many) {
      buffer.writeln('}');
    }
  }
}
