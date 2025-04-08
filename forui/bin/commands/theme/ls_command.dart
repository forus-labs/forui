import 'dart:io';

import '../../args/command.dart';
import 'command.dart';

class ThemeLsCommand extends ForuiCommand {
  @override
  final name = 'ls';

  @override
  final aliases = ['list'];

  @override
  final description = 'List all Forui themes.';

  @override
  final arguments = '';

  @override
  void run() {
    stdout.writeln('Available themes:');
    for (final theme in registry.keys.toList()..sort()) {
      stdout.writeln('  $theme');
    }
  }
}
