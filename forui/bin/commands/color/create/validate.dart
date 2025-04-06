import 'dart:io';

import '../../../args/utils.dart';
import 'command.dart';

extension ValidateColors on ColorCreateCommand {
  bool validateColors(List<String> arguments, {required bool all, required bool color}) {
    if (arguments.isNotEmpty && all) {
      stdout
        ..writeln('Cannot use "[color schemes]" and "--all" at the same time.')
        ..writeln('Either use "--all" or specify the color schemes.');
      return true;
    }

    var error = false;
    for (final argument in arguments) {
      final colorScheme = argument;
      if (registry.values.any((e) => e.name == colorScheme.toLowerCase())) {
        continue;
      }

      error = true;

      final suggestions =
          registry.keys
              .map((e) => (e, e.startsWith(colorScheme) ? 1 : distance(colorScheme, e)))
              .where((e) => e.$2 <= 3)
              .toList()
            ..sort((a, b) => a.$2.compareTo(b.$2));

      stdout.writeln('Could not find a color scheme named "$colorScheme".');

      if (suggestions.isNotEmpty) {
        stdout
          ..writeln()
          ..writeln('Did you mean one of these?');

        for (final suggestion in suggestions) {
          stdout.writeln('  ${registry[suggestion.$1]!.name}');
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
