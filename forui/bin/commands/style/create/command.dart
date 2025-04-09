import 'dart:io';

import '../../../args/command.dart';
import '../../../args/utils.dart';
import '../../../configuration.dart';
import '../style.dart';
import 'generate.dart';

final registry = {
  for (final MapEntry(:key, :value) in Style.values.asNameMap().entries) ...{
    key.toLowerCase(): value,
    for (final alias in value.aliases) alias.toLowerCase(): value,
  },
};

class StyleCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create Forui widget style file(s).';

  @override
  final arguments = '[styles]';

  final Configuration configuration;

  StyleCreateCommand(this.configuration) {
    argParser
      ..addFlag('all', abbr: 'a', help: 'Generate all styles.', negatable: false)
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: configuration.style,
      );
  }

  @override
  void run() {
    final input = !globalResults!.flag('no-input');
    final all = argResults!.flag('all');
    final arguments = argResults!.rest;

    if (arguments.isEmpty && !all) {
      printUsage();
      return;
    }

    if (!_validate(arguments, all: all)) {
      exit(1);
    }

    generate(arguments, input: input, all: all);
  }

  bool _validate(List<String> arguments, {required bool all}) {
    if (arguments.isNotEmpty && all) {
      stdout
        ..writeln('Cannot use "[styles]" and "--all" at the same time.')
        ..writeln('Either use "--all" or specify the styles.');
      return false;
    }

    var success = true;
    for (final style in arguments) {
      if (registry.containsKey(style.toLowerCase())) {
        continue;
      }

      success = false;

      final suggestions =
          registry.keys.map((e) => (e, e.startsWith(style) ? 1 : distance(style, e))).where((e) => e.$2 <= 3).toList()
            ..sort((a, b) => a.$2.compareTo(b.$2));

      stdout.write('Could not find a style named "$style".');

      if (suggestions.isNotEmpty) {
        stdout
          ..writeln()
          ..writeln('Did you mean one of these?');

        for (final (suggestion, _) in suggestions) {
          stdout.writeln('  ${registry[suggestion]!.type}');
        }
      }

      stdout.writeln();
    }

    if (!success) {
      stdout.writeln('Run "dart run forui style ls" to see all styles.');
    }

    return success;
  }
}
