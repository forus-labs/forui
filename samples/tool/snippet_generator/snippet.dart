import 'dart:io';
import 'package:path/path.dart' as p;

/// The output directory for generated snippet JSON files.
///
/// Change this to your liking Joe.
final output = p.join(Directory.current.path, 'output');

/// The code snippet.
class Snippet {
  /// The routes which use this snippet.
  final List<String> routes = [];

  /// The line ranges to highlight, inclusive.
  final List<(int start, int end)> highlights = [];

  /// The dartdoc links for identifiers.
  final List<DartDocLink> links = [];

  /// The tooltips for identifiers.
  final List<Tooltip> tooltips = [];

  String _code = '';
  int _importsLines = 0;
  int _importsLength = 0;

  /// Highlight the snippet based on special comments, and remove those comments.
  ///
  /// Neither supports nested highlights nor adjusts the offsets of links/tooltips after removing comments.
  void highlight() {
    // We only process links and tooltips after highlights are done since it's super messy to adjust offsets.
    // Removing imports after processing links and tooltips is fine since they are always at the start rather than
    // scattered throughout the code.
    assert(highlights.isEmpty, 'Highlights have already been processed.');
    assert(links.isEmpty, 'Links must be added after highlighting.');
    assert(tooltips.isEmpty, 'Tooltips must be added after highlighting.');

    final lines = <String>[];
    int? start;
    int lineNumber = 0;

    for (final line in code.split('\n')) {
      final trimmed = line.trim();

      if (trimmed == '// {@highlight}') {
        start = lineNumber + 1;
        continue;
      }

      if (trimmed == '// {@endhighlight}') {
        assert(start != null, 'Found {@endhighlight} without matching {@highlight} in $code.');
        highlights.add((start! - _importsLines, lineNumber - _importsLines));
        start = null;
        continue;
      }

      lines.add(line);
      lineNumber++;
    }

    _code = lines.join('\n');
  }

  String get code => _code;

  set code(String value) {
    final importLines = value.split('\n').takeWhile((l) => l.startsWith('import ') || l.trim().isEmpty).toList();
    _importsLines = importLines.length;
    _importsLength = importLines.fold(0, (sum, line) => sum + line.length + 1);
    _code = value;
  }

  int get importsLength => _importsLength;

  /// Remove import statements from the snippet, resetting the base offset.
  void removeImports() {
    _importsLines = 0;
    _importsLength = 0;
    _code = _code.split('\n').skipWhile((l) => l.startsWith('import ') || l.trim().isEmpty).join('\n');
  }

  Map<String, dynamic> toJson() => {
    'code': _code,
    'highlights': [
      for (final h in highlights) {'start': h.$1, 'end': h.$2},
    ],
    'links': [for (final l in links) l.toJson()],
    'tooltips': [for (final t in tooltips) t.toJson()],
  };
}

/// A tooltip for an identifier.
class Tooltip {
  /// The character offset where the linked identifier starts.
  final int offset;

  /// The length of the linked identifier.
  final int length;

  /// The source code.
  final String code;

  /// The identifier's containing class.
  ///
  /// For constructors, fields and methods: `containing class <class>`.
  final (String name, String url)? container;

  /// The markdown documentation.
  final String documentation;

  Tooltip({
    required int offset,
    required int baseOffset,
    required this.length,
    required this.code,
    required this.container,
    required this.documentation,
  }) : offset = offset - baseOffset;

  Map<String, dynamic> toJson() => {
    'offset': offset,
    'length': length,
    'code': code,
    if (container != null) 'container': {'name': container!.$1, 'url': container!.$2},
    'documentation': documentation,
  };
}

/// A link to a Dart API documentation page.
class DartDocLink {
  /// The character offset where the linked identifier starts.
  final int offset;

  /// The length of the linked identifier.
  final int length;

  /// The URL to the API documentation.
  final String url;

  DartDocLink({required int offset, required int baseOffset, required this.length, required this.url})
    : offset = offset - baseOffset;

  Map<String, dynamic> toJson() => {'offset': offset, 'length': length, 'url': url};
}
