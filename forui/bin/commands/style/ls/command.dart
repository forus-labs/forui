import 'package:dart_console/dart_console.dart';

import '../../../args/command.dart';
import '../../../registry.dart';

final console = Console();

class StyleLsCommand extends ForuiCommand {
  @override
  final name = 'ls';

  @override
  List<String> aliases = ['list'];

  @override
  final description = 'List all Forui widget styles.';

  @override
  void run() {
    final styles = Registry.values.asNameMap().values.map((e) => e.type).toList()..sort();

    console
      ..write('Available styles:')
      ..writeLine();

    for (final style in styles) {
      console
        ..write('  $style')
        ..writeLine();
    }
  }
}
