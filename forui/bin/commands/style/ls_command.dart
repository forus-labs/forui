import 'dart:io';

import '../../args/command.dart';
import 'style.dart';

class StyleLsCommand extends ForuiCommand {
  @override
  final name = 'ls';

  @override
  final aliases = ['list'];

  @override
  final description = 'List all Forui widget styles.';

  @override
  final String arguments = '';

  @override
  void run() {
    final styles = Style.values.asNameMap().values.toList()..sort((a, b) => a.type.compareTo(b.type));

    stdout.writeln('Available styles:');
    for (final style in styles) {
      stdout.writeln('  ${[style.type, ...style.aliases].join(', ')}');
    }
  }
}
