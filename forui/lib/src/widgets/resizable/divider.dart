import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

class _Up extends Intent {
  const _Up();
}

class _Down extends Intent {
  const _Down();
}

@internal
sealed class Divider extends StatelessWidget {
  final FResizableController controller;
  final FResizableDividerStyle style;
  final FResizableDivider type;
  final int left;
  final int right;
  final double? crossAxisExtent;
  final double hitRegionExtent;
  final double resizePercentage;
  final MouseCursor cursor;
  final String Function(FResizableRegionData, FResizableRegionData) semanticFormatterCallback;

  const Divider({
    required this.controller,
    required this.style,
    required this.type,
    required this.left,
    required this.right,
    required this.crossAxisExtent,
    required this.hitRegionExtent,
    required this.resizePercentage,
    required this.cursor,
    required this.semanticFormatterCallback,
    super.key,
  })  : assert(0 <= left, 'Left child should be non-negative, but is $left.'),
        assert(left + 1 == right, 'Left and right should be next to each other.');

  Widget focusableActionDetector({
    required Map<ShortcutActivator, Intent> shortcuts,
    required List<Widget> children,
  }) =>
      Semantics(
        value: semanticFormatterCallback(controller.regions[left], controller.regions[right]),
        child: FocusableActionDetector(
          mouseCursor: cursor,
          shortcuts: shortcuts,
          actions: {
            _Up: CallbackAction(
              onInvoke: (_) =>
                  controller.update(left, right, -resizePercentage * (controller.regions[left].extent.total)),
            ),
            _Down: CallbackAction(
              onInvoke: (_) =>
                  controller.update(left, right, resizePercentage * (controller.regions[left].extent.total)),
            ),
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: children,
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('type', type))
      ..add(IntProperty('left', left))
      ..add(IntProperty('right', right))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('hitRegionExtent', hitRegionExtent))
      ..add(DoubleProperty('resizePercentage', resizePercentage))
      ..add(DiagnosticsProperty('cursor', cursor))
      ..add(DiagnosticsProperty('semanticFormatterCallback', semanticFormatterCallback));
  }
}

@internal
class HorizontalDivider extends Divider {
  const HorizontalDivider({
    required super.controller,
    required super.style,
    required super.type,
    required super.left,
    required super.right,
    required super.crossAxisExtent,
    required super.hitRegionExtent,
    required super.resizePercentage,
    required super.cursor,
    required super.semanticFormatterCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        left: controller.regions[left].offset.max - (hitRegionExtent / 2),
        child: focusableActionDetector(
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.arrowLeft): _Up(),
            SingleActivator(LogicalKeyboardKey.arrowRight): _Down(),
          },
          children: [
            if (type == FResizableDivider.divider || type == FResizableDivider.dividerWithThumb)
              ColoredBox(
                color: style.color,
                child: SizedBox(
                  height: crossAxisExtent,
                  width: style.width,
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
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx == 0.0) {
                    return;
                  }

                  controller.update(left, right, details.delta.dx);
                  // TODO: haptic feedback
                },
                onHorizontalDragEnd: (details) => controller.end(left, right),
              ),
            ),
          ],
        ),
      );
}

@internal
class VerticalDivider extends Divider {
  const VerticalDivider({
    required super.controller,
    required super.style,
    required super.type,
    required super.left,
    required super.right,
    required super.crossAxisExtent,
    required super.hitRegionExtent,
    required super.resizePercentage,
    required super.cursor,
    required super.semanticFormatterCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        top: controller.regions[left].offset.max - (hitRegionExtent / 2),
        child: focusableActionDetector(
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.arrowUp): _Up(),
            SingleActivator(LogicalKeyboardKey.arrowDown): _Down(),
          },
          children: [
            if (type == FResizableDivider.divider || type == FResizableDivider.dividerWithThumb)
              ColoredBox(
                color: style.color,
                child: SizedBox(
                  height: style.width,
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
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy == 0.0) {
                    return;
                  }

                  controller.update(left, right, details.delta.dy);
                  // TODO: haptic feedback
                },
                onVerticalDragEnd: (details) => controller.end(left, right),
              ),
            ),
          ],
        ),
      );
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

/// The appearance of dividers between [FResizableRegion]s.
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

  /// The divider's width (thickness). Defaults to `0.5`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [width] <= 0.
  final double width;

  /// The divider thumb's style.
  final FResizableDividerThumbStyle thumbStyle;

  /// Creates a [FResizableDividerStyle].
  FResizableDividerStyle({
    required this.color,
    required this.thumbStyle,
    this.width = 0.5,
  }) : assert(0 < width, 'Thickness should be positive, but is $width.');

  /// Returns a copy of this but with the given fields replaced with the new values.
  @useResult
  FResizableDividerStyle copyWith({
    Color? color,
    double? width,
    FResizableDividerThumbStyle? thumbStyle,
  }) =>
      FResizableDividerStyle(
        color: color ?? this.color,
        width: width ?? this.width,
        thumbStyle: thumbStyle ?? this.thumbStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableDividerStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          width == other.width &&
          thumbStyle == other.thumbStyle;

  @override
  int get hashCode => color.hashCode ^ width.hashCode ^ thumbStyle.hashCode;
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
