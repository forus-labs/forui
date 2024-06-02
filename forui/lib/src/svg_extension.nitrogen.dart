import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrogen_types/nitrogen_types.dart';

// GENERATED CODE - DO NOT MODIFY BY HAND
//
// **************************************************************************
// nitrogen_lottie
// **************************************************************************
//
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use

/// Tested against flutter_svg version: 2.0.10+1
///
/// Example:
/// ```dart
/// class Foo extends StatelessWidget {
///   final SvgAsset asset;
///
///   @override
///   Widget build(BuildContext context) => Container(
///     child: asset(
///       width: 100,
///       height: 100,
///     ),
///   );
/// }
/// ```
extension SvgAssetExtension on SvgAsset {
  SvgPicture call({
    Key? key,
    bool matchTextDirection = false,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    @Deprecated('Parameter is deprecated in flutter_svg') Color? color,
    @Deprecated('Parameter is deprecated in flutter_svg') BlendMode colorBlendMode = BlendMode.srcIn,
    @Deprecated('Parameter is deprecated in flutter_svg') bool cacheColorFilter = false,
  }) =>
      SvgPicture.asset(
        path,
        key: key,
        matchTextDirection: matchTextDirection,
        package: package,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
        placeholderBuilder: placeholderBuilder,
        semanticsLabel: semanticsLabel,
        excludeFromSemantics: excludeFromSemantics,
        clipBehavior: clipBehavior,
        theme: theme,
        colorFilter: colorFilter,
        color: color,
        colorBlendMode: colorBlendMode,
        cacheColorFilter: cacheColorFilter,
      );
}
