import 'dart:collection';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:auto_route_generator/utils.dart';

import 'doc_linker.dart';
import 'main.dart';

class Transformations {
  final SplayTreeSet<(int offset, int length, String? replacement)> _transformations = SplayTreeSet(
    (a, b) => b.$1.compareTo(a.$1),
  );
  final String _source;

  Transformations(this._source);

  void only(SyntacticEntity entity) {
    _transformations
      ..add((0, entity.offset, ''))
      ..add((entity.offset + entity.length, _source.length - (entity.offset + entity.length), ''));
  }

  void replace(SyntacticEntity entity, String replacement) =>
      _transformations.add((entity.offset, entity.length, replacement));

  void delete(SyntacticEntity entity) => _transformations.add((entity.offset, entity.length, null));

  void deleteAll(Iterable<SyntacticEntity> entities) => entities.forEach(delete);

  String transform() {
    var source = _source;
    for (final (offset, length, replacement) in _transformations) {
      source = source.replaceRange(offset, offset + length, replacement ?? '');
    }

    return source;
  }
}

void removeImports(Snippet snippet) {
  final lines = snippet.source.split('\n');
  var importLines = 0;
  var importChars = 0;

  for (final line in lines) {
    if (line.startsWith('import ') || line.trim().isEmpty) {
      importLines++;
      importChars += line.length + 1; // +1 for newline
    } else {
      break;
    }
  }

  // Remove imports from source
  snippet.source = lines.skip(importLines).join('\n');

  // Adjust highlights (line-based)
  for (var i = 0; i < snippet.highlights.length; i++) {
    final (start, end) = snippet.highlights[i];
    snippet.highlights[i] = (start - importLines, end - importLines);
  }

  // Adjust links (offset-based)
  for (var i = 0; i < snippet.links.length; i++) {
    final link = snippet.links[i];
    snippet.links[i] = DartDocLink(
      offset: link.offset - importChars,
      length: link.length,
      url: link.url,
    );
  }
}

extension Sessions on AnalysisSession {
  Future<(ResolvedUnitResult, Declaration)?> declaration(Element element) async {
    final path = switch (element) {
      InterfaceElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      TopLevelFunctionElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      _ => throw ArgumentError('Unsupported element type: ${element.runtimeType}'),
    };

    if (await getResolvedUnit(path) case final ResolvedUnitResult result) {
      final declaration = result.unit.declarations.firstWhereOrNull(
        (d) => d.declaredFragment?.element == element,
      );

      return declaration == null ? null : (result, declaration);
    }

    return null;
  }
}
