import 'dart:io';

import 'package:dart_console/dart_console.dart';

import '../../../args/command.dart';
import '../../../configuration.dart';
import '../style.dart';
import 'generate.dart';
import 'validate.dart';

final console = Console();
final registry = Style.values.asNameMap();

class StyleCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create Forui widget style file(s).';

  @override
  final arguments = '[styles]';

  StyleCreateCommand() {
    argParser
      ..addFlag('all', abbr: 'a', help: 'Generate all styles.', negatable: false)
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: defaultStyleOutput,
      );
  }

  @override
  void run() {
    final color = globalResults!.flag('color');
    final input = !globalResults!.flag('no-input');
    final all = argResults!.flag('all');
    final force = argResults!.flag('force');
    final output = argResults!['output'] as String;
    final arguments = argResults!.rest;

    if (argResults!.rest.isEmpty && !all) {
      printUsage();
      return;
    }

    if (validateStyles(arguments, color: color, all: all)) {
      exit(1);
    }

    generateStyles(arguments, color: color, input: input, all: all, force: force, output: output);
  }
}
