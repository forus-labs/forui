import 'dart:math' as math;

// Copied from package:dart/args/lib/src/utils.dart since it wasn't public.

/// Pads [source] to [length] by adding spaces at the end.
String padRight(String source, int length) =>
    source + ' ' * (length - source.length);

/// Wraps a block of text into lines no longer than [length].
///
/// Tries to split at whitespace, but if that's not good enough to keep it
/// under the limit, then it splits in the middle of a word.
///
/// Preserves indentation (leading whitespace) for each line (delimited by '\n')
/// in the input, and indents wrapped lines the same amount.
///
/// If [hangingIndent] is supplied, then that many spaces are added to each
/// line, except for the first line. This is useful for flowing text with a
/// heading prefix (e.g. "Usage: "):
///
/// ```dart
/// var prefix = "Usage: ";
/// print(
///   prefix + wrapText(invocation, hangingIndent: prefix.length, length: 40),
/// );
/// ```
///
/// yields:
/// ```shell
/// Usage: app main_command <subcommand>
///        [arguments]
/// ```
///
/// If [length] is not specified, then no wrapping occurs, and the original
/// [text] is returned unchanged.
String wrapText(String text, {int? length, int? hangingIndent}) {
  if (length == null) {
    return text;
  }
  hangingIndent ??= 0;
  final splitText = text.split('\n');
  final result = <String>[];
  for (final line in splitText) {
    var trimmedText = line.trimLeft();
    final leadingWhitespace = line.substring(
      0,
      line.length - trimmedText.length,
    );
    List<String> notIndented;
    if (hangingIndent != 0) {
      // When we have a hanging indent, we want to wrap the first line at one
      // width, and the rest at another (offset by hangingIndent), so we wrap
      // them twice and recombine.
      final firstLineWrap = wrapTextAsLines(
        trimmedText,
        length: length - leadingWhitespace.length,
      );
      notIndented = [firstLineWrap.removeAt(0)];
      trimmedText = trimmedText.substring(notIndented[0].length).trimLeft();
      if (firstLineWrap.isNotEmpty) {
        notIndented.addAll(
          wrapTextAsLines(
            trimmedText,
            length: length - leadingWhitespace.length - hangingIndent,
          ),
        );
      }
    } else {
      notIndented = wrapTextAsLines(
        trimmedText,
        length: length - leadingWhitespace.length,
      );
    }
    String? hangingIndentString;
    result.addAll(
      notIndented.map<String>((line) {
        // Don't return any lines with just whitespace on them.
        if (line.isEmpty) {
          return '';
        }
        final result = '${hangingIndentString ?? ''}$leadingWhitespace$line';
        hangingIndentString ??= ' ' * hangingIndent!;
        return result;
      }),
    );
  }
  return result.join('\n');
}

/// Wraps a block of text into lines no longer than [length],
/// starting at the [start] column, and returns the result as a list of strings.
///
/// Tries to split at whitespace, but if that's not good enough to keep it
/// under the limit, then splits in the middle of a word. Preserves embedded
/// newlines, but not indentation (it trims whitespace from each line).
///
/// If [length] is not specified, then no wrapping occurs, and the original
/// [text] is returned after splitting it on newlines. Whitespace is not trimmed
/// in this case.
List<String> wrapTextAsLines(String text, {int start = 0, int? length}) {
  assert(start >= 0, 'start must be >= 0');

  /// Returns true if the code unit at [index] in [text] is a whitespace
  /// character.
  ///
  /// Based on: https://en.wikipedia.org/wiki/Whitespace_character#Unicode
  bool isWhitespace(String text, int index) {
    final rune = text.codeUnitAt(index);
    return rune >= 0x0009 && rune <= 0x000D ||
        rune == 0x0020 ||
        rune == 0x0085 ||
        rune == 0x1680 ||
        rune == 0x180E ||
        rune >= 0x2000 && rune <= 0x200A ||
        rune == 0x2028 ||
        rune == 0x2029 ||
        rune == 0x202F ||
        rune == 0x205F ||
        rune == 0x3000 ||
        rune == 0xFEFF;
  }

  if (length == null) {
    return text.split('\n');
  }

  final result = <String>[];
  final effectiveLength = math.max(length - start, 10);
  for (var line in text.split('\n')) {
    line = line.trim();
    if (line.length <= effectiveLength) {
      result.add(line);
      continue;
    }

    var currentLineStart = 0;
    int? lastWhitespace;
    for (var i = 0; i < line.length; ++i) {
      if (isWhitespace(line, i)) {
        lastWhitespace = i;
      }

      if (i - currentLineStart >= effectiveLength) {
        // Back up to the last whitespace, unless there wasn't any, in which
        // case we just split where we are.
        if (lastWhitespace != null) {
          i = lastWhitespace;
        }

        result.add(line.substring(currentLineStart, i).trim());

        // Skip any intervening whitespace.
        while (isWhitespace(line, i) && i < line.length) {
          i++;
        }

        currentLineStart = i;
        lastWhitespace = null;
      }
    }
    result.add(line.substring(currentLineStart).trim());
  }
  return result;
}

/// Copied from args package.
///
/// See https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance#Optimal_string_alignment_distance
int distance(String from, String to) {
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
