import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class ResizeUpIntent extends Intent {
  const ResizeUpIntent();
}

@internal
class ResizeDownIntent extends Intent {
  const ResizeDownIntent();
}

@internal
sealed class Divider extends StatelessWidget {
  final FResizableController controller;
  final FResizableDividerStyle style;
  final FResizableDivider type;
  final ({int left, int right}) indexes;
  final double? crossAxisExtent;
  final double hitRegionExtent;
  final MouseCursor cursor;

  Divider({
    required this.controller,
    required this.style,
    required this.type,
    required this.indexes,
    required this.crossAxisExtent,
    required this.hitRegionExtent,
    required this.cursor,
    super.key,
  })  : assert(0 <= indexes.left, 'Left should be non-negative, but is ${indexes.left}.'),
        assert(indexes.left + 1 == indexes.right, 'Left and right should be next to each other.');

  Widget focusableActionDetector({required List<Widget> children}) => MouseRegion(
        cursor: cursor,
        child: Semantics(
          slider: true,
          child: Shortcuts(
            shortcuts: shortcuts,
            child: Actions(
              actions: {
                ResizeUpIntent: CallbackAction<ResizeUpIntent>(
                  onInvoke: (intent) => controller.update(indexes.left, indexes.right, -3),
                ),
                ResizeDownIntent: CallbackAction<ResizeDownIntent>(
                  onInvoke: (intent) => controller.update(indexes.left, indexes.right, 3),
                ),
              },
              child: Focus(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      );

  Map<ShortcutActivator, Intent> get shortcuts;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('indexes', indexes))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('hitRegionExtent', hitRegionExtent))
      ..add(DiagnosticsProperty('cursor', cursor))
      ..add(DiagnosticsProperty('shortcuts', shortcuts));
  }
}

@internal
class HorizontalDivider extends Divider {
  HorizontalDivider({
    required super.controller,
    required super.style,
    required super.type,
    required super.indexes,
    required super.crossAxisExtent,
    required super.hitRegionExtent,
    required super.cursor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        left: controller.regions[indexes.left].offset.max - (hitRegionExtent / 2),
        child: focusableActionDetector(
          children: [
            if (type == FResizableDivider.divider || type == FResizableDivider.dividerWithThumb)
              ColoredBox(
                color: style.color,
                child: SizedBox(
                  height: crossAxisExtent,
                  width: style.thickness,
                ),
              ),
            if (type == FResizableDivider.dividerWithThumb)
              _Thumb(
                style: style.thumbStyle,
                icon: FAssets.icons.gripVertical,
              ),
            SizedBox(
              height: crossAxisExtent,
              width: hitRegionExtent,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx == 0.0) {
                    return;
                  }

                  controller.update(indexes.left, indexes.right, details.delta.dx);
                  // TODO: haptic feedback
                },
                onHorizontalDragEnd: (details) => controller.end(indexes.left, indexes.right),
              ),
            ),
          ],
        ),
      );

  @override
  Map<ShortcutActivator, Intent> get shortcuts => const {
        SingleActivator(LogicalKeyboardKey.arrowLeft): ResizeUpIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight): ResizeDownIntent(),
      };
}

@internal
class VerticalDivider extends Divider {
  VerticalDivider({
    required super.controller,
    required super.style,
    required super.type,
    required super.indexes,
    required super.crossAxisExtent,
    required super.hitRegionExtent,
    required super.cursor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        top: controller.regions[indexes.left].offset.max - (hitRegionExtent / 2),
        child: focusableActionDetector(
          children: [
            if (type == FResizableDivider.divider || type == FResizableDivider.dividerWithThumb)
              ColoredBox(
                color: style.color,
                child: SizedBox(
                  height: style.thickness,
                  width: crossAxisExtent,
                ),
              ),
            if (type == FResizableDivider.dividerWithThumb)
              _Thumb(
                style: style.thumbStyle,
                icon: FAssets.icons.gripHorizontal,
              ),
            SizedBox(
              height: hitRegionExtent,
              width: crossAxisExtent,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy == 0.0) {
                    return;
                  }

                  controller.update(indexes.left, indexes.right, details.delta.dy);
                  // TODO: haptic feedback
                },
                onVerticalDragEnd: (details) => controller.end(indexes.left, indexes.right),
              ),
            ),
          ],
        ),
      );

  @override
  Map<ShortcutActivator, Intent> get shortcuts => const {
        SingleActivator(LogicalKeyboardKey.arrowUp): ResizeUpIntent(),
        SingleActivator(LogicalKeyboardKey.arrowDown): ResizeDownIntent(),
      };
}

class _Thumb extends StatelessWidget {
  final FResizableDividerThumbStyle style;
  final SvgAsset icon;

  const _Thumb({required this.style, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        height: style.height,
        width: style.width,
        child: icon(
          colorFilter: ColorFilter.mode(style.foregroundColor, BlendMode.srcIn),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

/// The type of dividers between [FResizableRegion]s.
enum FResizableDivider {
  /// No divider.
  none,

  /// Divider without thumb.
  divider,

  /// Divider with thumb.
  dividerWithThumb,
}

/// The style of the dividers between [FResizableRegion]s.
final class FResizableDividerStyle with Diagnosticable {
  /// The divider's color.
  final Color color;

  /// The divider's thickness. Defaults to `0.5`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [thickness] <= 0.
  final double thickness;

  /// The divider thumb's style.
  final FResizableDividerThumbStyle thumbStyle;

  /// Creates a [FResizableDividerStyle].
  FResizableDividerStyle({
    required this.color,
    required this.thumbStyle,
    this.thickness = 0.5,
  }) : assert(0 < thickness, 'Thickness should be positive, but is $thickness.');

  /// Returns a copy of this but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FResizableDividerStyle(
  ///   color: ...,
  ///   thickness: ...,
  /// );
  ///
  /// final copy = style.copyWith(thickness: ...);
  ///
  /// print(style.color == copy.color); // true
  /// print(style.thickness == copy.thickness); // false
  /// ```
  @useResult
  FResizableDividerStyle copyWith({
    Color? color,
    double? thickness,
    FResizableDividerThumbStyle? thumbStyle,
  }) =>
      FResizableDividerStyle(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        thumbStyle: thumbStyle ?? this.thumbStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('thickness', thickness))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableDividerStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          thickness == other.thickness &&
          thumbStyle == other.thumbStyle;

  @override
  int get hashCode => color.hashCode ^ thickness.hashCode ^ thumbStyle.hashCode;
}

/// The style of the dividers' thumbs between [FResizableRegion]s.
final class FResizableDividerThumbStyle with Diagnosticable {
  /// The background color.
  final Color backgroundColor;

  /// The foreground color.
  final Color foregroundColor;

  /// The height.
  ///
  /// ## Contract
  /// Throws [AssertionError] if height] <= 0.
  final double height;

  /// The width.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [width] <= 0.
  final double width;

  /// Creates a [FResizableDividerThumbStyle].
  FResizableDividerThumbStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.height,
    required this.width,
  })  : assert(0 < height, 'Height should be positive, but is $height.'),
        assert(0 < width, 'Width should be positive, but is $width.');

  /// Returns a copy of this but with the given fields replaced with the new values.
  @useResult
  FResizableDividerThumbStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? height,
    double? width,
  }) =>
      FResizableDividerThumbStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
        height: height ?? this.height,
        width: width ?? this.width,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableDividerThumbStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          height == other.height &&
          width == other.width;

  @override
  int get hashCode => backgroundColor.hashCode ^ foregroundColor.hashCode ^ height.hashCode ^ width.hashCode;
}
