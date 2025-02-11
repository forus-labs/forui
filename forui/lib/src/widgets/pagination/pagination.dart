import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:meta/meta.dart';

/// A pagination enables the user to select a specific page from a range of pages.
///
/// See:
/// * https://forui.dev/docs/navigation/pagination for working examples.
/// * [FPaginationController] for customizing the pagination component's behavior.
/// * [FPaginationStyle] for customizing the pagination component's appearance.
final class FPagination extends StatefulWidget {
  /// The pagination's style. Defaults to the appropriate style in [FThemeData.paginationStyle].
  final FPaginationStyle? style;

  /// The controller. Defaults to [FPaginationController.new].
  final FPaginationController controller;

  /// The previous button placed in the beginning of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronLeft` icon.
  final Widget? previous;

  /// The next button placed at the end of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final Widget? next;

  /// Creates an [FPagination].
  const FPagination({
    required this.controller,
    this.style,
    this.previous,
    this.next,
    super.key,
  });

  @override
  State<FPagination> createState() => _FPaginationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', controller));
  }
}

class _FPaginationState extends State<FPagination> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant FPagination old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }
    old.controller.removeListener(() {
      setState(() {});
    });
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final style = widget.style ?? context.theme.paginationStyle;
    final previous = widget.previous ?? Action.previous(style: style, onPress: controller.previous);
    final next = widget.next ?? Action.next(style: style, onPress: controller.next);

    final elipsis = Padding(
      padding: style.itemPadding,
      child: DecoratedBox(
        decoration: style.unselectedDecoration,
        child: ConstrainedBox(
          constraints: style.contentConstraints,
          child: DefaultTextStyle(
            style: style.unselectedTextStyle,
            child: const Center(child: Text('...')),
          ),
        ),
      ),
    );

    final range = controller.calculateSiblingRange();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        previous,
        if (controller.value > controller.minPagesDisplayedAtEdges + 1) ...[
          if (controller.showEdges)
            FPaginationItemData(
              page: 1,
              style: style,
              controller: controller,
              child: const _Page(),
            ),
          elipsis,
        ],
        for (int i = range.$1; i <= range.$2; i++)
          FPaginationItemData(
            page: i,
            style: style,
            controller: controller,
            child: const _Page(),
          ),
        if (controller.value < (controller.length - controller.minPagesDisplayedAtEdges)) ...[
          elipsis,
          if (controller.showEdges)
            FPaginationItemData(
              page: controller.length,
              style: style,
              controller: controller,
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

  final int page;
  final FPaginationController controller;
  final FPaginationStyle style;

  const FPaginationItemData({
    required this.page,
    required this.controller,
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FPaginationItemData old) =>
      page != old.page || controller != old.controller || style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('page', page))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style));
  }
}

@internal
class Action extends StatelessWidget {
  final VoidCallback onPress;
  final FPaginationStyle style;
  final Widget child;

  const Action({
    required this.onPress,
    required this.style,
    required this.child,
  });

  Action.previous({
    required this.style,
    required this.onPress,
  }) : child = FIcon(
          FAssets.icons.chevronLeft,
          color: style.iconStyle.color,
          size: style.iconStyle.size,
        );

  Action.next({
    required this.onPress,
    required this.style,
  }) : child = FIcon(
          FAssets.icons.chevronRight,
          color: style.iconStyle.color,
          size: style.iconStyle.size,
        );

  @override
  Widget build(BuildContext context) => Padding(
        padding: style.itemPadding,
        child: FTappable(
          semanticLabel: 'Pagination action',
          focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
          onPress: onPress,
          builder: (context, tappableData, child) => DecoratedBox(
            decoration: switch (tappableData.hovered) {
              (false) => style.unselectedDecoration,
              (true) => style.hoveredDecoration,
            },
            child: ConstrainedBox(
              constraints: style.contentConstraints,
              child: DefaultTextStyle(
                style: style.unselectedTextStyle,
                child: Center(child: child!),
              ),
            ),
          ),
          child: child,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    final FPaginationItemData(page: pageNumber, :controller, style: style) = FPaginationItemData.of(context);

    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return Padding(
      padding: style.itemPadding,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, __) {
          final selected = pageNumber == value;
          return FTappable(
            focusedOutlineStyle: focusedOutlineStyle,
            onPress: () => controller.value = pageNumber,
            builder: (context, tappableData, child) => DecoratedBox(
              decoration: switch ((selected, tappableData.hovered)) {
                (false, false) => style.unselectedDecoration,
                (false, true) => style.hoveredDecoration,
                (true, true) => style.selectedHoveredDecoration,
                (true, false) => style.selectedDecoration,
              },
              child: ConstrainedBox(
                constraints: style.contentConstraints,
                child: DefaultTextStyle(
                  style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
                  child: child!,
                ),
              ),
            ),
            child: Center(child: Text('$pageNumber')),
          );
        },
      ),
    );
  }
}
