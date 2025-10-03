import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/foundation/rendering.dart';

part 'header.design.dart';

part 'header_action.dart';

part 'root_header.dart';

part 'nested_header.dart';

/// A header contains the page's title and actions.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
/// * [FHeaderStyle] for customizing a header's appearance.
sealed class FHeader extends StatelessWidget {
  /// The title.
  final Widget title;

  const FHeader._({this.title = const SizedBox(), super.key});

  /// Creates a header whose title is aligned to the start.
  ///
  /// It is typically used on pages at the root of the navigation stack.
  ///
  /// ## CLI
  /// To generate and customize this widget's style:
  ///
  /// ```shell
  /// dart run forui style create headers
  /// ```
  const factory FHeader({
    Widget title,
    FHeaderStyle Function(FHeaderStyle style)? style,
    List<Widget> suffixes,
    Key? key,
  }) = _FRootHeader;

  /// Creates a nested header whose title is aligned to the center.
  ///
  /// It is typically used on pages NOT at the root of the navigation stack.
  ///
  /// ## CLI
  /// To generate and customize this widget's style:
  ///
  /// ```shell
  /// dart run forui style create headers
  /// ```
  const factory FHeader.nested({
    Widget title,
    AlignmentGeometry titleAlignment,
    FHeaderStyle Function(FHeaderStyle style)? style,
    List<Widget> prefixes,
    List<Widget> suffixes,
    Key? key,
  }) = _FNestedHeader;
}

/// A header's data.
class FHeaderData extends InheritedWidget {
  /// Returns the [FHeaderData] of the [FHeader] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FHeader] in the given [context].
  @useResult
  static FHeaderData of(BuildContext context) {
    assert(debugCheckHasAncestor<FHeaderData>('$FHeader', context));
    return context.dependOnInheritedWidgetOfExactType<FHeaderData>()!;
  }

  /// The action's style.
  final FHeaderActionStyle actionStyle;

  /// Creates a [FHeaderData].
  const FHeaderData({required this.actionStyle, required super.child, super.key});

  @override
  bool updateShouldNotify(FHeaderData oldWidget) => actionStyle != oldWidget.actionStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('actionStyle', actionStyle));
  }
}

/// [FHeader]'s styles.
class FHeaderStyles with Diagnosticable, _$FHeaderStylesFunctions {
  /// The root header's style.
  @override
  final FHeaderStyle rootStyle;

  /// The nested header's style.
  @override
  final FHeaderStyle nestedStyle;

  /// Creates a [FHeaderStyles].
  const FHeaderStyles({required this.rootStyle, required this.nestedStyle});

  /// Creates a [FHeaderStyles] that inherits its properties.
  FHeaderStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : rootStyle = FHeaderStyle(
        systemOverlayStyle: colors.systemOverlayStyle,
        titleTextStyle: typography.xl3.copyWith(color: colors.foreground, fontWeight: FontWeight.w700, height: 1),
        actionStyle: FHeaderActionStyle.inherit(colors: colors, style: style, size: 30),
        padding: style.pagePadding.copyWith(bottom: 15),
      ),
      nestedStyle = FHeaderStyle(
        systemOverlayStyle: colors.systemOverlayStyle,
        titleTextStyle: typography.xl.copyWith(color: colors.foreground, fontWeight: FontWeight.w600, height: 1),
        actionStyle: FHeaderActionStyle.inherit(colors: colors, style: style, size: 25),
        padding: style.pagePadding.copyWith(bottom: 15),
      );
}

/// A header's style.
class FHeaderStyle with Diagnosticable, _$FHeaderStyleFunctions {
  /// The system overlay style.
  @override
  final SystemUiOverlayStyle systemOverlayStyle;

  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  @override
  final ImageFilter? backgroundFilter;

  /// The padding.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between [FHeaderAction]s. Defaults to 10.
  @override
  final double actionSpacing;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]s' style.
  @override
  final FHeaderActionStyle actionStyle;

  /// Creates a [FHeaderStyle].
  const FHeaderStyle({
    required this.systemOverlayStyle,
    required this.titleTextStyle,
    required this.actionStyle,
    required this.padding,
    this.decoration = const BoxDecoration(),
    this.backgroundFilter,
    this.actionSpacing = 10,
  });
}
