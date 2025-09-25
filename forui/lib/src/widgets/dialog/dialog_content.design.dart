// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDialogContentStyleTransformations on FDialogContentStyle {
  /// Returns a copy of this [FDialogContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogContentStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FDialogContentStyle.bodyTextStyle] - The body's [TextStyle].
  /// * [FDialogContentStyle.padding] - The padding surrounding the content.
  /// * [FDialogContentStyle.actionSpacing] - The space between actions.
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

  /// Linearly interpolate between this and another [FDialogContentStyle] using the given factor [t].
  @useResult
  FDialogContentStyle lerp(FDialogContentStyle other, double t) => FDialogContentStyle(
    titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t) ?? bodyTextStyle,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
  );
}

mixin _$FDialogContentStyleFunctions on Diagnosticable {
  TextStyle get titleTextStyle;
  TextStyle get bodyTextStyle;
  EdgeInsetsGeometry get padding;
  double get actionSpacing;

  /// Returns itself.
  ///
  /// Allows [FDialogContentStyle] to replace functions that accept and return a [FDialogContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDialogContentStyle Function(FDialogContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDialogContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDialogContentStyle(...));
  /// ```
  @useResult
  FDialogContentStyle call(Object? _) => this as FDialogContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bodyTextStyle', bodyTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('actionSpacing', actionSpacing, level: DiagnosticLevel.debug));
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
