import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/pagination/pagination_controller.dart';

/// A pagination allows the user to select a specific page from a range of pages.
///
/// See:
/// * https://forui.dev/docs/navigation/pagination for working examples.
/// * [FPaginationController] for customizing the pagination's behavior.
/// * [FPaginationStyle] for customizing the pagination's appearance.
class FPagination extends StatefulWidget {
  /// The control that manages the pagination's state.
  final FPaginationControl control;

  /// The pagination's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create pagination
  /// ```
  final FPaginationStyle Function(FPaginationStyle style)? style;

  /// The previous button placed at the beginning of the pagination.
  ///
  /// Defaults to an `FIcons.chevronLeft` icon.
  final Widget? previous;

  /// The next button placed at the end of the pagination.
  ///
  /// Defaults to an `FIcons.chevronRight` icon.
  final Widget? next;

  /// Creates an [FPagination].
  const FPagination({this.control = const .managed(), this.style, this.previous, this.next, super.key});

  @override
  State<FPagination> createState() => _FPaginationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style));
  }
}

class _FPaginationState extends State<FPagination> {
  late FPaginationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange);
  }

  @override
  void didUpdateWidget(covariant FPagination old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleOnChange).$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FPaginationManagedControl(:final onChange?)) {
      onChange(_controller.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.paginationStyle) ?? context.theme.paginationStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    final previous =
        widget.previous ??
        Action(
          style: style,
          semanticsLabel: localizations.paginationPreviousSemanticsLabel,
          onPress: _controller.previous,
          child: const Icon(FIcons.chevronLeft),
        );
    final next =
        widget.next ??
        Action(
          style: style,
          semanticsLabel: localizations.paginationNextSemanticsLabel,
          onPress: _controller.next,
          child: const Icon(FIcons.chevronRight),
        );

    final lastPage = _controller.pages - 1;

    final ellipsis = Padding(
      padding: style.itemPadding,
      child: ConstrainedBox(
        constraints: style.itemConstraints,
        child: DefaultTextStyle(
          style: style.ellipsisTextStyle,
          child: const Center(child: Text('...')),
        ),
      ),
    );

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final (start, end) = _controller.siblingRange;

        return Row(
          mainAxisAlignment: .center,
          children: [
            previous,
            if (_controller.page > _controller.minPagesDisplayedAtEdges) ...[
              if (_controller.showEdges)
                FPaginationItemData(page: 0, style: style, controller: _controller, child: const _Page()),
              ellipsis,
            ],
            for (int i = start; i <= end; i++)
              FPaginationItemData(page: i, style: style, controller: _controller, child: const _Page()),
            if (_controller.page < (lastPage - _controller.minPagesDisplayedAtEdges)) ...[
              ellipsis,
              if (_controller.showEdges)
                FPaginationItemData(page: lastPage, style: style, controller: _controller, child: const _Page()),
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
    assert(debugCheckHasAncestor<FPaginationItemData>('$FPagination', context));
    return context.dependOnInheritedWidgetOfExactType<FPaginationItemData>()!;
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
      builder: (context, states, child) => DecoratedBox(
        decoration: style.itemDecoration.resolve(states),
        child: ConstrainedBox(
          constraints: style.itemConstraints,
          child: DefaultTextStyle(
            style: style.itemTextStyle.resolve(states),
            child: Center(
              child: IconTheme(data: style.itemIconStyle.resolve(states), child: child!),
            ),
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
    return Padding(
      padding: style.itemPadding,
      child: ListenableBuilder(
        listenable: controller,
        builder: (_, _) => FTappable(
          style: style.pageTappableStyle,
          focusedOutlineStyle: style.focusedOutlineStyle,
          selected: controller.page == page,
          onPress: () => controller.page = page,
          builder: (_, states, _) => DecoratedBox(
            decoration: style.itemDecoration.resolve(states),
            child: ConstrainedBox(
              constraints: style.itemConstraints,
              child: DefaultTextStyle(
                style: style.itemTextStyle.resolve(states),
                child: Center(child: Text('${page + 1}')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
