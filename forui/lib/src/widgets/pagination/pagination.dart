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
  final VoidCallback? onChange;

  /// Creates an [FPagination].
  const FPagination({required this.controller, this.style, this.previous, this.next, this.onChange, super.key});

  @override
  State<FPagination> createState() => _FPaginationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPageChange', onChange));
  }
}

class _FPaginationState extends State<FPagination> {
  @override
  void initState() {
    super.initState();
    if (widget.onChange case final onChange?) {
      widget.controller.addListener(onChange);
    }
  }

  @override
  void didUpdateWidget(covariant FPagination old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller || widget.onChange != old.onChange) {
      if (old.onChange case final onChange?) {
        old.controller.removeListener(onChange);
      }

      if (widget.onChange case final onChange?) {
        widget.controller.addListener(onChange);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final style = widget.style ?? context.theme.paginationStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    final previous =
        widget.previous ??
        Action(
          style: style,
          semanticsLabel: localizations.paginationPreviousSemanticsLabel,
          onPress: controller.previous,
          child: const Icon(FIcons.chevronLeft),
        );
    final next =
        widget.next ??
        Action(
          style: style,
          semanticsLabel: localizations.paginationNextSemanticsLabel,
          onPress: controller.next,
          child: const Icon(FIcons.chevronRight),
        );

    final lastPage = controller.pages - 1;

    final ellipsis = Padding(
      padding: style.itemPadding,
      child: ConstrainedBox(
        constraints: style.itemConstraints,
        child: DefaultTextStyle(style: style.ellipsisTextStyle, child: const Center(child: Text('...'))),
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
                FPaginationItemData(page: 0, style: style, controller: controller, child: const _Page()),
              ellipsis,
            ],
            for (int i = start; i <= end; i++)
              FPaginationItemData(page: i, style: style, controller: controller, child: const _Page()),
            if (controller.page < (lastPage - controller.minPagesDisplayedAtEdges)) ...[
              ellipsis,
              if (controller.showEdges)
                FPaginationItemData(page: lastPage, style: style, controller: controller, child: const _Page()),
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

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.itemPadding,
    child: FTappable(
      style: style.actionTappableStyle,
      semanticsLabel: semanticsLabel,
      focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
      onPress: onPress,
      builder:
          (context, states, child) => DecoratedBox(
            decoration: style.itemDecoration.resolve(states),
            child: ConstrainedBox(
              constraints: style.itemConstraints,
              child: DefaultTextStyle(
                style: style.itemTextStyle.resolve(states),
                child: Center(child: IconTheme(data: style.itemIconStyle.resolve(states), child: child!)),
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
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
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
        builder:
            (context, _) => FTappable(
              style: style.pageTappableStyle,
              focusedOutlineStyle: focusedOutlineStyle,
              onPress: () => controller.page = page,
              builder: (context, states, _) {
                states = {...states, if (controller.page == page) WidgetState.selected};

                return DecoratedBox(
                  decoration: style.itemDecoration.resolve(states),
                  child: ConstrainedBox(
                    constraints: style.itemConstraints,
                    child: DefaultTextStyle(
                      style: style.itemTextStyle.resolve(states),
                      child: Center(child: Text('${page + 1}')),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
