import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:sugar/sugar.dart';

import '../../../configuration.dart';
import 'command.dart';

const header = '''
import 'package:forui/forui.dart';
import 'package:flutter/material.dart';

/// See https://forui.dev/docs/cli for more information.''';

final _formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

extension GenerateColors on ColorCreateCommand {
  void generateColors(
    List<String> arguments, {
    required bool color,
    required bool input,
    required bool all,
    required bool force,
    required String output,
  }) {
    final paths = <String, List<String>>{};
    final existing = <String>{};

    for (final color
        in (all ? registry.values.map((e) => e.name).where((e) => e.split('-').length == 1).toList() : arguments)) {
      final normalized = color.replaceAll(separator, '').toLowerCase();
      final fileName = registry[normalized]!.name.toSnakeCase();
      final path =
          '${root.path}${Platform.pathSeparator}${output.endsWith('.dart') ? output : '$output${Platform.pathSeparator}$fileName.dart'}';

      (paths[path] ??= []).add(normalized);
      if (File(path).existsSync()) {
        existing.add(path);
      }
    }

    if (!force && existing.isNotEmpty) {
      _prompt(existing, input: input);
    }

    _generate(paths);

    console
      ..writeLine()
      ..write('See https://forui.dev/docs/cli for how to use the generated color schemes.')
      ..writeLine();
  }

  void _prompt(Set<String> existing, {required bool input}) {
    console
      ..write('Found ${existing.length} file(s) that already exist.')
      ..writeLine();

    if (!input) {
      console
        ..write('Color scheme files already exist. Skipping... ')
        ..writeLine();
      exit(0);
    }

    console
      ..writeLine()
      ..write('Existing files:')
      ..writeLine();
    for (final path in existing) {
      console
        ..write('  $path')
        ..writeLine();
    }

    while (true) {
      console
        ..writeLine()
        ..write('${console.supportsEmoji ? '⚠️' : '[Warning]'} Overwrite these files? [Y/n]')
        ..writeLine();

      switch (console.readLine(cancelOnBreak: true)) {
        case 'y' || 'Y' || '':
          console.writeLine();
          return;
        case 'n' || 'N':
          exit(0);
        default:
          console
            ..write('Invalid option. Please enter enter either "y" or "n".')
            ..writeLine();
          continue;
      }
    }
  }

  void _generate(Map<String, List<String>> paths) {
    console
      ..write('${console.supportsEmoji ? '⏳' : '[Waiting]'} Creating color schemes...')
      ..writeLine()
      ..writeLine();

    for (final MapEntry(key: path, value: colors) in paths.entries) {
      final buffer = StringBuffer('$header\n');
      for (final color in colors) {
        buffer
          ..writeln(registry[color.toLowerCase()]!.source)
          ..writeln();
      }

      File(path)
        ..createSync(recursive: true)
        ..writeAsStringSync(_formatter.format(buffer.toString()));

      console
        ..write('${console.supportsEmoji ? '✅' : '[Done]'} $path')
        ..writeLine();
    }
  }
}
