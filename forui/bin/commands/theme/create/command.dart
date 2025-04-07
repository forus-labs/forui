import 'dart:io';

import '../../../args/command.dart';
import '../../../configuration.dart';
import 'generate.dart';
import 'validate.dart';

final separator = RegExp('_|-');

class ThemeCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Creates a Forui theme file.';

  @override
  final arguments = '[theme]';

  ThemeCreateCommand() {
    argParser
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: defaultThemeOutput,
      );
  }

  @override
  void run() {
    final input = !globalResults!.flag('no-input');
    final force = argResults!.flag('force');
    final output = argResults!['output'] as String;
    final arguments = argResults!.rest;

    if (arguments.length != 1) {
      printUsage();
      return;
    }

    if (validateThemes(arguments.single)) {
      exit(1);
    }

    generateThemes(arguments.single, input: input, force: force, output: output);
  }
}
