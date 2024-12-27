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
    this.controller,
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
    final style = widget.style ?? context.theme.paginationStyle;
    final previous = widget.previous != null
        ? FIconStyleData(
            style: style.iconStyle,
            child: widget.previous!,
          )
        : _Action.previous(style: style, onPress: _controller.previous);
    final next = widget.next != null
        ? FIconStyleData(
            style: style.iconStyle,
            child: widget.next!,
          )
        : _Action.next(style: style, onPress: _controller.next);

    return Row(
      children: [
        Padding(
          padding: style.itemPadding,
          child: previous,
        ),
        for (int i = 0; i < _controller.count; i++)
          FPaginationItemData(
            index: i,
            style: style,
            controller: _controller,
            child: Padding(
              padding: style.itemPadding,
              child: const _Page(),
            ),
          ),
        Padding(
          padding: style.itemPadding,
          child: next,
        ),
      ],
    );
  }
}

@internal
class FPaginationItemData extends InheritedWidget {
  @useResult
  static FPaginationItemData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FPaginationItemData>();
    assert(data != null, 'No FPaginationItemData found in context.');
    return data!;
  }

  final int index;
  final FPaginationController controller;
  final FPaginationStyle style;

  const FPaginationItemData({
    required this.index,
    required this.controller,
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FPaginationItemData old) =>
      index != old.index || controller != old.controller || style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style));
  }
}

class _Action extends StatelessWidget {
  final VoidCallback onPress;
  final FPaginationStyle style;
  final Widget child;

  const _Action({
    required this.onPress,
    required this.style,
    required this.child,
  });

  factory _Action.previous({
    required VoidCallback onPress,
    required FPaginationStyle style,
  }) =>
      _Action(
        onPress: onPress,
        style: style,
        child: Row(
          children: [
            FIcon(
              FAssets.icons.chevronLeft,
              color: style.iconStyle.color,
              size: style.iconStyle.size,
            ),
            const SizedBox(width: 3),
            Text(
              'Previous',
              style: style.textStyle,
            ),
          ],
        ),
      );

  factory _Action.next({
    required VoidCallback onPress,
    required FPaginationStyle style,
  }) =>
      _Action(
        onPress: onPress,
        style: style,
        child: Row(
          children: [
            Text(
              'Next',
              style: style.textStyle,
            ),
            const SizedBox(width: 3),
            FIcon(
              FAssets.icons.chevronRight,
              color: style.iconStyle.color,
              size: style.iconStyle.size,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => FTappable(
        onPress: onPress,
        builder: (context, tappableData, child) => Container(
          decoration: switch (tappableData.hovered) {
            (false) => style.unselectedDecoration,
            (true) => style.hoveredDecoration,
          },
          padding: style.contentPadding,
          child: child,
        ),
        child: child,
      );
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    final data = FPaginationItemData.of(context);
    final current = data.index == data.controller.value;
    final style = FPaginationItemData.of(context).style;
    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return FTappable(
      focusedOutlineStyle: focusedOutlineStyle,
      onPress: () => data.controller.select(data.index),
      builder: (context, tappableData, child) => Container(
        decoration: switch ((current, tappableData.hovered)) {
          (false, false) => style.unselectedDecoration,
          (false, true) => style.hoveredDecoration,
          (true, true) => style.selectedHoveredDecoration,
          (true, false) => style.selectedDecoration,
        },
        padding: style.contentPadding,
        child: DefaultTextStyle(
          style: style.textStyle,
          child: child!,
        ),
      ),
      child: Text('${data.index}'),
    );
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

  /// The hovered selected page [BoxDecoration].
  final BoxDecoration selectedHoveredDecoration;

  /// The icon style.
  final FIconStyle iconStyle;

  /// The padding around a page item. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  final EdgeInsets contentPadding;

  /// The padding around an action button. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  final EdgeInsets itemPadding;

  final double spacing;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.selectedDecoration,
    required this.unselectedDecoration,
    required this.hoveredDecoration,
    required this.selectedHoveredDecoration,
    required this.iconStyle,
    required this.textStyle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2),
    this.spacing = 5,
  });

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [typography].
  FPaginationStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          selectedDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.background,
            border: Border.all(
              color: colorScheme.mutedForeground,
            ),
          ),
          unselectedDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.background,
          ),
          hoveredDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.border,
          ),
          selectedHoveredDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.border,
            border: Border.all(
              color: colorScheme.mutedForeground,
            ),
          ),
          textStyle: typography.sm.copyWith(color: colorScheme.primary),
          iconStyle: FIconStyle(color: colorScheme.primary, size: 16),
        );

  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  @useResult
  FPaginationStyle copyWith({
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    BoxDecoration? hoveredDecoration,
    BoxDecoration? selectedHoveredDecoration,
    TextStyle? textStyle,
    FIconStyle? iconStyle,
    EdgeInsets? itemPadding,
    EdgeInsets? actionPadding,
    double? spacing,
  }) =>
      FPaginationStyle(
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
        hoveredDecoration: hoveredDecoration ?? this.hoveredDecoration,
        selectedHoveredDecoration: selectedHoveredDecoration ?? this.selectedHoveredDecoration,
        textStyle: textStyle ?? this.textStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        contentPadding: itemPadding ?? this.contentPadding,
        itemPadding: actionPadding ?? this.itemPadding,
        spacing: spacing ?? this.spacing,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('hoveredDecoration', hoveredDecoration))
      ..add(DiagnosticsProperty('selectedHoveredDecoration', selectedHoveredDecoration))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('itemPadding', contentPadding))
      ..add(DiagnosticsProperty('actionPadding', itemPadding))
      ..add(DoubleProperty('spacing', spacing));
    ;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPaginationStyle &&
          runtimeType == other.runtimeType &&
          selectedDecoration == other.selectedDecoration &&
          unselectedDecoration == other.unselectedDecoration &&
          hoveredDecoration == other.hoveredDecoration &&
          selectedHoveredDecoration == other.selectedHoveredDecoration &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          contentPadding == other.contentPadding &&
          itemPadding == other.itemPadding &&
          spacing == other.spacing;

  @override
  int get hashCode =>
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      hoveredDecoration.hashCode ^
      selectedHoveredDecoration.hashCode ^
      textStyle.hashCode ^
      iconStyle.hashCode ^
      contentPadding.hashCode ^
      itemPadding.hashCode ^
      spacing.hashCode;
}
