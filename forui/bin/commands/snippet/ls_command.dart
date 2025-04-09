import 'dart:io';

import '../../args/command.dart';
import 'snippet.dart';

class SnippetLsCommand extends ForuiCommand {
  @override
  final name = 'ls';

  @override
  final aliases = ['list'];

  @override
  final description = 'List all code snippets.';

  @override
  final String arguments = '';

  @override
  void run() {
    stdout.writeln('Available code snippets:');
    for (final snippet in snippets.keys.toList()..sort()) {
      stdout.writeln('  $snippet');
    }
  }
}
