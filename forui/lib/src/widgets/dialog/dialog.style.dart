// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FDialogStyleCopyWith on FDialogStyle {
  /// Returns a copy of this [FDialogStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [barrierFilter]
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  ///
  /// This is only supported by [showFDialog].
  ///
  /// ## Why isn't the [barrierFilter] being applied?
  /// Make sure you are passing the [FDialogStyle] to the [showFDialog] method instead of the [FDialog].
  ///
  /// # [backgroundFilter]
  /// {@macro forui.widgets.FPopoverStyle.backgroundFilter}
  ///
  /// This requires [FDialog.animation] to be non-null.
  ///
  /// # [entranceExitDuration]
  /// The dialog's entrance/exit animation duration. Defaults to 150ms.
  ///
  /// This requires [FDialog.animation] to be non-null.
  ///
  /// # [entranceCurve]
  /// The dialog's entrance animation curve. Defaults to [Curves.easeOutCubic].
  ///
  /// This requires [FDialog.animation] to be non-null.
  ///
  /// # [exitCurve]
  /// The dialog's entrance animation curve. Defaults to [Curves.easeInCubic].
  ///
  /// This requires [FDialog.animation] to be non-null.
  ///
  /// # [fadeTween]
  /// The tween used to animate the dialog's fade in and out. Defaults to `[0, 1]`.
  ///
  /// This requires [FDialog.animation] to be non-null.
  ///
  /// # [scaleTween]
  /// The tween used to animate the dialog's scale in and out. Defaults to `[0.95, 1]`.
  ///
  /// This requires [FDialog.animation] to be non-null.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [insetAnimationDuration]
  /// The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  ///
  /// # [insetAnimationCurve]
  /// The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in.
  ///
  /// Defaults to [Curves.decelerate].
  ///
  /// # [insetPadding]
  /// The inset padding. Defaults to `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
  ///
  /// # [horizontalStyle]
  /// The horizontal dialog content's style.
  ///
  /// # [verticalStyle]
  /// The vertical dialog content's style.
  ///
  @useResult
  FDialogStyle copyWith({
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    Duration? entranceExitDuration,
    Curve? entranceCurve,
    Curve? exitCurve,
    Tween<double>? fadeTween,
    Tween<double>? scaleTween,
    BoxDecoration? decoration,
    Duration? insetAnimationDuration,
    Curve? insetAnimationCurve,
    EdgeInsetsGeometry? insetPadding,
    FDialogContentStyle Function(FDialogContentStyle)? horizontalStyle,
    FDialogContentStyle Function(FDialogContentStyle)? verticalStyle,
  }) => FDialogStyle(
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    entranceExitDuration: entranceExitDuration ?? this.entranceExitDuration,
    entranceCurve: entranceCurve ?? this.entranceCurve,
    exitCurve: exitCurve ?? this.exitCurve,
    fadeTween: fadeTween ?? this.fadeTween,
    scaleTween: scaleTween ?? this.scaleTween,
    decoration: decoration ?? this.decoration,
    insetAnimationDuration: insetAnimationDuration ?? this.insetAnimationDuration,
    insetAnimationCurve: insetAnimationCurve ?? this.insetAnimationCurve,
    insetPadding: insetPadding ?? this.insetPadding,
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );
}

mixin _$FDialogStyleFunctions on Diagnosticable {
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  Duration get entranceExitDuration;
  Curve get entranceCurve;
  Curve get exitCurve;
  Tween<double> get fadeTween;
  Tween<double> get scaleTween;
  BoxDecoration get decoration;
  Duration get insetAnimationDuration;
  Curve get insetAnimationCurve;
  EdgeInsetsGeometry get insetPadding;
  FDialogContentStyle get horizontalStyle;
  FDialogContentStyle get verticalStyle;

  /// Returns itself.
  ///
  /// Allows [FDialogStyle] to replace functions that accept and return a [FDialogStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDialogStyle Function(FDialogStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDialogStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDialogStyle(...));
  /// ```
  @useResult
  FDialogStyle call(Object? _) => this as FDialogStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('entranceExitDuration', entranceExitDuration))
      ..add(DiagnosticsProperty('entranceCurve', entranceCurve))
      ..add(DiagnosticsProperty('exitCurve', exitCurve))
      ..add(DiagnosticsProperty('fadeTween', fadeTween))
      ..add(DiagnosticsProperty('scaleTween', scaleTween))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('insetAnimationDuration', insetAnimationDuration))
      ..add(DiagnosticsProperty('insetAnimationCurve', insetAnimationCurve))
      ..add(DiagnosticsProperty('insetPadding', insetPadding))
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogStyle &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          entranceExitDuration == other.entranceExitDuration &&
          entranceCurve == other.entranceCurve &&
          exitCurve == other.exitCurve &&
          fadeTween == other.fadeTween &&
          scaleTween == other.scaleTween &&
          decoration == other.decoration &&
          insetAnimationDuration == other.insetAnimationDuration &&
          insetAnimationCurve == other.insetAnimationCurve &&
          insetPadding == other.insetPadding &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle);
  @override
  int get hashCode =>
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      entranceExitDuration.hashCode ^
      entranceCurve.hashCode ^
      exitCurve.hashCode ^
      fadeTween.hashCode ^
      scaleTween.hashCode ^
      decoration.hashCode ^
      insetAnimationDuration.hashCode ^
      insetAnimationCurve.hashCode ^
      insetPadding.hashCode ^
      horizontalStyle.hashCode ^
      verticalStyle.hashCode;
}
