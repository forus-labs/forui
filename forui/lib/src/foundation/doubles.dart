import 'package:meta/meta.dart';

const _epsilon = 1e-10;

@internal
extension Doubles on double {
  /// Returns true if this double is almost equal to [other].
  bool around(double other) => (this - other).abs() < _epsilon;

  /// Returns true if this double is less than or approximately equal to [other].
  bool lessOrAround(double other) => this < other || (this - other).abs() < _epsilon;

  /// Returns true if this double is greater than or approximately equal to [other].
  bool greaterOrAround(double other) => this > other || (this - other).abs() < _epsilon;
}
