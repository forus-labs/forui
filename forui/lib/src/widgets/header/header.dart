import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

part 'header_action.dart';

part 'root_header.dart';

part 'nested_header.dart';

/// A header contains the page's title and actions.
///
/// See:
/// * https://forui.dev/docs/header for working examples.
/// * [FRootHeaderStyle] and [FNestedHeaderStyle] for customizing a header's appearance.
sealed class FHeader extends StatelessWidget {
  const FHeader._({super.key});

  /// Creates a header.
  ///
  /// It is typically used on pages at the root of the navigation stack.
  const factory FHeader({
    required Widget title,
    FRootHeaderStyle? style,
    List<Widget> actions,
    Key? key,
  }) = _FRootHeader;

  /// Creates a nested header.
  ///
  /// It is typically used on pages NOT at the root of the navigation stack.
  const factory FHeader.nested({
    required Widget title,
    FNestedHeaderStyle? style,
    List<Widget> leftActions,
    List<Widget> rightActions,
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
  const FHeaderData({
    required this.actionStyle,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FHeaderData oldWidget) => actionStyle != oldWidget.actionStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('actionStyle', actionStyle));
  }
}

/// [FHeader]'s styles.
final class FHeaderStyles with Diagnosticable {
  /// The root header's style.
  final FRootHeaderStyle rootStyle;

  /// The nested header's style.
  final FNestedHeaderStyle nestedStyle;

  /// Creates a [FHeaderStyles].
  const FHeaderStyles({
    required this.rootStyle,
    required this.nestedStyle,
  });

  /// Creates a [FHeaderStyles] that inherits its properties from the given [FStateColorScheme], [FTypography] and [FStyle].
  FHeaderStyles.inherit({
    required FStateColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  })  : rootStyle = FRootHeaderStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
        nestedStyle = FNestedHeaderStyle.inherit(colorScheme: colorScheme, typography: typography, style: style);

  /// Returns a copy of this [FHeaderStyles] with the given properties replaced.
  @useResult
  FHeaderStyles copyWith({
    FRootHeaderStyle? rootStyle,
    FNestedHeaderStyle? nestedStyle,
  }) =>
      FHeaderStyles(
        rootStyle: rootStyle ?? this.rootStyle,
        nestedStyle: nestedStyle ?? this.nestedStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('rootStyle', rootStyle))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FHeaderStyles &&
          runtimeType == other.runtimeType &&
          rootStyle == other.rootStyle &&
          nestedStyle == other.nestedStyle;

  @override
  int get hashCode => rootStyle.hashCode ^ nestedStyle.hashCode;
}
