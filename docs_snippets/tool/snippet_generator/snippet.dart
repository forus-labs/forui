/// The code snippet.
class Snippet {
  /// The line ranges to highlight, 1-indexed and inclusive.
  final List<(int start, int end)> highlights = [];

  // We use a list instead of a SplayTreeMap as spans are mutable, and mutable keys are never a good idea.
  // The alternative is to make Span immutable but that will incur a greater performance overhead overall.
  final List<Span> spans = [];

  String text;

  Snippet([this.text = '']);

  /// Extracts the snippet between [start] and [end], adjusting all span offsets and highlights accordingly.
  void between(int start, [int? end]) {
    final endOffset = end ?? text.length;
    final startLine = text.substring(0, start).split('\n').length - 1;
    final endLine = text.substring(0, endOffset).split('\n').length - 1;

    text = text.substring(start, endOffset);

    spans.removeWhere((span) {
      if (start <= span.offset && span.end <= endOffset) {
        span.adjust(-start);
        return false;
      }
      return true;
    });

    final adjusted = [
      for (final (start, end) in highlights)
        if (startLine <= start && end <= endLine) (start - startLine, end - startLine),
    ];
    highlights
      ..clear()
      ..addAll(adjusted);
  }

  void highlight() {
    // Fix artifacts caused by formatting after dead code elimination removes an entire line.
    text = text.replaceAll('// {@highlight}\n\n', '// {@highlight}\n');

    final output = <String>[];
    final adjustments = <int>[]; // Cumulative characters removed per output line.
    final starts = <int>[]; // Start offset of each output line in original text.

    int? highlightStart;
    var lineNumber = 0;
    var offset = 0;
    var cumulative = 0;

    for (final line in text.split('\n')) {
      final trimmed = line.trim();
      final lineLength = line.length + 1;

      if (trimmed == '// {@highlight}') {
        highlightStart = lineNumber;
        cumulative += lineLength;
      } else if (trimmed == '// {@endhighlight}') {
        if (highlightStart != null && highlightStart < lineNumber) {
          highlights.add((highlightStart + 1, lineNumber));
        }
        highlightStart = null;
        cumulative += lineLength;
      } else {
        output.add(line);
        starts.add(offset);
        adjustments.add(-cumulative);
        lineNumber++;
      }

      offset += lineLength;
    }

    text = output.join('\n');
    _adjustSpans(starts, adjustments);
  }

  /// Indent the snippet by [spaces] spaces, adjusting all span offsets accordingly.
  void indent(int spaces, {bool firstLine = true}) {
    final indent = ' ' * spaces;
    final lines = text.split('\n');
    final indented = StringBuffer();

    final adjustments = <int>[]; // Cumulative adjustments per line.
    final starts = <int>[]; // Offset of start of lines in original text.
    var previous = 0;

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final shouldIndent = i > 0 || firstLine;

      if (shouldIndent) {
        indented.writeln('$indent$line');
        adjustments.add((adjustments.lastOrNull ?? 0) + spaces);
      } else {
        indented.writeln(line);
        adjustments.add(adjustments.lastOrNull ?? 0);
      }

      starts.add((starts.lastOrNull ?? 0) + previous);
      previous = line.length + 1;
    }

    // Remove trailing newline added by writeln
    text = indented.toString().substring(0, indented.length - 1);
    _adjustSpans(starts, adjustments);
  }

  /// Unindent the snippet by [spaces] spaces, adjusting all span offsets accordingly.
  void unindent(int spaces) {
    final indent = ' ' * spaces;
    final lines = text.split('\n');
    final unindented = StringBuffer();

    final adjustments = <int>[]; // Sum of adjustments per line.
    final starts = <int>[]; // Offset of start of lines in original indented code.
    var previous = 0;

    for (final line in lines) {
      if (line.startsWith(indent)) {
        unindented.writeln(line.substring(spaces));
        adjustments.add((adjustments.lastOrNull ?? 0) - spaces);
      } else {
        unindented.writeln(line);
        adjustments.add(adjustments.lastOrNull ?? 0);
      }

      starts.add((starts.lastOrNull ?? 0) + previous);
      previous = line.length + 1;
    }

    text = unindented.toString();
    _adjustSpans(starts, adjustments);
  }

  void _adjustSpans(List<int> starts, List<int> adjustments) {
    for (final span in spans) {
      var line = 0;
      for (var i = starts.length - 1; i >= 0; i--) {
        if (starts[i] <= span.offset) {
          line = i;
          break;
        }
      }
      span.adjust(adjustments[line]);
    }
  }

  /// Remove import statements from the snippet, adjusting spans and highlights.
  void unimport() {
    final lines = text.split('\n');
    final importLines = lines.takeWhile((l) => l.startsWith('import ') || l.trim().isEmpty).toList();
    final removedChars = importLines.fold(0, (sum, l) => sum + l.length + 1);
    final removedLines = importLines.length;

    text = lines.skip(removedLines).join('\n');

    for (final span in spans) {
      span.adjust(-removedChars);
    }

    for (var i = 0; i < highlights.length; i++) {
      final (start, end) = highlights[i];
      highlights[i] = (start - removedLines, end - removedLines);
    }
  }

  Map<String, dynamic> toJson() {
    final links = <DartDocLink>[];
    final tooltips = <Tooltip>[];

    for (final span in spans) {
      switch (span) {
        case DartDocLink():
          links.add(span);
        case Tooltip():
          tooltips.add(span);
      }
    }

    return {
      'text': text,
      'highlights': [
        for (final h in highlights) {'start': h.$1, 'end': h.$2},
      ],
      'links': [for (final l in links) l.toJson()],
      'tooltips': [for (final t in tooltips) t.toJson()],
    };
  }

  @override
  String toString() => text;
}

/// The kind of incomplete code snippet.
enum FragmentSnippetKind { field, getter, method, constructor, formalParameter }

/// An incomplete code snippet.
class FragmentSnippet extends Snippet {
  /// The fragment kind.
  final FragmentSnippetKind kind;

  /// The identifier's containing class.
  ///
  /// For constructors, fields and methods: `containing class <class>`.
  final (String name, String url)? container;

  /// The incomplete snippet.
  FragmentSnippet(super.text, this.kind, this.container);

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    if (container case (final name, final url)) 'container': {'name': name, 'url': url},
  };
}

sealed class Span {
  /// The start of the span (inclusive).
  int offset;

  /// The length.
  int length;

  Span(this.offset, this.length);

  Span copyWith({int? offset});

  Map<String, dynamic> toJson();

  void adjust(int offset) {
    this.offset += offset;
  }

  /// The end of the span (exclusive).
  int get end => offset + length;
}

/// A link to a Dart API documentation page.
class DartDocLink extends Span {
  /// The URL to the API documentation.
  final String url;

  DartDocLink(super.offset, super.length, this.url);

  @override
  Span copyWith({int? offset}) => DartDocLink(offset ?? this.offset, length, url);

  @override
  Map<String, dynamic> toJson() => {'offset': offset, 'length': length, 'url': url};
}

class Tooltip extends Span {
  /// The annotated snippet.
  FragmentSnippet snippet;

  Tooltip(super.offset, super.length, this.snippet);

  @override
  Span copyWith({int? offset}) => Tooltip(offset ?? this.offset, length, snippet);

  @override
  Map<String, dynamic> toJson() => {'offset': offset, 'length': length, 'snippet': snippet.toJson()};
}
