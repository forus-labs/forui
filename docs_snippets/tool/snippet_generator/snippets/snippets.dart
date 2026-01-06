import 'dart:io';

import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import '../snippet.dart';
import '../tooltip_linker.dart';

class Snippets {
  static Future<Map<String, Snippet>> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String path,
  ) async {
    final snippets = <String, Snippet>{};
    final dir = Directory(path);

    for (final file in dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      final content = formatter.format(file.readAsStringSync());
      final relativePath = p.relative(file.path, from: path);
      final fileName = p.withoutExtension(relativePath).replaceAll(p.separator, '/');

      snippets[fileName] = await _process(session, overlay, packages, content);
    }

    return snippets;
  }

  static Future<Snippet> _process(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String content,
  ) async {
    final (links, tooltips) = await TooltipLinker.generate(session, overlay, packages, content);
    final spans = [...links, ...tooltips];
    final blocks = _findBlocks(content);

    if (blocks.isEmpty) {
      final snippet = Snippet(content);
      snippet.spans.addAll(spans);
      snippet.highlight();
      return snippet;
    }

    final snippets = <Snippet>[];
    for (final (start, end, constructor) in blocks) {
      final snippet = Snippet(content)
        ..spans.addAll(spans)
        ..between(start, end);

      if (constructor) {
        snippet.unindent(4);
      }

      snippets.add(snippet);
    }

    final merged = Snippet();
    var offset = 0;
    for (final snippet in snippets) {
      for (final span in snippet.spans) {
        span.adjust(offset);
      }
      merged.text += snippet.text;
      merged.spans.addAll(snippet.spans);
      offset += snippet.text.length;
    }

    // `dart format` always cause a trailing newline, combined with the `eol_at_end_of_file` lint, this produces
    // 2 `\n`s at the end.
    merged
      ..highlight()
      ..text = merged.text.trimRight();

    if (merged.text.isNotEmpty) {
      merged.text += '\n';
    }

    return merged;
  }

  /// Finds all snippet blocks in [content].
  static List<(int start, int end, bool constructor)> _findBlocks(String content) {
    final blocks = <(int start, int end, bool constructor)>[];
    final lines = content.split('\n');
    var offset = 0;

    int? start;
    var constructor = false;

    for (final line in lines) {
      final trimmed = line.trim();

      if (trimmed.startsWith('// {@snippet')) {
        start = offset + line.length + 1;
        constructor = trimmed.endsWith('constructor}');
      } else if (trimmed == '// {@endsnippet}' && start != null) {
        blocks.add((start, offset, constructor));
        start = null;
        constructor = false;
      }

      offset += line.length + 1;
    }

    return blocks;
  }
}
