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
    // Assumes that the first alias is the widget's name.
    final styles = Style.values.asNameMap().values.toList()
      ..sort((a, b) {
        final aName = a.type.replaceAll(RegExp('Styles?'), '').substring(1);
        final bName = b.type.replaceAll(RegExp('Styles?'), '').substring(1);

        if (aName.startsWith(bName)) {
          return 1;
        } else if (bName.startsWith(aName)) {
          return -1;
        } else {
          return aName.compareTo(bName);
        }
      });

    stdout.writeln('Available styles:');
    for (final style in styles) {
      stdout.writeln('  ${[...style.aliases, style.type].join(', ')}');
    }
  }
}
