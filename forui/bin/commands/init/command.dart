import 'dart:io';
import 'package:dart_console/dart_console.dart';

import '../../args/command.dart';
import '../../configuration.dart';

final console = Console();

const content =
'''
# See https://forui.dev/docs/cli for more information.
cli:
  output: lib/themes
  force: false
''';

class InitCommand extends ForuiCommand {
  @override
  final name = 'init';

  @override
  final List<String> aliases = ['initialize'];

  @override
  final description = 'Initialize this project to use Forui.';

  @override
  void run() {
    final yaml = File('${root.path}/forui.yaml');
    final yml = File('${root.path}/forui.yml');
    if (yaml.existsSync() || yml.existsSync()) {
      console
        ..write('${console.supportsEmoji ? '✅' : '[Done]'} ')
        ..write('forui.${yaml.existsSync() ? 'yaml' : 'yml'}')
        ..write(' already exists. Skipping initialization...')
        ..writeLine();
      return;
    }

    yaml.writeAsStringSync(content);
    console
      ..write('${console.supportsEmoji ? '✅' : '[Done]'} Created forui.yaml.')
      ..writeLine();
  }
}
