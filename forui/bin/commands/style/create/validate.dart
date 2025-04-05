import '../../../args/utils.dart';
import 'command.dart';

extension ValidateStyles on StyleCreateCommand {
  bool validateStyles(List<String> arguments, {required bool all, required bool color}) {
    if (arguments.isNotEmpty && all) {
      console
        ..write('Cannot use "[styles]" and "--all" at the same time.')
        ..writeLine()
        ..write('Either use "--all" or specify the styles.')
        ..writeLine();
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

      console
        ..write('Could not find a style named "')
        ..setTextStyle(bold: color)
        ..write(style)
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
            ..write('  ${registry[suggestion.$1]!.type}')
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
