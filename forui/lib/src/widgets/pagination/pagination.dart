import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination_controller.dart';

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

  /// The previous button placed at the beginning of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronLeft` icon.
  final Widget? previous;

  /// The next button placed at the end of the pagination.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final Widget? next;

  /// Creates an [FPagination].
  const FPagination({required this.controller, this.style, this.previous, this.next, super.key});

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller.page =
        PageStorage.maybeOf(context)?.readState(context) ?? widget.controller.controller.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final style = widget.style ?? context.theme.paginationStyle;
    final previous = widget.previous ?? Action.previous(style: style, onPress: controller.previous);
    final next = widget.next ?? Action.next(style: style, onPress: controller.next);
    final lastPage = controller.pages - 1;

    final elipsis = Padding(
      padding: style.itemPadding,
      child: DecoratedBox(
        decoration: style.unselected.decoration,
        child: ConstrainedBox(
          constraints: style.contentConstraints,
          child: DefaultTextStyle(style: style.unselected.textStyle, child: const Center(child: Text('...'))),
        ),
      ),
    );

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final (start, end) = controller.calculateSiblingRange();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            previous,
            if (controller.page > controller.minPagesDisplayedAtEdges) ...[
              if (controller.showEdges && lastPage.isFinite)
                FPaginationItemData(page: 0, style: style, controller: controller, child: const _Page()),
              elipsis,
            ],
            for (int i = start; i <= end; i++)
              FPaginationItemData(page: i, style: style, controller: controller, child: const _Page()),
            if (controller.page < (lastPage - controller.minPagesDisplayedAtEdges)) ...[
              elipsis,
              if (controller.showEdges && lastPage.isFinite)
                FPaginationItemData(page: lastPage.toInt(), style: style, controller: controller, child: const _Page()),
            ],
            next,
          ],
        );
      },
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

  const Action({required this.onPress, required this.style, required this.child, super.key});

  Action.previous({required this.style, required this.onPress, super.key})
    : child = FIcon(FAssets.icons.chevronLeft, color: style.iconStyle.color, size: style.iconStyle.size);

  Action.next({required this.onPress, required this.style, super.key})
    : child = FIcon(FAssets.icons.chevronRight, color: style.iconStyle.color, size: style.iconStyle.size);

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.itemPadding,
    child: FTappable(
      semanticLabel: 'Pagination action',
      focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
      onPress: onPress,
      builder:
          (context, tappableData, child) => DecoratedBox(
            decoration: switch (tappableData.hovered) {
              (false) => style.unselected.decoration,
              (true) => style.unselected.hoveredDecoration,
            },
            child: ConstrainedBox(
              constraints: style.contentConstraints,
              child: DefaultTextStyle(style: style.unselected.textStyle, child: Center(child: child!)),
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
    final FPaginationItemData(:page, :controller, :style) = FPaginationItemData.of(context);

    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return Padding(
      padding: style.itemPadding,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final selected = controller.page == page;

          return FTappable(
            focusedOutlineStyle: focusedOutlineStyle,
            onPress: () => controller.page = page,
            builder:
                (context, tappableData, _) => DecoratedBox(
                  decoration: switch ((selected, tappableData.hovered)) {
                    (false, false) => style.unselected.decoration,
                    (false, true) => style.unselected.hoveredDecoration,
                    (true, true) => style.selected.hoveredDecoration,
                    (true, false) => style.selected.decoration,
                  },
                  child: ConstrainedBox(
                    constraints: style.contentConstraints,
                    child: DefaultTextStyle(
                      style: selected ? style.selected.textStyle : style.unselected.textStyle,
                      child: Center(child: Text('${page + 1}')),
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
