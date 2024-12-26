import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination_controller.dart';
import 'package:meta/meta.dart';

/// A Pagination component that enables the user to select a specific page from a range of pages.
///
/// See:
/// * https://forui.dev/docs/navigation/pagination for working examples.
/// * [FPaginationStyle] for customizing a breadcrumb's appearance.
/// * [FBreadcrumbItem] for adding items to a breadcrumb.
final class FPagination extends StatefulWidget {
  /// The pagination's style. Defaults to the appropriate style in [FThemeData.breadcrumbStyle].
  final FPaginationStyle? style;

  final FPaginationController? controller;

  final int displayed;

  /// The previous button placed in the beginning of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final FButton? previous;

  /// The next button placed at the end of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final FButton? next;

  /// Creates an [FPagination].
  const FPagination({
    required this.controller,
    required this.displayed,
    this.style,
    this.previous,
    this.next,
    super.key,
  });

  @override
  State<FPagination> createState() => _FPaginationState();
}

class _FPaginationState extends State<FPagination> {
  late FPaginationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FPaginationController();
  }

  @override
  void didUpdateWidget(covariant FPagination old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    if (old.controller != null) {
      _controller.dispose();
    }
    _controller = widget.controller ?? FPaginationController();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? FTheme.of(context).paginationStyle;
    final previous = widget.previous != null
        ? FIconStyleData(
            style: style.iconStyle,
            child: widget.previous!,
          )
        : FButton(
            onPress: () {},
            label: const Text('Previous'),
            prefix: FIcon(
              FAssets.icons.chevronLeft,
              color: style.iconStyle.color,
              size: style.iconStyle.size,
            ),
          );
    final next = widget.next != null
        ? FIconStyleData(
            style: style.iconStyle,
            child: widget.next!,
          )
        : FButton(
            onPress: () {},
            label: const Text('Next'),
            prefix: FIcon(
              FAssets.icons.chevronRight,
              color: style.iconStyle.color,
              size: style.iconStyle.size,
            ),
          );
    return Row(
      children: [
        Padding(
          padding: style.padding,
          child: previous,
        ),
        for (int i = 0; i < _controller.count; i++)
          FPaginationData(
            style: style,
            child: _Page(
              current: i == _controller.selected,
              child: Text('$i'),
            ),
          ),
        Padding(
          padding: style.padding,
          child: next,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

/// The [FBreadcrumbItem] data.
class FPaginationData extends InheritedWidget {
  /// Returns the [FPaginationData] of the [FPagination] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FPagination] in the given [context].
  @useResult
  static FPaginationData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FPaginationData>();
    assert(data != null, 'No FPaginationData found in context');
    return data!;
  }

  /// The pagination's style.
  final FPaginationStyle style;

  /// Creates a [FPaginationData].
  const FPaginationData({
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FPaginationData oldWidget) => style != oldWidget.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

class _Page extends StatelessWidget {
  final bool current;
  final VoidCallback? onPress;
  final Widget child;

  const _Page({
    required this.child,
    this.onPress,
    this.current = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = FPaginationData.of(context).style;
    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return FTappable(
      focusedOutlineStyle: focusedOutlineStyle,
      onPress: onPress,
      builder: (context, data, child) => Container(
        decoration: switch ((current, data.hovered)) {
          (false, false) => style.unselectedDecoration,
          (false, true) => style.hoveredDecoration,
          (true, true) => style.hoveredDecoration,
          (true, false) => style.selectedDecoration,
        },
        padding: style.padding,
        child: DefaultTextStyle(
          style: style.textStyle,
          child: child!,
        ),
      ),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('current', value: current, ifTrue: 'current'))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

/// The [FPagination] styles.
final class FPaginationStyle with Diagnosticable {
  /// The selected page [BoxDecoration].
  final BoxDecoration selectedDecoration;

  /// The unselected page [BoxDecoration].
  final BoxDecoration unselectedDecoration;

  /// The hovered page [BoxDecoration].
  final BoxDecoration hoveredDecoration;

  /// The icon style.
  final FIconStyle iconStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  final EdgeInsets padding;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.selectedDecoration,
    required this.unselectedDecoration,
    required this.hoveredDecoration,
    required this.iconStyle,
    required this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
  });

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [typography].
  FPaginationStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          selectedDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.foreground,
            border: Border.all(
              color: colorScheme.mutedForeground,
              width: 2,
            ),
          ),
          unselectedDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.foreground,
          ),
          hoveredDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.mutedForeground,
          ),
          textStyle: typography.base.copyWith(color: colorScheme.primary),
          iconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 16),
        );

  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  @useResult
  FPaginationStyle copyWith({
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    BoxDecoration? hoveredDecoration,
    TextStyle? textStyle,
    FIconStyle? iconStyle,
    EdgeInsets? padding,
  }) =>
      FPaginationStyle(
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
        hoveredDecoration: hoveredDecoration ?? this.hoveredDecoration,
        textStyle: textStyle ?? this.textStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('hoveredDecoration', hoveredDecoration))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPaginationStyle &&
          runtimeType == other.runtimeType &&
          selectedDecoration == other.selectedDecoration &&
          unselectedDecoration == other.unselectedDecoration &&
          hoveredDecoration == other.hoveredDecoration &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding;

  @override
  int get hashCode =>
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      hoveredDecoration.hashCode ^
      textStyle.hashCode ^
      iconStyle.hashCode ^
      padding.hashCode;
}
