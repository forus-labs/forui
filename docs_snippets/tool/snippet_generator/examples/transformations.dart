import 'dart:collection';

import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';

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
