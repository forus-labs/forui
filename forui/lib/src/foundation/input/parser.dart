import 'dart:math';

import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A parser that updates individual parts of a string input.
@internal
abstract class Parser {
  final List<String> pattern;

  Parser(this.pattern);

  /// Updates the [current] input based on the [current] and [previous] input.
  (List<String>, Changes) update(List<String> previous, List<String> current) {
    assert(previous.length == pattern.length, 'previous must have ${pattern.length} parts.');
    assert(current.length == pattern.length, 'current must have ${pattern.length} parts.');

    Changes changes = const None();
    for (int i = 0; i < pattern.length; i++) {
      final previousPart = previous[i];
      final currentPart = current[i];

      if (previous[i] == current[i]) {
        continue;
      }

      final (updated, next) = updatePart(pattern[i], previousPart, currentPart);

      current[i] = updated;
      if (updated != previousPart) {
        final nextPart = next ? i + 1 : i;
        changes = changes.add(min(nextPart, pattern.length - 1));
      }
    }

    return (current, changes);
  }

  @protected
  (String updated, bool next) updatePart(String pattern, String previous, String current);

  /// Adjusts the current part of the input by [amount].
  List<String> adjust(List<String> current, int selected, int amount) {
    assert(current.length == pattern.length, 'Must have ${pattern.length} parts.');

    final part = current[selected];
    current[selected] = adjustPart(pattern[selected], part, amount);

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

@internal
abstract class Selector {
  final FLocalizations localizations;
  final RegExp suffix;

  Selector(this.localizations, this.suffix);

  TextEditingValue? navigate(TextEditingValue value);

  TextEditingValue select(List<String> parts, int index);

  List<String> split(String raw);

  String join(List<String> parts);
}
