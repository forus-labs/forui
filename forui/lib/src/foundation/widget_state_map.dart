import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

/// A [WidgetStateProperty] that [resolve]s to a [T] using a [WidgetStateMap].
///
/// Constraints are checked in the order they are provided. The first constraint that is satisfied will have its
/// associated value returned.
///
/// ## Example
/// ```dart
/// final property = FWidgetStateMap<Color>({
///   WidgetState.pressed: Colors.blue,
///   WidgetState.hovered: Colors.green,
/// });
///
/// final color = property.resolve({WidgetState.pressed, WidgetState.hovered});
/// print(color); // Colors.blue
/// ```
class FWidgetStateMap<T> implements WidgetStateProperty<T> {
  final WidgetStateMap<T> _constraints;

  /// Creates a [FWidgetStateMap] with the given constraints.
  const FWidgetStateMap(this._constraints);

  /// Creates a [FWidgetStateMap] which always resolves to the given value.
  FWidgetStateMap.all(T value) : _constraints = {WidgetState.any: value};

  /// Returns a value that depends on [states] by checking the constraints given in [FWidgetStateMap.new].
  ///
  /// ## Contract
  /// Throws an [ArgumentError] if no constraints are satisfied and [T] is non-nullable.
  @override
  T resolve(Set<WidgetState> states) {
    for (final MapEntry(key: constraint, :value) in _constraints.entries) {
      if (constraint.isSatisfiedBy(states)) {
        return value;
      }
    }

    try {
      return null as T;
      // ignore: avoid_catching_errors
    } on TypeError {
      throw ArgumentError(
        'The current set of widget states is $states.\n'
        'None of the provided map keys matched this set, '
        'and the type "$T" is non-nullable.\n'
        'Consider using "FWidgetStateMap<$T?>()", '
        'or adding the "WidgetState.any" key to this property.',
      );
    }
  }

  /// Returns a value that depends on [states] by checking the constraints given in [FWidgetStateMap.new], or
  /// null if no [T] is found.
  T? maybeResolve(Set<WidgetState> states) {
    for (final MapEntry(key: constraint, :value) in _constraints.entries) {
      if (constraint.isSatisfiedBy(states)) {
        return value;
      }
    }

    return null;
  }

  /// Returns a new [FWidgetStateMap] with the same constraints, but with different values produced by [map].
  ///
  /// ## Example
  /// ```dart
  /// final property = FWidgetStateMap<double>({
  ///   WidgetState.pressed: 0.8,
  ///   WidgetState.hovered: 0.9,
  /// });
  ///
  /// // Convert scale factors to Color opacity values.
  /// final opacityProperty = property.map((scale) => Colors.blue.withOpacity(scale));
  /// ```
  @useResult
  FWidgetStateMap<R> map<R>(R Function(T) map) => FWidgetStateMap<R>({
    for (final MapEntry(key: constraint, :value) in _constraints.entries) constraint: map(value),
  });

  /// Creates a new [FWidgetStateMap] where only the first value associated with a constraint satisfied by [states]
  /// is replaced with the result of calling [replace] on the original value.
  ///
  /// Unlike [replaceAllWhere], which modifies all matching values, this method only modifies the first matching value.
  ///
  /// ## Example
  /// ```dart
  /// final property = FWidgetStateMap<Color>({
  ///   WidgetState.pressed: Colors.blue,
  ///   WidgetState.hovered: Colors.green,
  /// });
  ///
  /// // Create a new property with only the first matching state modified.
  /// final modified = property.replaceFirstWhere(
  ///   {WidgetState.pressed, WidgetState.focused},
  ///   (color) => color.withOpacity(0.5),
  /// );
  ///
  /// // Only the 'pressed' state's color will be modified.
  /// ```
  @useResult
  FWidgetStateMap<T> replaceFirstWhere(Set<WidgetState> states, T Function(T) replace) {
    final constraints = {..._constraints};

    for (final key in constraints.keys) {
      if (key.isSatisfiedBy(states)) {
        constraints[key] = replace(constraints[key] as T);
        break;
      }
    }

    return FWidgetStateMap<T>(constraints);
  }

  /// Creates a new [FWidgetStateMap] where only the last value associated with a constraint satisfied by [states]
  /// is replaced with the result of calling [replace] on the original value.
  ///
  /// ## Example
  /// ```dart
  /// final property = FWidgetStateMap<Color>({
  ///   WidgetState.pressed: Colors.blue,
  ///   WidgetState.hovered: Colors.green,
  /// });
  ///
  /// // Create a new property with only the last matching state modified
  /// final modified = property.replaceLastWhere(
  ///   {WidgetState.pressed, WidgetState.focused},
  ///   (color) => color.withOpacity(0.5),
  /// );
  /// // Only the 'hovered' state's color will be modified, 'pressed' remains unchanged
  /// ```
  @useResult
  FWidgetStateMap<T> replaceLastWhere(Set<WidgetState> states, T Function(T) replace) {
    final constraints = {..._constraints};

    for (final key in constraints.keys.toList().reversed) {
      if (key.isSatisfiedBy(states)) {
        constraints[key] = replace(constraints[key] as T);
        break;
      }
    }

    return FWidgetStateMap<T>(constraints);
  }

  /// Creates a new [FWidgetStateMap] where all values associated with constraints satisfied by [states] are
  /// replaced with the result of calling [replace] on the original value.
  ///
  /// ## Example
  /// ```dart
  /// final property = FWidgetStateMap<Color>({
  ///   WidgetState.pressed: Colors.blue,
  ///   WidgetState.hovered: Colors.green,
  /// });
  ///
  /// // Create a new property with darker colors for pressed and hovered states.
  /// final darkened = property.replaceAllWhere(
  ///   {WidgetState.pressed, WidgetState.hovered},
  ///   (color) => color.withOpacity(0.7),
  /// );
  /// ```
  @useResult
  FWidgetStateMap<T> replaceAllWhere(Set<WidgetState> states, T Function(T) replace) => FWidgetStateMap({
    for (final e in _constraints.entries) e.key: e.key.isSatisfiedBy(states) ? replace(e.value) : e.value,
  });
}
