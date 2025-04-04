import 'dart:io';

import 'package:dart_console/dart_console.dart';

import '../../../args/command.dart';
import '../../../registry.dart';
import 'generate.dart';
import 'validate.dart';

final console = Console();
final registry = Registry.values.asNameMap();
final _path = '${Directory.current.path}${Platform.pathSeparator}lib${Platform.pathSeparator}styles';

class StyleCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final List<String> aliases = ['c'];

  @override
  final description = 'Create Forui widget style file(s).';

  @override
  String get invocation {
    final parents = [name];
    for (var command = parent; command != null; command = command.parent) {
      parents.add(command.name);
    }
    parents.add(runner!.executableName);

    return '${parents.reversed.join(' ')} [styles]';
  }

  StyleCreateCommand() {
    argParser
      ..addFlag('all', abbr: 'a', help: 'Generate all styles.', negatable: false)
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption('output', abbr: 'o', help: 'The output directory or file.', defaultsTo: _path);
  }

  @override
  void run() {
    final color = globalResults!.flag('color');
    final input = !globalResults!.flag('no-input');
    final all = argResults!.flag('all');
    final force = argResults!.flag('force');
    final output = argResults!['output'] as String;
    final arguments = argResults!.rest;

    if (argResults!.arguments.isEmpty && !all) {
      printUsage();
      return;
    }

    if (validateStyles(arguments, color: color, all: all)) {
      exit(1);
    }

    generateStyles(arguments, color: color, input: input, all: all, force: force, output: output);
  }
}
