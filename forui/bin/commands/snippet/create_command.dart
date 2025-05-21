import 'dart:io';

import 'package:sugar/sugar.dart';

import '../../args/command.dart';
import '../../args/utils.dart';
import '../../configuration.dart';
import 'snippet.dart';

class SnippetCreateCommand extends ForuiCommand {
  @override
  final name = 'create';

  @override
  final aliases = ['c'];

  @override
  final description = 'Create code snippet files.';

  @override
  final arguments = '[snippets]';

  final Configuration configuration;

  SnippetCreateCommand(this.configuration) {
    argParser
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false)
      ..addOption(
        'output',
        abbr: 'o',
        help: 'The output directory or file, relative to the project directory.',
        defaultsTo: configuration.snippet,
      );
  }

  @override
  void run() {
    final output = argResults!['output'] as String;
    final arguments = argResults!.rest;

    if (arguments.isEmpty) {
      printUsage();
      return;
    }

    if (!_validate(arguments, output)) {
      exit(1);
    }

    _generate(arguments, output: output);
  }

  bool _validate(List<String> arguments, String output) {
    if (arguments.length > 1 && FileSystemEntity.isFileSync(output)) {
      stdout
        ..writeln('Cannot use "[snippets]" and output to a file at the same time.')
        ..writeln('Either specify a single snippet or a directory.');
      return false;
    }

    var success = true;
    for (final snippet in arguments) {
      if (snippets.containsKey(snippet.toLowerCase())) {
        continue;
      }

      success = false;

      final suggestions =
          snippets.keys
              .map((e) => (e, e.startsWith(snippet) ? 1 : distance(snippet, e)))
              .where((e) => e.$2 <= 3)
              .toList()
            ..sort((a, b) => a.$2.compareTo(b.$2));

      stdout.write('Could not find a code snippet named "$snippet".');

      if (suggestions.isNotEmpty) {
        stdout
          ..writeln()
          ..writeln('Did you mean one of these?');

        for (final (suggestion, _) in suggestions) {
          stdout.writeln('  $suggestion');
        }
      }

      stdout.writeln();
    }

    if (!success) {
      stdout.writeln('Run "dart run forui snippet ls" to see all code snippets.');
    }

    return success;
  }

  void _generate(List<String> arguments, {required String output}) {
    final force = argResults!.flag('force');

    final paths = <String, String>{};
    final existing = <String>{};

    for (final snippet in arguments) {
      final file = snippet.toLowerCase().toSnakeCase();
      final path =
          '${configuration.root.path}${Platform.pathSeparator}${output.endsWith('.dart') ? output : '$output${Platform.pathSeparator}$file.dart'}';

      paths[path] = snippets[snippet.toLowerCase()]!;

      if (File(path).existsSync()) {
        existing.add(path);
      }
    }

    if (!force && existing.isNotEmpty) {
      _prompt(existing);
    }

    stdout
      ..writeln('${emoji ? '⏳' : '[Waiting]'} Creating snippets...')
      ..writeln();

    for (final MapEntry(key: path, value: source) in paths.entries) {
      File(path)
        ..createSync(recursive: true)
        ..writeAsStringSync(formatter.format(source));

      stdout.writeln('${emoji ? '✅' : '[Done]'} $path');
    }
  }

  void _prompt(Set<String> existing) {
    final input = !globalResults!.flag('no-input');

    stdout.writeln('Found ${existing.length} file(s) that already exist.');

    if (!input) {
      stdout.writeln('Style files already exist. Skipping... ');
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
        ..write('${emoji ? '⚠️' : '[Warning]'} Overwrite these files? [Y/n] ');

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
}
