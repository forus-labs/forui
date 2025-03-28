import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination_controller.dart';

/// A pagination allows the user to select a specific page from a range of pages.
///
/// See:
/// * https://forui.dev/docs/navigation/pagination for working examples.
/// * [FPaginationController] for customizing the pagination's behavior.
/// * [FPaginationStyle] for customizing the pagination's appearance.
final class FPagination extends StatefulWidget {
  /// The controller.
  final FPaginationController controller;

  /// The pagination's style.
  final FPaginationStyle? style;

  /// The previous button placed at the beginning of the pagination.
  ///
  /// Defaults to an `FIcons.chevronLeft` icon.
  final Widget? previous;

  /// The next button placed at the end of the pagination.
  ///
  /// Defaults to an `FIcons.chevronRight` icon.
  final Widget? next;

  /// A callback triggered when the current page changes.
  ///
  /// Invoked when the `page` property of the [FPaginationController] is updated.
  /// Useful for actions like updating the UI or triggering analytics events.
  final VoidCallback? onPageChange;

  /// Creates an [FPagination].
  const FPagination({required this.controller, this.style, this.previous, this.next, this.onPageChange, super.key});

  @override
  State<FPagination> createState() => _FPaginationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPageChange', onPageChange));
  }
}

class _FPaginationState extends State<FPagination> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final style = widget.style ?? context.theme.paginationStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final previous =
        widget.previous ??
        Action.previous(
          style: style,
          semanticsLabel: localizations.paginationPreviousSemanticsLabel,
          onPress: () {
            controller.previous();
            widget.onPageChange?.call();
          },
        );
    final next =
        widget.next ??
        Action.next(
          style: style,
          semanticsLabel: localizations.paginationNextSemanticsLabel,
          onPress: () {
            controller.next();
            widget.onPageChange?.call();
          },
        );
    final lastPage = controller.pages - 1;

    final ellipsis = Padding(
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
        final (start, end) = controller.siblingRange;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            previous,
            if (controller.page > controller.minPagesDisplayedAtEdges) ...[
              if (controller.showEdges)
                FPaginationItemData(page: 0, style: style, controller: controller, child: _Page(widget.onPageChange)),
              ellipsis,
            ],
            for (int i = start; i <= end; i++)
              FPaginationItemData(page: i, style: style, controller: controller, child: _Page(widget.onPageChange)),
            if (controller.page < (lastPage - controller.minPagesDisplayedAtEdges)) ...[
              ellipsis,
              if (controller.showEdges)
                FPaginationItemData(
                  page: lastPage,
                  style: style,
                  controller: controller,
                  child: _Page(widget.onPageChange),
                ),
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
  final FPaginationStyle style;
  final String semanticsLabel;
  final VoidCallback onPress;
  final Widget child;

  const Action({
    required this.style,
    required this.semanticsLabel,
    required this.onPress,
    required this.child,
    super.key,
  });

  Action.previous({required this.style, required this.semanticsLabel, required this.onPress, super.key})
    : child = Icon(FIcons.chevronLeft, color: style.iconStyle.color, size: style.iconStyle.size);

  Action.next({required this.style, required this.semanticsLabel, required this.onPress, super.key})
    : child = Icon(FIcons.chevronRight, color: style.iconStyle.color, size: style.iconStyle.size);

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.itemPadding,
    child: FTappable(
      style: style.actionTappableStyle,
      semanticsLabel: semanticsLabel,
      focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
      onPress: onPress,
      builder:
          (context, tappableData, child) => DecoratedBox(
            decoration: tappableData.hovered ? style.unselected.hoveredDecoration : style.unselected.decoration,
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
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

class _Page extends StatelessWidget {
  final VoidCallback? onPageChange;

  const _Page(this.onPageChange);

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
            style: style.pageTappableStyle,
            focusedOutlineStyle: focusedOutlineStyle,
            onPress: () {
              controller.page = page;
              onPageChange?.call();
            },
            builder:
                (context, data, _) => DecoratedBox(
                  decoration: switch ((selected, data.hovered)) {
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('onPageChange', onPageChange));
  }
}
