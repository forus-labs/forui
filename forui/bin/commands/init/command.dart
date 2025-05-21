import 'dart:io';

import '../../args/command.dart';
import '../../commands/snippet/snippet.dart';
import '../../configuration.dart';

class InitCommand extends ForuiCommand {
  @override
  final name = 'init';

  @override
  final aliases = ['initialize'];

  @override
  final description = 'Initialize this project to use Forui.';

  @override
  final arguments = '';

  final Configuration configuration;

  InitCommand(this.configuration) {
    argParser.addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false);
  }

  @override
  void run() {
    _configuration().writeAsStringSync(defaults);
    stdout.writeln('${emoji ? '✅' : '[Done]'} Created forui.yaml.');

    _main().writeAsStringSync(snippets['main']!);
    stdout.writeln('${emoji ? '✅' : '[Done]'} Created lib/main.dart.');
  }

  File _configuration() {
    final force = argResults!.flag('force');

    final yaml = File('${configuration.root.path}/forui.yaml');
    final yml = File('${configuration.root.path}/forui.yml');

    var file = yaml;
    if (force) {
      return file;
    }

    if (yaml.existsSync() || yml.existsSync()) {
      final extension = yaml.existsSync() ? 'yaml' : 'yml';
      file = yaml.existsSync() ? yaml : yml;

      _prompt('forui.$extension');
    }

    return file;
  }

  File _main() {
    final force = argResults!.flag('force');

    final file = File('${configuration.root.path}/lib/main.dart');
    if (force) {
      return file;
    }

    if (file.existsSync()) {
      _prompt('lib/main.dart', 'You can generate a main.dart later by running "dart forui snippet create main". ');
    }

    return file;
  }

  void _prompt(String file, [String message = '']) {
    final input = !globalResults!.flag('no-input');

    if (!input) {
      stdout.writeln('$file already exists. Skipping... ');
      exit(0);
    }

    while (true) {
      stdout.write('${emoji ? '⚠️' : '[Warning]'} $file already exists. ${message}Overwrite it? [Y/n] ');

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
