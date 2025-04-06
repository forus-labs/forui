import 'dart:io';

import '../../../args/utils.dart';
import 'command.dart';

extension ValidateStyles on StyleCreateCommand {
  bool validateStyles(List<String> arguments, {required bool all, required bool color}) {
    if (arguments.isNotEmpty && all) {
      stdout
        ..writeln('Cannot use "[styles]" and "--all" at the same time.')
        ..writeln('Either use "--all" or specify the styles.');
      return true;
    }

    var error = false;
    for (final argument in arguments) {
      final style = argument;
      if (registry.containsKey(style.toLowerCase())) {
        continue;
      }

      error = true;

      final suggestions =
          registry.keys.map((e) => (e, e.startsWith(style) ? 1 : distance(style, e))).where((e) => e.$2 <= 3).toList()
            ..sort((a, b) => a.$2.compareTo(b.$2));

      stdout.write('Could not find a style named "$style".');

      if (suggestions.isNotEmpty) {
        stdout
          ..writeln()
          ..writeln('Did you mean one of these?');
        for (final suggestion in suggestions) {
          stdout.writeln('  ${registry[suggestion.$1]!.type}');
        }
      }

      stdout.writeln();
    }

    if (error) {
      stdout.writeln('Run "dart run forui style ls" to see all styles.');
    }

    return error;
  }
}
