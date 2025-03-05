import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// A [WidgetStateProperty] that uses a [WidgetStateMap] to resolve to a single value of type `T` based on the current
/// set of Widget states.
class FWidgetStateMap<T> with MapBase<WidgetStatesConstraint, T>, Diagnosticable implements WidgetStateProperty<T> {
  final WidgetStateMap<T> _map;

  /// Creates a [FWidgetStateMap] object that can resolve to a value of type [T] using the provided [map].
  const FWidgetStateMap(WidgetStateMap<T> map) : _map = map;

  @override
  T resolve(Set<WidgetState> states) {
    for (final MapEntry(:key, :value) in _map.entries) {
      if (key.isSatisfiedBy(states)) {
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
        'Consider using "WidgetStateProperty<$T?>.fromMap()", '
        'or adding the "WidgetState.any" key to this map.',
      );
    }
  }

  /// Returns the value that satifies the given [states], or `null` if none do.
  T? maybeResolve(Set<WidgetState> states) {
    for (final MapEntry(:key, :value) in _map.entries) {
      if (key.isSatisfiedBy(states)) {
        return value;
      }
    }

    return null;
  }

  /// Returns a new [FWidgetStateMap] with the contents of the given [map] replacing existing values.
  @useResult
  FWidgetStateMap<T> copyWith(WidgetStateMap<T> map) => FWidgetStateMap<T>(map);

  @override
  T? operator [](Object? key) => _map[key];

  @override
  void operator []=(WidgetStatesConstraint key, T value) => _map[key] = value;

  @override
  T? remove(Object? key) => _map.remove(key);

  @override
  void clear() => _map.clear();

  @override
  bool operator ==(Object other) => other is FWidgetStateMap<T> && mapEquals(_map, other._map);

  @override
  int get hashCode => const MapEquality().hash(_map);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => 'FWidgetStateMap<$T>($_map)';

  @override
  Never noSuchMethod(Invocation invocation) {
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'There was an attempt to access the "${invocation.memberName}" '
        'field of a WidgetStateMapper<$T> object.',
      ),
      ErrorDescription('$this'),
      ErrorDescription(
        'WidgetStateProperty objects should only be used '
        'in places that document their support.',
      ),
      ErrorHint(
        'Double-check whether the map was used in a place that '
        'documents support for WidgetStateProperty objects. If so, '
        'please file a bug report. (The https://pub.dev/ page for a package '
        'contains a link to "View/report issues".)',
      ),
    ]);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties, {String prefix = ''}) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WidgetStateMap<T>>('map', _map));
  }
}
