import 'dart:math';

import 'package:meta/meta.dart';

/// A parser that parses updates components of a string input.
@internal
abstract class Parser {
  final List<String> parts;

  Parser(this.parts);

  /// Updates the [current] input based on the [current] and [previous] input.
  (List<String>, Changes) update(List<String> previous, List<String> current) {
    assert(previous.length == parts.length, 'previous must have ${parts.length} parts');
    assert(current.length == parts.length, 'current must have ${parts.length} parts');

    Changes changes = const None();
    for (int i = 0; i < parts.length; i++) {
      final previousPart = previous[i];
      final currentPart = current[i];

      if (previous[i] == current[i]) {
        continue;
      }

      final (updated, next) = updatePart(parts[i], previousPart, currentPart);

      current[i] = updated;
      if (updated != previousPart) {
        final nextPart = next ? i + 1 : i;
        changes = changes.add(min(nextPart, parts.length - 1));
      }
    }

    return (current, changes);
  }

  @protected
  (String updated, bool next) updatePart(String pattern, String previous, String current);

  /// Adjusts the current part of the input by [amount].
  List<String> adjust(List<String> current, int selected, int amount) {
    assert(current.length == parts.length, 'Must have ${parts.length} parts.');

    final part = current[selected];
    current[selected] = adjustPart(parts[selected], part, amount);

    return current;
  }

  @protected
  String adjustPart(String pattern, String current, int amount);
}

@internal
sealed class Changes {
  const Changes();

  Changes add(int i);
}

@internal
class None extends Changes {
  const None();

  @override
  Single add(int i) => Single(i);
}

@internal
class Single extends Changes {
  final int index;

  const Single(this.index);

  @override
  Many add(int i) => const Many();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Single && runtimeType == other.runtimeType && index == other.index;

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() => 'Single($index)';
}

@internal
class Many extends Changes {
  const Many();

  @override
  Many add(int _) => this;
}
