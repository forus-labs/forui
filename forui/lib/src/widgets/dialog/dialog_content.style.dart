// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FDialogContentStyleFunctions on Diagnosticable implements FTransformable {
  TextStyle get titleTextStyle;
  TextStyle get bodyTextStyle;
  EdgeInsetsGeometry get padding;
  double get actionSpacing;

  /// Returns a copy of this [FDialogContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FDialogContentStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
    EdgeInsetsGeometry? padding,
    double? actionSpacing,
  }) => FDialogContentStyle(
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
    padding: padding ?? this.padding,
    actionSpacing: actionSpacing ?? this.actionSpacing,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('bodyTextStyle', bodyTextStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('actionSpacing', actionSpacing));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogContentStyle &&
          titleTextStyle == other.titleTextStyle &&
          bodyTextStyle == other.bodyTextStyle &&
          padding == other.padding &&
          actionSpacing == other.actionSpacing);
  @override
  int get hashCode => titleTextStyle.hashCode ^ bodyTextStyle.hashCode ^ padding.hashCode ^ actionSpacing.hashCode;
}
