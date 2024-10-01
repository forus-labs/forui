import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/assets.dart';

/// The default properties of [FIcon]s in a widget subtree.
class FIconData extends InheritedWidget {
  /// The data from the closest instance of this class that encloses the given context, if any.
  static FIconData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FIconData>();

  /// The icon's color.
  final Color color;

  /// The icon's size.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `size` is not positive.
  final double size;

  /// Creates a [FIconData].
  const FIconData({
    required this.color,
    required this.size,
    required super.child,
    super.key,
  }) : assert(0 < size, 'size is $size, but it should be positive.');

  @override
  bool updateShouldNotify(FIconData old) => color != old.color || size != old.size;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('size', size));
  }
}

/// A graphical icon widget that inherits from a [FIconData], if any.
abstract class FIcon extends StatelessWidget {
  /// The icon's color.
  final Color? color;

  /// The icon's size.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `size` <= 0.0
  final double? size;

  /// The icon's semantic label.
  final String? semanticLabel;

  /// Creates a [FIcon] from a [SvgAsset].
  const factory FIcon(
    SvgAsset icon, {
    bool matchTextDirection,
    BoxFit fit,
    AlignmentGeometry alignment,
    bool allowDrawingOutsideViewBox,
    WidgetBuilder? placeholderBuilder,
    bool excludeFromSemantics,
    Clip clipBehavior,
    Color color,
    double size,
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
    TextDirection textDirection,
    bool applyTextScaling,
    Color color,
    double size,
    String semanticLabel,
    Key? key,
  }) = _IconDataIcon;

  /// Creates a [FIcon] from an [ImageProvider].
  ///
  /// See [ImageIcon] for more information.
  const factory FIcon.image(
    ImageProvider<Object> image, {
    Color color,
    double size,
    String semanticLabel,
    Key? key,
  }) = _ImageProviderIcon;

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
  final bool excludeFromSemantics;
  final Clip clipBehavior;

  const _Icon(
    this.icon, {
    this.matchTextDirection = false,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    super.color,
    super.size,
    super.semanticLabel,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final data = FIconData.maybeOf(context);
    final color = this.color ?? data?.color;

    return icon.call(
      colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
      height: size ?? data?.size,
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
      ..add(FlagProperty('excludeFromSemantics', value: excludeFromSemantics, ifTrue: 'exclude from semantics'))
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
    final data = FIconData.maybeOf(context);
    final color = this.color ?? data?.color;
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
      color: color,
      size: size ?? data?.size,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('icon', icon))
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
    final data = FIconData.maybeOf(context);
    return ImageIcon(
      image,
      color: color ?? data?.color,
      size: size ?? data?.size,
      semanticLabel: semanticLabel,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('image', image));
  }
}
