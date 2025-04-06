import 'dart:io';

import '../../args/command.dart';
import '../../configuration.dart';

const content = '''
# See https://forui.dev/docs/cli for more information.
cli:
  color-output: lib/theme/color.dart
  typography-output: lib/theme/typography.dart
  style-output: lib/theme
''';

class InitCommand extends ForuiCommand {
  @override
  final name = 'init';

  @override
  final aliases = ['initialize'];

  @override
  final description = 'Initialize this project to use Forui.';

  @override
  final arguments = '';

  InitCommand() {
    argParser.addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false);
  }

  @override
  void run() {
    _prompt().writeAsStringSync(content);

    stdout.writeln('${emoji ? '✅' : '[Done]'} Created forui.yaml.');
  }

  File _prompt() {
    final input = !globalResults!.flag('no-input');
    final force = argResults!.flag('force');

    final yaml = File('${root.path}/forui.yaml');
    final yml = File('${root.path}/forui.yml');

    var file = yaml;
    if (force) {
      return file;
    }

    if (yaml.existsSync() || yml.existsSync()) {
      final extension = yaml.existsSync() ? 'yaml' : 'yml';
      file = yaml.existsSync() ? yaml : yml;

      if (!input) {
        stdout.writeln('forui.$extension already exists. Skipping... ');
        exit(0);
      }

      while (true) {
        stdout.writeln('${emoji ? '⚠️' : '[Warning]'} forui.$extension already exists. Overwrite it? [Y/n]');

        switch (stdin.readLineSync()) {
          case 'y' || 'Y' || '':
            return file;
          case 'n' || 'N':
            exit(0);
          default:
            stdout.writeln('Invalid option. Please enter enter either "y" or "n".');
        }
      }
    }

    return file;
  }
}
