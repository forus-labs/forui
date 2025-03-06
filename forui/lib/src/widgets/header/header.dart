import 'package:collection/collection.dart';
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
/// * [FRootHeaderStyle] and [FNestedHeaderStyle] for customizing a header's appearance.
sealed class FHeader extends StatelessWidget {
  const FHeader._({super.key});

  /// Creates a header.
  ///
  /// It is typically used on pages at the root of the navigation stack.
  const factory FHeader({required Widget title, FRootHeaderStyle? style, List<Widget> actions, Key? key}) =
      _FRootHeader;

  /// Creates a nested header.
  ///
  /// It is typically used on pages NOT at the root of the navigation stack.
  const factory FHeader.nested({
    required Widget title,
    FNestedHeaderStyle? style,
    List<Widget> prefixActions,
    List<Widget> suffixActions,
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
  final FRootHeaderStyle rootStyle;

  /// The nested header's style.
  @override
  final FNestedHeaderStyle nestedStyle;

  /// Creates a [FHeaderStyles].
  const FHeaderStyles({required this.rootStyle, required this.nestedStyle});

  /// Creates a [FHeaderStyles] that inherits its properties from the given [FColorScheme], [FTypography] and [FStyle].
  FHeaderStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : rootStyle = FRootHeaderStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      nestedStyle = FNestedHeaderStyle.inherit(colorScheme: colorScheme, typography: typography, style: style);
}
