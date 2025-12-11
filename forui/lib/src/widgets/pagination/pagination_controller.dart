import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

part 'pagination_controller.control.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FChangeNotifier {
  /// The number of sibling pages displayed beside the current page number. Defaults to 1.
  ///
  /// This value determines how many pages are shown on either side of the currently selected page in the pagination.
  /// For example, if `siblings` is 2 and the current page is 5, the displayed pages would be 3, 4, 5, 6, and 7.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [siblings] < 0.
  final int siblings;

  /// Whether to show the first and last pages in the pagination. Defaults to `true`.
  ///
  /// If `true`, the pagination will always display the first and last page, regardless of the current page.
  /// This can be useful for allowing users to quickly navigate to the beginning or end of the paginated content.
  final bool showEdges;

  /// The total number of pages in the pagination.
  final int pages;
  int _page;

  /// Creates a [FPaginationController].
  ///
  /// # Contract:
  /// * Throws [AssertionError] if 0 <= [initialPage] and [initialPage] < [pages].
  FPaginationController({required this.pages, int initialPage = 0, this.showEdges = true, this.siblings = 1})
    : assert(0 < pages, 'pages ($pages) should be > 0'),
      assert(0 <= siblings, 'siblings ($siblings) >= 0'),
      assert(
        0 <= initialPage && initialPage < pages,
        'initialPage ($initialPage) must be between 0 and pages ($pages), exclusive.',
      ),
      _page = initialPage;

  /// The current page index.
  int get page => _page;

  set page(int index) {
    if (index >= pages || index < 0) {
      throw StateError('The index must be within the allowed range.');
    }
    _page = index;
    notifyListeners();
  }

  /// Moves to the previous page if the current page is greater than 1.
  void previous() {
    if (0 < _page) {
      _page = _page - 1;
      notifyListeners();
    }
  }

  /// Moves to the next page if the current page is less than the total number of pages.
  void next() {
    if (_page < pages - 1) {
      _page = _page + 1;
      notifyListeners();
    }
  }

  /// The start and end pages to display around the current page.
  (int, int) get siblingRange {
    final int rangeStart;
    final int rangeEnd;
    if (pages.isFinite) {
      final last = pages - 1;
      if (pages <= minPagesDisplayedAtEdges) {
        return (0, last);
      }
      rangeStart = switch (_page) {
        _ when _page - siblings < 0 => 0,
        _ when _page > (last - minPagesDisplayedAtEdges) => (last - minPagesDisplayedAtEdges) - siblings,
        _ when _page <= minPagesDisplayedAtEdges => 0,
        _ => _page - siblings,
      };

      rangeEnd = switch (_page) {
        _ when _page + siblings > last => last,
        _ when _page < minPagesDisplayedAtEdges + 1 => minPagesDisplayedAtEdges + siblings,
        _ when _page >= (last - minPagesDisplayedAtEdges) => last,
        _ => _page + siblings,
      };
    } else {
      rangeStart = switch (_page) {
        _ when _page - siblings < 0 => 0,
        _ when _page <= minPagesDisplayedAtEdges => 0,
        _ => _page - siblings,
      };

      rangeEnd = switch (_page) {
        _ when _page < minPagesDisplayedAtEdges + 1 => minPagesDisplayedAtEdges,
        _ => _page + siblings,
      };
    }
    return (rangeStart, rangeEnd);
  }
}

@internal
extension InternalPaginationController on FPaginationController {
  /// The minimum number of pages to display at both the start and end of the pagination.
  ///
  /// If the total number of pages is too small to accommodate both the edge pages
  /// and the full set of sibling pages around the current page, all pages are displayed instead.
  int get minPagesDisplayedAtEdges {
    if (pages.isFinite) {
      final minDisplayedAtEnds = siblings + 1 + (showEdges ? 1 : 0);
      return pages <= (minDisplayedAtEnds + (siblings * 2 + 2)) ? pages : minDisplayedAtEnds;
    }
    return siblings + 1 + (showEdges ? 1 : 0);
  }
}

class _Controller extends FPaginationController {
  int _value;
  ValueChanged<int> _onChange;

  _Controller({
    required int page,
    required super.pages,
    required ValueChanged<int> onChange,
    super.siblings,
    super.showEdges,
  }) : _value = page,
       _onChange = onChange,
       super();

  void update(int page, ValueChanged<int> onChange) {
    _onChange = onChange;
    if (_value != page) {
      _value = page;
      notifyListeners();
    }
  }

  @override
  int get _page => _value;

  @override
  set _page(int index) {
    _onChange(index);
  }
}

/// Defines how a [FPagination]'s page is controlled.
sealed class FPaginationControl with Diagnosticable, _$FPaginationControlMixin {
  /// Creates a [FPaginationControl] for controlling pagination using lifted state.
  ///
  /// The [page] parameter contains the current page index.
  /// The [onChange] callback is invoked when the user changes the page.
  const factory FPaginationControl.lifted({
    required int page,
    required int pages,
    required ValueChanged<int> onChange,
    int siblings,
    bool showEdges,
  }) = Lifted;

  /// Creates a [FPaginationControl] for controlling pagination using a controller.
  ///
  /// Either [controller] or [pages] can be provided. If neither is provided,
  /// an internal controller with 1 page is created.
  ///
  /// The [onChange] callback is invoked when the page changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  /// Throws [AssertionError] if both [controller] and [pages] are provided.
  const factory FPaginationControl.managed({
    FPaginationController? controller,
    int? initial,
    int? pages,
    int siblings,
    bool showEdges,
    ValueChanged<int>? onChange,
  }) = Managed;

  const FPaginationControl._();

  (FPaginationController, bool) _update(
    FPaginationControl old,
    FPaginationController controller,
    VoidCallback callback,
  );
}

@internal
class Lifted extends FPaginationControl with _$LiftedMixin {
  @override
  final int page;
  @override
  final int pages;
  @override
  final ValueChanged<int> onChange;
  @override
  final int siblings;
  @override
  final bool showEdges;

  const Lifted({
    required this.page,
    required this.pages,
    required this.onChange,
    this.siblings = 1,
    this.showEdges = true,
  }) : super._();

  @override
  FPaginationController _create(VoidCallback _) =>
      _Controller(page: page, pages: pages, onChange: onChange, siblings: siblings, showEdges: showEdges);

  @override
  void _updateController(FPaginationController controller) => (controller as _Controller).update(page, onChange);
}

@internal
class Managed extends FPaginationControl with Diagnosticable, _$ManagedMixin {
  @override
  final FPaginationController? controller;
  @override
  final int? initial;
  @override
  final int? pages;
  @override
  final int siblings;
  @override
  final bool showEdges;
  @override
  final ValueChanged<int>? onChange;

  const Managed({
    this.controller,
    this.initial,
    this.pages,
    this.siblings = 1,
    this.showEdges = true,
    this.onChange,
  }) : assert(
         controller == null || initial == null,
         'Cannot provide both controller and initial. Set the page directly in the controller.',
       ),
       assert(
         controller == null || pages == null,
         'Cannot provide both controller and pages. Set the pages directly in the controller.',
       ),
       assert(
         controller == null || siblings == 1,
         'Cannot provide both controller and siblings. Set siblings directly in the controller.',
       ),
       assert(
         controller == null || showEdges,
         'Cannot provide both controller and showEdges. Set showEdges directly in the controller.',
       ),
       super._();

  @override
  FPaginationController _create(VoidCallback callback) =>
      (controller ??
            FPaginationController(
              initialPage: initial ?? 0,
              pages: pages ?? 1,
              siblings: siblings,
              showEdges: showEdges,
            ))
        ..addListener(callback);
}
