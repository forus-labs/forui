import 'dart:collection';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';

class Transformations {
  final SplayTreeSet<(int offset, int length, String replacement)> _transformations = SplayTreeSet(
    (a, b) => b.$1.compareTo(a.$1),
  );
  final String _code;

  Transformations(this._code);

  void only(SyntacticEntity entity) {
    _transformations
      ..add((0, entity.offset, ''))
      ..add((entity.offset + entity.length, _code.length - (entity.offset + entity.length), ''));
  }

  void replace(SyntacticEntity entity, String replacement) =>
      _transformations.add((entity.offset, entity.length, replacement));

  void replaceWithComma(SyntacticEntity entity, Token end, String replacement) => _transformations.add((
    entity.offset,
    switch (end.next) {
          final next? when next.type == TokenType.COMMA => next.end,
          _ => end.end,
        } -
        entity.offset,
    replacement,
  ));

  void remove(SyntacticEntity entity) => replace(entity, '');

  void removeWithComma(SyntacticEntity entity, Token endToken) => replaceWithComma(entity, endToken, '');

  void removeAll(Iterable<SyntacticEntity> entities) => entities.forEach(remove);

  String apply() {
    var source = _code;
    for (final (offset, length, replacement) in _transformations) {
      source = source.replaceRange(offset, offset + length, replacement);
    }

    return source;
  }
}

extension Sessions on AnalysisSession {
  /// Merges the [declaration] with the [elements] into a single Dart code string.
  Future<String> merge(ResolvedUnitResult result, List<Element> elements, Declaration declaration, String code) async {
    final fragments = SplayTreeMap<int, String>()
      ..[0] = result.unit.directives.whereType<ImportDirective>().map((d) => d.toSource()).join('\n')
      ..[declaration.offset] = code;

    for (final element in elements) {
      final declaration = (await this.declaration(element))!.$2;
      fragments[declaration.offset] = declaration.toSource();
    }

    return fragments.values.join('\n\n');
  }

  Future<(ResolvedUnitResult, Declaration)?> declaration(Element element) async {
    final path = switch (element) {
      InterfaceElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      TopLevelFunctionElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      TopLevelVariableElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      _ => throw ArgumentError('Unsupported element type: ${element.runtimeType}'),
    };

    if (await getResolvedUnit(path) case final ResolvedUnitResult result) {
      for (final declaration in result.unit.declarations) {
        // TopLevelVariableDeclaration contains a list of variables, check each one.
        if (declaration case TopLevelVariableDeclaration(variables: VariableDeclarationList(:final variables))) {
          for (final variable in variables) {
            if (variable.declaredFragment?.element == element) {
              return (result, declaration);
            }
          }
        } else if (declaration.declaredFragment?.element == element) {
          return (result, declaration);
        }
      }
    }

    return null;
  }
}
