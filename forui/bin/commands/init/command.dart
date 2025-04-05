import 'dart:io';
import 'package:dart_console/dart_console.dart';

import '../../args/command.dart';
import '../../configuration.dart';

final console = Console();

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
  final List<String> aliases = ['initialize'];

  @override
  final description = 'Initialize this project to use Forui.';

  InitCommand() {
    argParser.addFlag('force', abbr: 'f', help: 'Overwrite existing files if they exist.', negatable: false);
  }

  @override
  void run() {
    _prompt().writeAsStringSync(content);

    console
      ..write('${console.supportsEmoji ? '✅' : '[Done]'} Created forui.yaml.')
      ..writeLine();
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
        console
          ..write('forui.$extension already exists. Skipping... ')
          ..writeLine();
        exit(0);
      }

      while (true) {
        console
          ..write('${console.supportsEmoji ? '⚠️' : '[Warning]'} forui.$extension already exists. Overwrite it? [Y/n]')
          ..writeLine();

        switch (console.readLine(cancelOnBreak: true)) {
          case 'y' || 'Y' || '':
            console.writeLine();
            return file;
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

    return file;
  }
}
