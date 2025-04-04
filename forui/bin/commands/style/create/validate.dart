import 'dart:math' as math;

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
          registry.keys.map((e) => (e, e.startsWith(style) ? 1 : _distance(style, e))).where((e) => e.$2 <= 3).toList()
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

  /// Copied from args package.
  ///
  /// See https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance#Optimal_string_alignment_distance
  int _distance(String from, String to) {
    // Add a space in front to mimic indexing by 1 instead of 0.
    from = ' $from';
    to = ' $to';
    final distances = [
      for (var i = 0; i < from.length; i++)
        [
          for (var j = 0; j < to.length; j++)
            if (i == 0) j else if (j == 0) i else 0,
        ],
    ];

    for (var i = 1; i < from.length; i++) {
      for (var j = 1; j < to.length; j++) {
        // Removals from `from`.
        var min = distances[i - 1][j] + 1;
        // Additions to `from`.
        min = math.min(min, distances[i][j - 1] + 1);
        // Substitutions (and equality).
        min = math.min(
          min,
          distances[i - 1][j - 1] +
              // Cost is zero if substitution was not actually necessary.
              (from[i] == to[j] ? 0 : 1),
        );
        // Allows for basic swaps, but no additional edits of swapped regions.
        if (i > 1 && j > 1 && from[i] == to[j - 1] && from[i - 1] == to[j]) {
          min = math.min(min, distances[i - 2][j - 2] + 1);
        }
        distances[i][j] = min;
      }
    }

    return distances.last.last;
  }
}
