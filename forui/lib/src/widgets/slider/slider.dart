import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/bar.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:meta/meta.dart';

class FSlider extends StatefulWidget {
  static String _percentages(FSliderData data) => '${data.offsetPercentage.min}% - ${data.offsetPercentage.max}%';

  /// The controller.
  final FSliderController controller;

  /// The style.
  final FSliderStyle? style;

  /// The layout. Defaults to [Layout.ltr].
  final Layout layout;

  /// True if this slider is enabled. Defaults to true.
  final bool enabled;

  /// A callback that formats the semantic label for the slider. Defaults to announcing the percentages of the filled
  /// region.
  final String Function(FSliderData) semanticFormatterCallback;

  /// Creates a [FSlider].
  const FSlider({
    required this.controller,
    this.style,
    this.layout = Layout.ltr,
    this.enabled = true,
    this.semanticFormatterCallback = _percentages,
    super.key,
  });

  @override
  State<FSlider> createState() => _FSliderState();
}

class _FSliderState extends State<FSlider> {
  @override
  Widget build(BuildContext context) {
    final styles = context.theme.sliderStyles;
    final style = widget.style ?? (widget.enabled ? styles.enabledStyle : styles.disabledStyle);

    return Semantics(
      slider: true,
      child: InheritedData(
        controller: widget.controller,
        style: style,
        layout: widget.layout,
        enabled: widget.enabled,
        child: LayoutBuilder(
          builder: (context, constraints) => CustomMultiChildLayout(
            delegate: _SliderLayoutDelegate(),
            children: [
              for (final mark in widget.controller.marks)
                if (mark case FSliderMark(style: final markStyle, :final label?))
                  LayoutId(
                    id: mark,
                    child: DefaultTextStyle(
                      style: (markStyle ?? style.markStyle).labelTextStyle,
                      child: label,
                    ),
                  ),
              LayoutId(
                id: _SliderLayoutDelegate._bar,
                child: const Bar(),
              ),
              if (widget.controller.growable.min)
                LayoutId(
                  id: _SliderLayoutDelegate._minThumb,
                  child: const Thumb(
                    min: true,
                  ),
                ),
              if (widget.controller.growable.max)
                LayoutId(
                  id: _SliderLayoutDelegate._maxThumb,
                  child: const Thumb(
                    min: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderLayoutDelegate extends MultiChildLayoutDelegate {
  static const _bar = Object();
  static const _minThumb = Object();
  static const _maxThumb = Object();

  @override
  void performLayout(Size size) {
    // TODO: implement performLayout
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    throw UnimplementedError();
  }
}

/// A slider's styles.
final class FSliderStyles with Diagnosticable {
  /// The enabled slider's style.
  final FSliderStyle enabledStyle;

  /// The disabled slider's style.
  final FSliderStyle disabledStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({
    required this.enabledStyle,
    required this.disabledStyle,
  });

  /// Creates a [FSliderStyles] that inherits its properties from the given [FColorScheme].
  FSliderStyles.inherit({required FColorScheme colorScheme, required FTypography typography})
      : enabledStyle = FSliderStyle(
          activeColor: colorScheme.primary,
          inactiveColor: colorScheme.secondary,
          markStyle: FSliderMarkStyle(
            color: colorScheme.mutedForeground,
            labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground),
            labelAnchor: Alignment.center,
            labelCrossAxisOffset: 10,
          ),
          thumbStyle: FSliderThumbStyle(
            color: colorScheme.primaryForeground,
            borderColor: colorScheme.primary,
          ),
        ),
        disabledStyle = FSliderStyle(
          activeColor: colorScheme.primary.withOpacity(0.7),
          inactiveColor: colorScheme.secondary,
          markStyle: FSliderMarkStyle(
            color: colorScheme.mutedForeground.withOpacity(0.7),
            labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground.withOpacity(0.7)),
            labelAnchor: Alignment.center,
            labelCrossAxisOffset: 10,
          ),
          thumbStyle: FSliderThumbStyle(
            color: colorScheme.primaryForeground.withOpacity(0.7),
            borderColor: colorScheme.primary.withOpacity(0.7),
          ),
        );

  /// Returns a copy of this [FSliderStyles] but with the given fields replaced with the new values.
  @useResult
  FSliderStyles copyWith({
    FSliderStyle? enabledStyle,
    FSliderStyle? disabledStyle,
  }) =>
      FSliderStyles(
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }
}

/// A slider's style.
final class FSliderStyle with Diagnosticable {
  /// The slider's active color.
  final Color activeColor;

  /// The slider inactive color.
  final Color inactiveColor;

  /// The slider's cross-axis extent. Defaults to 8.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if it is not positive.
  final double crossAxisExtent;

  /// The slider's border radius.
  final BorderRadius borderRadius;

  /// The slider marks' style.
  final FSliderMarkStyle markStyle; // TODO: vertical and horizontal?

  /// The slider thumb's style.
  final FSliderThumbStyle thumbStyle;

  // TODO: tooltip style?

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.markStyle,
    required this.thumbStyle,
    this.crossAxisExtent = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  /// Returns a copy of this [FSliderStyle] but with the given fields replaced with the new values.
  @useResult
  FSliderStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    double? mainAxisPadding,
    double? crossAxisExtent,
    BorderRadius? borderRadius,
    FSliderMarkStyle? markStyle,
    FSliderThumbStyle? thumbStyle,
  }) =>
      FSliderStyle(
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
        borderRadius: borderRadius ?? this.borderRadius,
        markStyle: markStyle ?? this.markStyle,
        thumbStyle: thumbStyle ?? this.thumbStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('activeColor', activeColor))
      ..add(ColorProperty('inactiveColor', inactiveColor))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('markStyle', markStyle))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderStyle &&
          runtimeType == other.runtimeType &&
          activeColor == other.activeColor &&
          inactiveColor == other.inactiveColor &&
          crossAxisExtent == other.crossAxisExtent &&
          borderRadius == other.borderRadius &&
          markStyle == other.markStyle &&
          thumbStyle == other.thumbStyle;

  @override
  int get hashCode =>
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      crossAxisExtent.hashCode ^
      borderRadius.hashCode ^
      markStyle.hashCode ^
      thumbStyle.hashCode;
}

@internal
class InheritedData extends InheritedWidget {
  final FSliderController controller;
  final FSliderStyle style;
  final Layout layout;
  final bool enabled;

  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context');
    return result!;
  }

  const InheritedData({
    required this.controller,
    required this.style,
    required this.layout,
    required this.enabled,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedData old) =>
      controller != old.controller || style != old.style || layout != old.layout || enabled != old.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'));
  }
}
