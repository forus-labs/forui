import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

/// The delta between two widget states, containing both the previous and current states along with the differences.
///
/// ## Contract
/// The given collections should not be modified. Doing so will result in undefined behavior.
final class FWidgetStatesDelta {
  /// The previous widget states.
  final Set<WidgetState> previous;

  /// The current widget states.
  final Set<WidgetState> current;
  Set<WidgetState>? _added;
  Set<WidgetState>? _removed;

  /// Creates a [FWidgetStatesDelta].
  FWidgetStatesDelta(this.previous, this.current);

  /// The set of widget states that were added to the [previous].
  Set<WidgetState> get added => _added ??= current.difference(previous);

  /// The set of widget states that were removed from the [previous].
  Set<WidgetState> get removed => _removed ??= previous.difference(current);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FWidgetStatesDelta &&
          runtimeType == other.runtimeType &&
          setEquals(previous, other.previous) &&
          setEquals(current, other.current);

  @override
  int get hashCode => Object.hash(const SetEquality().hash(previous), const SetEquality().hash(current));

  @override
  String toString() => 'FWidgetStatesDelta{previous: $previous, current: $current}';
}
