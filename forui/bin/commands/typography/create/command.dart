import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:dart_style/dart_style.dart';

import '../../../configuration.dart';
import '../../../typography.dart';
import '../../../args/command.dart';

final console = Console();

const _header = '''
import 'package:forui/forui.dart';
import 'package:flutter/widgets.dart';

/// See https://forui.dev/docs/cli for more information.''';

final _formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

class TypographyCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final List<String> aliases = ['c'];

  @override
  final description = 'Create a Forui typography.';

  @override
  String get invocation {
    final parents = [name];
    for (var command = parent; command != null; command = command.parent) {
      parents.add(command.name);
    }
    parents.add(runner!.executableName);

    return parents.reversed.join(' ');
  }

  TypographyCreateCommand() {
    argParser
      ..addFlag(
        'force',
        abbr: 'f',
        help: 'Overwrite existing files if they exist.',
        negatable: false,
        defaultsTo: defaultForce,
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: defaultDirectory,
      );
  }

  @override
  void run() {
    if (argResults!.rest.isNotEmpty) {
      printUsage();
      return;
    }

    final output = argResults!['output'] as String;
    var path = output.endsWith('.dart') ? output : '$output${Platform.pathSeparator}typography.dart';
    if (output != defaultDirectory) {
      path = '${root.path}${Platform.pathSeparator}$path';
    }

    if (File(path).existsSync()) {
      _prompt(path);
    }

    final buffer =
        StringBuffer()
          ..writeln(_header)
          ..writeln(typography);

    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(_formatter.format(buffer.toString()));

    console
      ..write('${console.supportsEmoji ? '✅' : '[Done]'} $path')
      ..writeLine();
  }

  void _prompt(String file) {
    final input = !globalResults!.flag('no-input');
    final force = argResults!.flag('force');

    if (!input) {
      console
        ..write('$file already exists. Skipping... ')
        ..writeLine();
      exit(0);
    }

    if (force) {
      return;
    }

    while (true) {
      console
        ..write('${console.supportsEmoji ? '⚠️' : '[Warning]'} $file already exists. Overwrite it? [Y/n]')
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
}
