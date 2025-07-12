// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FPopoverStyleCopyWith on FPopoverStyle {
  /// Returns a copy of this [FPopoverStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The popover's decoration.
  ///
  /// # [barrierFilter]
  /// {@template forui.widgets.FPopoverStyle.barrierFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the barrier. Defaults to null.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  ///
  /// # [backgroundFilter]
  /// {@template forui.widgets.FPopoverStyle.backgroundFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the background. Defaults to null.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  ///
  /// # [viewInsets]
  /// The additional insets of the view. In other words, the minimum distance between the edges of the view and the
  /// edges of the popover. This applied in addition to the insets provided by [MediaQueryData.viewPadding].
  ///
  /// Defaults to `EdgeInsets.all(5)`.
  ///
  @useResult
  FPopoverStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometry? viewInsets,
  }) => FPopoverStyle(
    decoration: decoration ?? this.decoration,
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    viewInsets: viewInsets ?? this.viewInsets,
  );
}

mixin _$FPopoverStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;

  /// Returns itself.
  ///
  /// Allows [FPopoverStyle] to replace functions that accept and return a [FPopoverStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FPopoverStyle Function(FPopoverStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FPopoverStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FPopoverStyle(...));
  /// ```
  @useResult
  FPopoverStyle call(Object? _) => this as FPopoverStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('viewInsets', viewInsets));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverStyle &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);
  @override
  int get hashCode => decoration.hashCode ^ barrierFilter.hashCode ^ backgroundFilter.hashCode ^ viewInsets.hashCode;
}
