import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The delta between two widget states, containing both the previous and current states along with the differences.
///
/// ## Contract
/// The given collections should not be modified. Doing so will result in undefined behavior.
class FWidgetStatesDelta {
  /// The previous widget states.
  final Set<WidgetState> previous;

  /// The current widget states.
  final Set<WidgetState> current;

  /// The set of widget states that were added to the [previous].
  final Set<WidgetState> added;

  /// The set of widget states that were removed from the [previous].
  final Set<WidgetState> removed;

  /// Creates a [FWidgetStatesDelta].
  FWidgetStatesDelta(this.previous, this.current)
    : added = current.difference(previous),
      removed = previous.difference(current);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FWidgetStatesDelta &&
          runtimeType == other.runtimeType &&
          setEquals(previous, other.previous) &&
          setEquals(current, other.current) &&
          setEquals(added, other.added) &&
          setEquals(removed, other.removed);

  @override
  int get hashCode =>
      const SetEquality().hash(previous) ^
      const SetEquality().hash(current) ^
      const SetEquality().hash(added) ^
      const SetEquality().hash(removed);

  @override
  String toString() => 'FWidgetStatesDelta{previous: $previous, current: $current, added: $added, removed: $removed}';
}
