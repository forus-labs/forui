import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

/// A marker interface that denotes that mixed-in types are transformable.
mixin FTransformable {}

/// Provides functions to transform a [T] using a given function.
extension FTransformables<T extends FTransformable> on T {
  /// Transform this [T] using the given [function].
  ///
  /// This should be used in conjunction with `copyWith` to update deeply nested properties that rely on this [T].
  ///
  // This function cannot be implemented directly in [FTransformable] as the callback accepts a self-referencing type.
  // It prevents mixed-in types from being inherited.
  T transform(T Function(T) function) => function(this);
}
