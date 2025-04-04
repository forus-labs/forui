import 'package:dart_console/dart_console.dart';

import '../../../registry.dart';
import '../../../args/command.dart';

final console = Console();

class StyleLsCommand extends ForuiCommand {
  @override
  final name = 'list';

  @override
  List<String> aliases = ['ls'];

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
