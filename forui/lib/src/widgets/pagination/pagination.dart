import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

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

  final bool showFirstLastPages;

  /// The previous button placed in the beginning of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final Widget? previous;

  /// The next button placed at the end of the pagination.
  ///
  final FButton? next;

  /// Creates an [FPagination].
  const FPagination({
    this.controller,
    this.style,
    this.previous,
    this.next,
    this.showFirstLastPages = true,
    super.key,
  });

  @override
  State<FPagination> createState() => _FPaginationState();
}

class _FPaginationState extends State<FPagination> {
  late FPaginationController _controller;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        FPaginationController(
          showFirstLastPages: widget.showFirstLastPages,
          initialPage: 1,
          length: 10,
        );
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.value;
      });
    });
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
    _controller = widget.controller ??
        FPaginationController(
          showFirstLastPages: widget.showFirstLastPages,
          initialPage: 1,
          length: 10,
        );
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.paginationStyle;
    final previous = widget.previous ?? _Action.previous(style: style, onPress: _controller.previous);
    final next = widget.next ?? _Action.next(style: style, onPress: _controller.next);

    final elipsis = Padding(
      padding: style.itemPadding,
      child: Container(
        decoration: style.unselectedDecoration,
        padding: style.contentPadding,
        child: ConstrainedBox(
          constraints: style.contentConstraints,
          child: DefaultTextStyle(
            style: style.textStyle,
            child: const Center(child: Text('...')),
          ),
        ),
      ),
    );

    final range = _controller.calculateRange();

    return Row(
      children: [
        previous,
        if (_controller.value > _controller.minPagesDisplayedAtEnds + 1) ...[
          if (_controller.showFirstLastPages)
            FPaginationItemData(
              pageNumber: 1,
              style: style,
              controller: _controller,
              child: const _Page(),
            ),
          elipsis,
        ],
        for (int i = range.$1; i <= range.$2; i++)
          FPaginationItemData(
            pageNumber: i,
            style: style,
            controller: _controller,
            child: const _Page(),
          ),
        if (_controller.value < (_controller.length - _controller.minPagesDisplayedAtEnds)) ...[
          elipsis,
          if (_controller.showFirstLastPages)
            FPaginationItemData(
              pageNumber: _controller.length,
              style: style,
              controller: _controller,
              child: const _Page(),
            ),
        ],
        next,
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

  final int pageNumber;
  final FPaginationController controller;
  final FPaginationStyle style;

  const FPaginationItemData({
    required this.pageNumber,
    required this.controller,
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FPaginationItemData old) =>
      pageNumber != old.pageNumber || controller != old.controller || style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', pageNumber))
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
  Widget build(BuildContext context) => Padding(
        padding: style.itemPadding,
        child: FTappable(
          focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
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
        ),
      );
}

class _Page extends StatelessWidget {
  final Widget? child;

  const _Page({this.child});

  @override
  Widget build(BuildContext context) {
    final FPaginationItemData(pageNumber: pageNumber, :controller, style: style) = FPaginationItemData.of(context);

    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return Padding(
      padding: style.itemPadding,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, __) {
          final current = pageNumber == value;
          return FTappable(
            focusedOutlineStyle: focusedOutlineStyle,
            onPress: () => controller.value = pageNumber,
            builder: (context, tappableData, child) => Container(
              decoration: switch ((current, tappableData.hovered)) {
                (false, false) => style.unselectedDecoration,
                (false, true) => style.hoveredDecoration,
                (true, true) => style.selectedHoveredDecoration,
                (true, false) => style.selectedDecoration,
              },
              padding: style.contentPadding,
              child: ConstrainedBox(
                constraints: style.contentConstraints,
                child: DefaultTextStyle(
                  style: style.textStyle,
                  child: child!,
                ),
              ),
            ),
            child: Center(child: child ?? Text('$pageNumber')),
          );
        },
      ),
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

  final BoxConstraints contentConstraints;

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
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2),
    this.contentConstraints = const BoxConstraints(minWidth: 18.0, maxWidth: 18.0, maxHeight: 18.0),
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
    BoxConstraints? contentConstraints,
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
        contentConstraints: contentConstraints ?? this.contentConstraints,
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
      ..add(DiagnosticsProperty('contentConstraints', contentConstraints));
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
          contentConstraints == other.contentConstraints;

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
      contentConstraints.hashCode;
}
