import 'dart:io';

import '../../../args/utils.dart';
import '../command.dart';
import 'command.dart';

extension ValidateColors on ThemeCreateCommand {
  bool validateThemes(String theme) {
    var error = false;

    if (registry.containsKey(theme)) {
      return false;
    }

    error = true;

    final suggestions =
        registry.keys.map((e) => (e, e.startsWith(theme) ? 1 : distance(theme, e))).where((e) => e.$2 <= 3).toList()
          ..sort((a, b) => a.$2.compareTo(b.$2));

    stdout.writeln('Could not find a theme named "$theme".');

    if (suggestions.isNotEmpty) {
      stdout
        ..writeln()
        ..writeln('Did you mean one of these?');

      for (final suggestion in suggestions) {
        stdout.writeln('  ${suggestion.$1}');
      }
    }

    stdout.writeln();

    if (error) {
      stdout.writeln('Run "dart run forui theme ls" to see all themes.');
    }

    return error;
  }
}
