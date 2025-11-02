import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

/// Size constraints for a portal.
sealed class FPortalConstraints extends Constraints {
  /// Creates a [FPortalConstraints] with the given constraints.
  const factory FPortalConstraints({double minWidth, double maxWidth, double minHeight, double maxHeight}) =
      FixedConstraints;

  /// Creates a [FPortalConstraints] that require the given width or height.
  const factory FPortalConstraints.tightFor({double? width, double? height}) = FixedConstraints.tightFor;

  const FPortalConstraints._();
}

@internal
final class FixedConstraints extends BoxConstraints implements FPortalConstraints {
  const FixedConstraints({
    super.minWidth = 0.0,
    super.maxWidth = double.infinity,
    super.minHeight = 0.0,
    super.maxHeight = double.infinity,
  });

  const FixedConstraints.tightFor({super.width, super.height}) : super.tightFor();
}

/// Size constraints for a portal that has the same height as the child widget.
final class FAutoHeightPortalConstraints extends FPortalConstraints {
  /// The minimum width that satisfies the constraints.
  final double minWidth;

  /// The maximum width that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double maxWidth;

  /// Creates a [FPortalConstraints] that has the same height as the child widget.
  const FAutoHeightPortalConstraints({this.minWidth = 0.0, this.maxWidth = double.infinity}) : super._();

  /// Creates a [FPortalConstraints] that has the same height as the child widget.
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
  String toString() => 'FAutoHeightPortalConstraints(minWidth: $minWidth, maxWidth: $maxWidth)';
}

/// Size constraints for a portal that has the same width as the child widget.
final class FAutoWidthPortalConstraints extends FPortalConstraints {
  /// The minimum height that satisfies the constraints.
  final double minHeight;

  /// The maximum height that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double maxHeight;

  /// Creates a [FPortalConstraints] that has the same width as the child widget.
  const FAutoWidthPortalConstraints({this.minHeight = 0.0, this.maxHeight = double.infinity}) : super._();

  /// Creates a [FPortalConstraints] that has the same width as the child widget.
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
  String toString() => 'FAutoWidthPortalConstraints(minHeight: $minHeight, maxHeight: $maxHeight)';
}
