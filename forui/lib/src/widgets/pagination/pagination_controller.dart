// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

part 'pagination_controller.control.dart';

/// A controller that controls which page is selected.
class FPaginationController extends ValueNotifier<int> {
  /// The total number of pages.
  final int pages;

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

  /// Creates a [FPaginationController].
  ///
  /// # Contract:
  /// * Throws [AssertionError] if 0 <= [page] and [page] < [pages].
  FPaginationController({required this.pages, int page = 0, this.siblings = 1, this.showEdges = true})
    : assert(0 < pages, 'pages ($pages) should be > 0'),
      assert(0 <= siblings, 'siblings ($siblings) >= 0'),
      assert(0 <= page && page < pages, 'initialPage ($page) must be between 0 and pages ($pages), exclusive.'),
      super(page);

  /// Moves to the next page if the current page is less than the total number of pages.
  void next() {
    if (_rawValue < pages - 1) {
      _rawValue++;
    }
  }

  /// Moves to the previous page if the current page is greater than 1.
  void previous() {
    if (0 < _rawValue) {
      _rawValue--;
    }
  }

  /// The start and end pages to display around the current page.
  (int, int) get siblingRange {
    final last = pages - 1;
    if (pages <= minPagesDisplayedAtEdges) {
      return (0, last);
    }

    return (
      switch (_rawValue) {
        _ when _rawValue - siblings < 0 => 0,
        _ when _rawValue > (last - minPagesDisplayedAtEdges) => (last - minPagesDisplayedAtEdges) - siblings,
        _ when _rawValue <= minPagesDisplayedAtEdges => 0,
        _ => _rawValue - siblings,
      },
      switch (_rawValue) {
        _ when _rawValue + siblings > last => last,
        _ when _rawValue < minPagesDisplayedAtEdges + 1 => minPagesDisplayedAtEdges + siblings,
        _ when _rawValue >= (last - minPagesDisplayedAtEdges) => last,
        _ => _rawValue + siblings,
      },
    );
  }

  @override
  set value(int value) {
    if (value >= pages || value < 0) {
      throw StateError('The index must be within the allowed range.');
    }
    _rawValue = value;
  }

  int get _rawValue => super.value;

  set _rawValue(int value) => super.value = value;
}

@internal
extension InternalFPaginationController on FPaginationController {
  /// The minimum number of pages to display at both the start and end of the pagination.
  ///
  /// If the total number of pages is too small to accommodate both the edge pages
  /// and the full set of sibling pages around the current page, all pages are displayed instead.
  int get minPagesDisplayedAtEdges {
    final minDisplayedAtEnds = siblings + 1 + (showEdges ? 1 : 0);
    return pages <= (minDisplayedAtEnds + (siblings * 2 + 2)) ? pages : minDisplayedAtEnds;
  }
}

class _ProxyController extends FPaginationController {
  int _unsynced;
  ValueChanged<int> _onChange;
  int _pages;
  int _siblings;
  bool _showEdges;

  _ProxyController(this._unsynced, this._onChange, this._pages, this._siblings, this._showEdges)
    : super(page: _unsynced, pages: _pages, siblings: _siblings, showEdges: _showEdges);

  void update(int page, ValueChanged<int> onChange, int pages, int siblings, bool showEdges) {
    final changed = _pages != pages || _siblings != siblings || _showEdges != showEdges;
    _onChange = onChange;
    _pages = pages;
    _siblings = siblings;
    _showEdges = showEdges;

    if (super._rawValue != page) {
      _unsynced = page;
      super._rawValue = page;
    } else if (_unsynced != page || changed) {
      _unsynced = page;
      notifyListeners();
    }
  }

  @override
  int get pages => _pages;

  @override
  int get siblings => _siblings;

  @override
  bool get showEdges => _showEdges;

  @override
  set _rawValue(int value) {
    if (super.value != value) {
      _unsynced = value;
      _onChange(value);
    }
  }
}

/// A [FPaginationControl] defines how a [FPagination] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FPaginationControl with Diagnosticable, _$FPaginationControlMixin {
  /// Creates a [FPaginationControl].
  const factory FPaginationControl.managed({
    FPaginationController? controller,
    int? initial,
    int? pages,
    int? siblings,
    bool showEdges,
    ValueChanged<int>? onChange,
  }) = FPaginationManagedControl;

  /// Creates a [FPaginationControl] for controlling pagination using lifted state.
  ///
  /// The [page] parameter contains the current page index.
  /// The [onChange] callback is invoked when the user changes the page.
  const factory FPaginationControl.lifted({
    required int page,
    required ValueChanged<int> onChange,
    required int pages,
    int siblings,
    bool showEdges,
  }) = _Lifted;

  const FPaginationControl._();

  (FPaginationController, bool) _update(
    FPaginationControl old,
    FPaginationController controller,
    VoidCallback callback,
  );
}

/// A [FPaginationManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FPaginationManagedControl extends FPaginationControl with Diagnosticable, _$FPaginationManagedControlMixin {
  /// The controller.
  @override
  final FPaginationController? controller;

  /// The initial page index. Defaults to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final int? initial;

  /// The total number of pages. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [pages] and [controller] are both provided.
  @override
  final int? pages;

  /// The number of sibling pages to show. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [siblings] and [controller] are both provided.
  @override
  final int? siblings;

  /// Whether to show first/last page buttons. Defaults to true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [showEdges] and [controller] are both provided.
  @override
  final bool? showEdges;

  /// Called when the page changes.
  @override
  final ValueChanged<int>? onChange;

  /// Creates a [FPaginationControl].
  const FPaginationManagedControl({
    this.controller,
    this.initial,
    this.pages,
    this.siblings,
    this.showEdges,
    this.onChange,
  }) : assert(
         controller == null || initial == null,
         'Cannot provide both controller and initial page. Pass initial page to the controller.',
       ),
       assert(
         controller == null || pages == null,
         'Cannot provide both controller and pages. Pass pages to the controller.',
       ),
       assert(
         controller == null || siblings == null,
         'Cannot provide both controller and siblings. Pass siblings to the controller.',
       ),
       assert(
         controller == null || showEdges == null,
         'Cannot provide both controller and showEdges. Pass showEdges to the controller.',
       ),
       super._();

  @override
  FPaginationController createController() =>
      controller ?? .new(page: initial ?? 0, pages: pages ?? 1, siblings: siblings ?? 1, showEdges: showEdges ?? true);
}

class _Lifted extends FPaginationControl with _$_LiftedMixin {
  @override
  final int page;
  @override
  final ValueChanged<int> onChange;
  @override
  final int pages;
  @override
  final int siblings;
  @override
  final bool showEdges;

  const _Lifted({
    required this.page,
    required this.onChange,
    required this.pages,
    this.siblings = 1,
    this.showEdges = true,
  }) : super._();

  @override
  FPaginationController createController() => _ProxyController(page, onChange, pages, siblings, showEdges);

  @override
  void _updateController(FPaginationController controller) =>
      (controller as _ProxyController).update(page, onChange, pages, siblings, showEdges);
}
