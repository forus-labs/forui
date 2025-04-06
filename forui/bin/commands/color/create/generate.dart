import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:sugar/sugar.dart';

import '../../../args/command.dart';
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

    stdout
      ..writeln()
      ..writeln('See https://forui.dev/docs/cli for how to use the generated color schemes.');
  }

  void _prompt(Set<String> existing, {required bool input}) {
    stdout.writeln('Found ${existing.length} file(s) that already exist.');

    if (!input) {
      stdout.writeln('Color scheme files already exist. Skipping... ');
      exit(0);
    }

    stdout
      ..writeln()
      ..writeln('Existing files:');

    for (final path in existing) {
      stdout.writeln('  $path');
    }

    while (true) {
      stdout
        ..writeln()
        ..writeln('${emoji ? '⚠️' : '[Warning]'} Overwrite these files? [Y/n]');

      switch (stdin.readLineSync()) {
        case 'y' || 'Y' || '':
          return;
        case 'n' || 'N':
          exit(0);
        default:
          stdout.writeln('Invalid option. Please enter enter either "y" or "n".');
      }
    }
  }

  void _generate(Map<String, List<String>> paths) {
    stdout
      ..writeln('${emoji ? '⏳' : '[Waiting]'} Creating color schemes...')
      ..writeln();

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

      stdout.writeln('${emoji ? '✅' : '[Done]'} $path');
    }
  }
}
