import 'dart:io';

import '../../../args/command.dart';
import '../color.dart';
import '../../../configuration.dart';
import 'generate.dart';
import 'validate.dart';

final registry = ColorScheme.values.asNameMap();
final separator = RegExp('_|-');

class ColorCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create Forui color scheme file(s).';

  @override
  final arguments = '[color schemes]';

  ColorCreateCommand() {
    argParser
      ..addFlag('all', abbr: 'a', help: 'Create all color schemes.', negatable: false)
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: defaultColorOutput,
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

    if (arguments.isEmpty && !all) {
      printUsage();
      return;
    }

    if (validateColors(arguments, color: color, all: all)) {
      exit(1);
    }

    generateColors(arguments, color: color, input: input, all: all, force: force, output: output);
  }
}
