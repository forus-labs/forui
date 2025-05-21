import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

/// Immutable layout constraints for a portal's [RenderBox].
sealed class FPortalConstraints extends Constraints {
  /// Creates a [FPortalConstraints] with the given constraints.
  const factory FPortalConstraints({
    double minWidth,
    double maxWidth,
    double minHeight,
    double maxHeight,
  }) = FixedConstraints;

  /// Creates a [FPortalConstraints] that require the given width or height.
  const factory FPortalConstraints.tightFor({double? width, double? height}) =
      FixedConstraints.tightFor;

  const FPortalConstraints._();
}

@internal
final class FixedConstraints extends BoxConstraints
    implements FPortalConstraints {
  const FixedConstraints({
    super.minWidth = 0.0,
    super.maxWidth = double.infinity,
    super.minHeight = 0.0,
    super.maxHeight = double.infinity,
  });

  const FixedConstraints.tightFor({super.width, super.height})
    : super.tightFor();
}

/// Immutable layout constraints for a portal's [RenderBox] which height is automatically derived from the child.
final class FAutoHeightPortalConstraints extends FPortalConstraints {
  /// The minimum width that satisfies the constraints.
  final double minWidth;

  /// The maximum width that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double maxWidth;

  /// Creates a [FPortalConstraints] that automatically derive the height from the child.
  const FAutoHeightPortalConstraints({
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
  }) : super._();

  /// Creates a [FPortalConstraints] that automatically derive the height from the child and require the given width.
  const FAutoHeightPortalConstraints.tightFor({double? width})
    : minWidth = width ?? 0,
      maxWidth = width ?? double.infinity,
      super._();

  @override
  bool get isNormalized => false;

  @override
  bool get isTight => minWidth >= maxWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAutoHeightPortalConstraints &&
          runtimeType == other.runtimeType &&
          minWidth == other.minWidth &&
          maxWidth == other.maxWidth;

  @override
  int get hashCode => Object.hash(minWidth, maxWidth);

  @override
  String toString() =>
      'FAutoHeightPortalConstraints(minWidth: $minWidth, maxWidth: $maxWidth)';
}

/// Immutable layout constraints for a portal's [RenderBox] which width is automatically derived from the child.
final class FAutoWidthPortalConstraints extends FPortalConstraints {
  /// The minimum height that satisfies the constraints.
  final double minHeight;

  /// The maximum height that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double maxHeight;

  /// Creates a [FPortalConstraints] that automatically derive the width from the child.
  const FAutoWidthPortalConstraints({
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  }) : super._();

  /// Creates a [FPortalConstraints] that automatically derive the width from the child and require the given height.
  const FAutoWidthPortalConstraints.tightFor({double? height})
    : minHeight = height ?? 0,
      maxHeight = height ?? double.infinity,
      super._();

  @override
  bool get isNormalized => false;

  @override
  bool get isTight => minHeight >= maxHeight;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAutoWidthPortalConstraints &&
          runtimeType == other.runtimeType &&
          minHeight == other.minHeight &&
          maxHeight == other.maxHeight;

  @override
  int get hashCode => Object.hash(minHeight, maxHeight);

  @override
  String toString() =>
      'FAutoWidthPortalConstraints(minHeight: $minHeight, maxHeight: $maxHeight)';
}
