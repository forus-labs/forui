import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'header.style.dart';

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

  /// Creates a header which title is aligned to the start.
  ///
  /// It is typically used on pages at the root of the navigation stack.
  const factory FHeader({Widget title, FHeaderStyle? style, List<Widget> suffixes, Key? key}) = _FRootHeader;

  /// Creates a nested header which title is aligned to the center.
  ///
  /// It is typically used on pages NOT at the root of the navigation stack.
  const factory FHeader.nested({
    Widget title,
    FHeaderStyle? style,
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
    final data = context.dependOnInheritedWidgetOfExactType<FHeaderData>();
    assert(data != null, 'No FHeaderActionData found in context');
    return data!;
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
final class FHeaderStyles with Diagnosticable, _$FHeaderStylesFunctions {
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
        titleTextStyle: typography.xl3.copyWith(color: colors.foreground, fontWeight: FontWeight.w700, height: 1),
        actionStyle: FHeaderActionStyle.inherit(colors: colors, style: style, size: 30),
        padding: style.pagePadding.copyWith(bottom: 15),
      ),
      nestedStyle = FHeaderStyle(
        titleTextStyle: typography.xl.copyWith(color: colors.foreground, fontWeight: FontWeight.w600, height: 1),
        actionStyle: FHeaderActionStyle.inherit(colors: colors, style: style, size: 25),
        padding: style.pagePadding.copyWith(bottom: 15),
      );
}

/// A header's style.
final class FHeaderStyle with Diagnosticable, _$FHeaderStyleFunctions {
  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]s' style.
  @override
  final FHeaderActionStyle actionStyle;

  /// The spacing between [FHeaderAction]s. Defaults to 10.
  @override
  final double actionSpacing;

  /// The padding.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FHeaderStyle].
  const FHeaderStyle({
    required this.titleTextStyle,
    required this.actionStyle,
    required this.padding,
    this.actionSpacing = 10,
  });
}
