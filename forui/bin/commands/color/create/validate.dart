import '../../../args/utils.dart';
import 'command.dart';

extension ValidateColors on ColorCreateCommand {
  bool validateColors(List<String> arguments, {required bool all, required bool color}) {
    if (arguments.isNotEmpty && all) {
      console
        ..write('Cannot use "[color schemes]" and "--all" at the same time.')
        ..writeLine()
        ..write('Either use "--all" or specify the color schemes.')
        ..writeLine();
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
          registry.keys.map((e) => (e, e.startsWith(colorScheme) ? 1 : distance(colorScheme, e))).where((e) => e.$2 <= 3).toList()
            ..sort((a, b) => a.$2.compareTo(b.$2));

      console
        ..write('Could not find a color scheme named "')
        ..setTextStyle(bold: color)
        ..write(colorScheme)
        ..setTextStyle()
        ..write('".')
        ..writeLine();

      if (suggestions.isNotEmpty) {
        console
          ..writeLine()
          ..write('Did you mean one of these?')
          ..writeLine();

        for (final suggestion in suggestions) {
          console
            ..write('  ${registry[suggestion.$1]!.name}')
            ..writeLine();
        }
      }

      console.writeLine();
    }

    if (error) {
      console
        ..write('Run "dart run forui style ls" to see all styles.')
        ..writeLine();
    }

    return error;
  }
}
