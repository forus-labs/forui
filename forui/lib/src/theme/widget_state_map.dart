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
  /// Linearly interpolate between two [FWidgetStateMap]s of [BoxDecoration]s.
  ///
  /// {@macro forui.foundation.FWidgetStateMap.lerpWhere}
  static FWidgetStateMap<BoxDecoration> lerpBoxDecoration(
    FWidgetStateMap<BoxDecoration> a,
    FWidgetStateMap<BoxDecoration> b,
    double t,
  ) => lerpWhere(a, b, t, BoxDecoration.lerp);

  /// Linearly interpolate between two [FWidgetStateMap]s of [Color]s.
  ///
  /// {@macro forui.foundation.FWidgetStateMap.lerpWhere}
  static FWidgetStateMap<Color> lerpColor(FWidgetStateMap<Color> a, FWidgetStateMap<Color> b, double t) =>
      lerpWhere(a, b, t, Color.lerp);

  /// Linearly interpolate between two [FWidgetStateMap]s of icon theme data.
  ///
  /// {@macro forui.foundation.FWidgetStateMap.lerpWhere}
  static FWidgetStateMap<IconThemeData> lerpIconThemeData(
    FWidgetStateMap<IconThemeData> a,
    FWidgetStateMap<IconThemeData> b,
    double t,
  ) => lerpWhere(a, b, t, IconThemeData.lerp);

  /// Linearly interpolate between two [FWidgetStateMap]s of text styles.
  ///
  /// {@macro forui.foundation.FWidgetStateMap.lerpWhere}
  static FWidgetStateMap<TextStyle> lerpTextStyle(
    FWidgetStateMap<TextStyle> a,
    FWidgetStateMap<TextStyle> b,
    double t,
  ) => lerpWhere(a, b, t, TextStyle.lerp);

  /// Linearly interpolate between two [FWidgetStateMap]s using the provided [lerp] function.
  ///
  /// Consider using [lerpBoxDecoration], [lerpColor], [lerpIconThemeData], or [lerpTextStyle].
  ///
  /// {@template forui.foundation.FWidgetStateMap.lerpWhere}
  /// ## Constraint operand order matters
  /// TL;DR: Always make sure that constraint operands are exactly the same across [a] and [b].
  ///
  /// [WidgetStatesConstraint]s are not commutative. Reversed constraint operands (like `.hovered & .pressed` vs
  /// `.pressed & .hovered`) are treated as distinct keys.
  ///
  /// For each constraint in either map, [lerp] is called with the values from both maps, using null for missing values.
  ///
  /// ```dart
  /// WidgetState.pressed && Widget
  /// final a = FWidgetStateMap<double>({
  ///   WidgetState.pressed: 1.0,
  ///   WidgetState.hovered & Widget.focused: 0.8,
  /// });
  ///
  /// final b = FWidgetStateMap<double>({
  ///   WidgetState.pressed: 0.5,
  ///   WidgetState.focused & Widget.focused: 0.9,
  /// });
  ///
  /// final result = FWidgetStateMap.lerpWhere(a, b, 0.5, lerpDouble);
  /// // Result contains:
  /// // - .pressed: 0.75 (lerp between 1.0 and 0.5)
  /// // - .hovered & .focused: 0.4 (lerp between 0.8 and null)
  /// // - .focused & .hovered: 0.45 (lerp between null and 0.9)
  /// ```
  ///
  /// As [resolve] treats state combinations as equivalent regardless of order, `{.hovered & .focused}` will always
  /// return 0.4, the first matching constraint, and never 0.45, the last matching constraint.
  /// {@endtemplate}
  static FWidgetStateMap<T> lerpWhere<T>(
    FWidgetStateMap<T> a,
    FWidgetStateMap<T> b,
    double t,
    T? Function(T?, T?, double) lerp,
  ) {
    final visited = <WidgetStatesConstraint>{};
    final constraints = <WidgetStatesConstraint, T>{};

    for (final MapEntry(key: constraint, :value) in a._constraints.entries) {
      visited.add(constraint);
      if (lerp(value, b._constraints[constraint], t) case final lerped?) {
        constraints[constraint] = lerped;
      }
    }

    for (final MapEntry(key: constraint, :value) in b._constraints.entries) {
      if (!visited.contains(constraint)) {
        if (lerp(a._constraints[constraint], value, t) case final lerped?) {
          constraints[constraint] = lerped;
        }
      }
    }

    return FWidgetStateMap(constraints);
  }

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
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/docs/themes#customization)
  /// and directly modify its `FWidgetStateMap` fields instead.
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
  /// To replace values associated with [WidgetState.any], pass in an empty set.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/docs/themes#customization)
  /// and directly modify its `FWidgetStateMap` fields instead.
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
  /// To replace values associated with [WidgetState.any], pass in an empty set.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/docs/themes#customization)
  /// and directly modify its `FWidgetStateMap` fields instead.
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
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/docs/themes#customization)
  /// and directly modify its `FWidgetStateMap` fields instead.
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

  @override
  String toString() => 'FWidgetStateMap{$_constraints}';
}
