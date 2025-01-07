import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// The [FIconStyle] that this [FIconStyleData]'s widget subtree should inherit.
class FIconStyleData extends InheritedWidget {
  /// The icon's data.
  final FIconStyle style;

  /// Creates a [FIconStyle].
  const FIconStyleData({
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FIconStyleData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// The default properties of [FIcon]s in a widget subtree.
class FIconStyle with Diagnosticable {
  /// The icon style from the closest instance of [FIconStyleData] that encloses the given context, or
  /// [FStyle.iconStyle] otherwise.
  static FIconStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FIconStyleData>()?.style ?? context.theme.style.iconStyle;

  /// The icon's color.
  final Color color;

  /// The icon's size.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `size` is not positive.
  final double size;

  /// Creates a [FIconStyle].
  const FIconStyle({
    required this.color,
    required this.size,
  }) : assert(0 < size, 'size is $size, but it should be positive.');

  /// Returns a copy of this [FIconStyle] but with the given fields replaced with the new values.
  @useResult
  FIconStyle copyWith({Color? color, double? size}) => FIconStyle(
        color: color ?? this.color,
        size: size ?? this.size,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FIconStyle && runtimeType == other.runtimeType && color == other.color && size == other.size;

  @override
  int get hashCode => color.hashCode ^ size.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('size', size));
  }
}

/// A graphical icon widget that inherits its style from an [FIconStyle], if any.
///
/// [FIconStyle] allows icons to be automatically configured by an enclosing widget. It is explicitly mentioned in
/// a widget's documentation, such as [FButton.icon], if it provides an [FIconStyle]. [FIcon] defaults to
/// [FStyle.iconStyle] otherwise.
///
/// See:
/// * https://forui.dev/docs/data/icon for working examples.
/// * [FIconStyle] for the properties that can be inherited.
/// * [FAssets.icons] for bundled Forui icons.
abstract class FIcon extends StatelessWidget {
  static final _empty = FIcon(FAssets.icons.check, color: Colors.transparent);

  /// The icon's color.
  final Color? color;

  /// The icon's size.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `size` <= 0.0
  final double? size;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticLabel;

  /// Creates a [FIcon] from a [SvgAsset].
  const factory FIcon(
    SvgAsset icon, {
    bool matchTextDirection,
    BoxFit fit,
    AlignmentGeometry alignment,
    bool allowDrawingOutsideViewBox,
    WidgetBuilder? placeholderBuilder,
    Clip clipBehavior,
    Color? color,
    double? size,
    String? semanticLabel,
    Key? key,
  }) = _Icon;

  /// Creates a [FIcon] from an [IconData].
  ///
  /// See [Icon] for more information.
  const factory FIcon.data(
    IconData data, {
    double fill,
    double weight,
    double grade,
    double opticalSize,
    List<Shadow> shadows,
    TextDirection? textDirection,
    bool applyTextScaling,
    Color? color,
    double? size,
    String? semanticLabel,
    Key? key,
  }) = _IconDataIcon;

  /// Creates a [FIcon] from an [ImageProvider].
  ///
  /// **Note:** Provided images should always have a transparent background. Otherwise, the entire icon will be [color].
  ///
  /// Set [color] to [Colors.transparent] to avoid recoloring the image.
  ///
  /// See [ImageIcon] for more information.
  const factory FIcon.image(
    ImageProvider<Object> image, {
    Color? color,
    double? size,
    String? semanticLabel,
    Key? key,
  }) = _ImageProviderIcon;

  /// Creates a [FIcon] from a [ValueWidgetBuilder].
  ///
  /// To access widget-specific data, i.e. [FButtonData] inside a [FButton]:
  /// ```dart
  /// FButton.icon(
  ///   icon: FIcon.raw(
  ///     builder: (context, style, _) {
  ///       final data = FButtonData.of(context);
  ///       final someWidget = ... // Create someWidget using data here
  ///       return someWidget;
  ///     },
  /// );
  /// ```
  const factory FIcon.raw({required ValueWidgetBuilder<FIconStyle> builder, Widget? child, Key? key}) = _BuilderIcon;

  /// Creates a placeholder icon.
  factory FIcon.empty({double? size}) =>
      size == null ? _empty : FIcon(FAssets.icons.check, color: Colors.transparent, size: size);

  const FIcon._({required this.color, this.size, this.semanticLabel, super.key});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('size', size))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _Icon extends FIcon {
  final SvgAsset icon;
  final bool matchTextDirection;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool allowDrawingOutsideViewBox;
  final WidgetBuilder? placeholderBuilder;
  final Clip clipBehavior;

  const _Icon(
    this.icon, {
    this.matchTextDirection = false,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.clipBehavior = Clip.hardEdge,
    super.color,
    super.size,
    super.semanticLabel,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final data = FIconStyle.of(context);
    return Semantics(
      label: semanticLabel,
      child: icon.call(
        matchTextDirection: matchTextDirection,
        fit: fit,
        alignment: alignment,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
        placeholderBuilder: placeholderBuilder,
        excludeFromSemantics: true,
        clipBehavior: clipBehavior,
        colorFilter: ColorFilter.mode(color ?? data.color, BlendMode.srcIn),
        height: size ?? data.size,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('icon', icon))
      ..add(FlagProperty('matchTextDirection', value: matchTextDirection, ifTrue: 'match text direction'))
      ..add(EnumProperty('fit', fit))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(
        FlagProperty(
          'allowDrawingOutsideViewBox',
          value: allowDrawingOutsideViewBox,
          ifTrue: 'allow drawing outside view box',
        ),
      )
      ..add(ObjectFlagProperty.has('placeholderBuilder', placeholderBuilder))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(EnumProperty('clipBehavior', clipBehavior));
  }
}

class _IconDataIcon extends FIcon {
  final IconData icon;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final TextDirection? textDirection;
  final bool applyTextScaling;

  const _IconDataIcon(
    this.icon, {
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.shadows,
    this.textDirection,
    this.applyTextScaling = true,
    super.color,
    super.size,
    super.semanticLabel,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final data = FIconStyle.of(context);
    return Icon(
      icon,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      shadows: shadows,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
      applyTextScaling: applyTextScaling,
      color: color ?? data.color,
      size: size ?? data.size,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IconDataProperty('icon', icon))
      ..add(DoubleProperty('fill', fill))
      ..add(DoubleProperty('weight', weight))
      ..add(DoubleProperty('grade', grade))
      ..add(DoubleProperty('opticalSize', opticalSize))
      ..add(IterableProperty('shadows', shadows))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(EnumProperty('direction', textDirection))
      ..add(FlagProperty('applyTextScaling', value: applyTextScaling, ifTrue: 'apply text scaling'));
  }
}

class _ImageProviderIcon extends FIcon {
  final ImageProvider<Object> image;

  const _ImageProviderIcon(
    this.image, {
    super.color,
    super.size,
    super.semanticLabel,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final data = FIconStyle.of(context);
    return Semantics(
      label: semanticLabel,
      child: Image(
        image: image,
        height: size ?? data.size,
        width: size ?? data.size,
        color: color == Colors.transparent ? null : (color ?? data.color),
        fit: BoxFit.scaleDown,
        excludeFromSemantics: true,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('image', image));
  }
}

class _BuilderIcon extends FIcon {
  final ValueWidgetBuilder<FIconStyle> builder;
  final Widget? child;

  const _BuilderIcon({required this.builder, this.child, super.key}) : super._(color: null, size: null);

  @override
  Widget build(BuildContext context) => builder(context, FIconStyle.of(context), child);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('builder', builder));
  }
}
