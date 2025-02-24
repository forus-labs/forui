import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

/// A controller that controls which page is selected.
class FPaginationController extends PageController {
  /// The total number of pages.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [length] < 0.
  final int length;

  /// The number of sibling pages displayed beside the current page number. Defaults to 1.
  ///
  /// This value determines how many pages are shown on either side of the
  /// currently selected page in the pagination.
  ///
  /// For example, if `siblings` is 2 and the current page is 5,
  /// the displayed pages would be 3, 4, 5, 6, and 7.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [siblings] < 0.
  final int siblings;

  /// Whether to show the first and last pages in the pagination. Defaults to `true`.
  ///
  /// If `true`, the pagination will always display the first and last page, regardless of the current page.
  /// This can be useful for allowing users to quickly navigate to the beginning or end of the paginated content.
  final bool showEdges;

  int _value;

  /// Creates a [FPaginationController].
  ///
  /// # Contract:
  /// * Throws [AssertionError] if 1 <= [page] and [page] <= length.
  FPaginationController({
    required this.length,
    int page = 0,
    this.showEdges = true,
    this.siblings = 1,
    super.onAttach,
    super.onDetach,
    super.keepPage,
    super.viewportFraction,
  }) : assert(
         0 < length,
         ''
         'The total length of pages should be more than 0, but is $length.',
       ),
       assert(0 <= siblings, 'The siblingLength should be non-negative, but is $siblings'),
       assert(
         0 <= page && page <= length,
         'The initial page must be greater than or equal to 0 and less than or equal to length.',
       ),
       _value = page,
       super(initialPage: page) {
    addListener(_handleScrollChanges);
  }

  void _handleScrollChanges() {
    if (hasClients) {
      if (page != null && page!.round() != _value) {
        _value = page!.round();
        notifyListeners();
      }
    }
  }

  /// Moves to the previous page if the current page is greater than 1.
  void previous() {
    final value = hasClients && page != null ? page!.round() : _value;
    if (0 < value) {
      _value = value - 1;

      if (hasClients) {
        super.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
      notifyListeners();
    }
  }

  /// Moves to the next page if the current page is less than the total number of pages.
  void next() {
    final value = hasClients && page != null ? page!.round() : _value;
    if (value < length - 1) {
      _value = value + 1;

      if (hasClients) {
        super.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
      notifyListeners();
    }
  }

  /// Returns the current page index.
  int get value => _value;

  /// Sets the current page index.
  set value(int index) {
    if (0 <= index && index <= length) {
      _value = index;

      if (hasClients) {
        super.jumpToPage(index);
      }
      notifyListeners();
    } else {
      throw StateError('The index must be within the allowed range.');
    }
  }

  @override
  void dispose() {
    removeListener(_handleScrollChanges);
    super.dispose();
  }

  /// Calculates the range of page numbers to display around the current page.
  ///
  /// Returns a tuple of the start and end page numbers by centering the range around the current page,
  /// ensuring a balanced display of sibling pages on either side while considering pagination constraints.
  (int, int) calculateSiblingRange() {
    final last = length - 1;
    if (length <= minPagesDisplayedAtEdges) {
      return (0, last);
    }
    final rangeStart =
        _value - siblings < 0
            ? 0
            : _value > (last - minPagesDisplayedAtEdges)
            ? (last - minPagesDisplayedAtEdges) - siblings
            : _value <= minPagesDisplayedAtEdges
            ? 0
            : _value - siblings;

    final rangeEnd =
        _value + siblings > last
            ? last
            : _value < minPagesDisplayedAtEdges + 1
            ? minPagesDisplayedAtEdges + siblings
            : _value >= (last - minPagesDisplayedAtEdges)
            ? last
            : _value + siblings;

    return (rangeStart, rangeEnd);
  }

  /// Returns the minimum number of pages to display at both the start and end of the pagination.
  ///
  /// If the total number of pages is too small to accommodate both the edge pages
  /// and the full set of sibling pages around the current page, all pages are displayed instead.
  @internal
  int get minPagesDisplayedAtEdges {
    final minDisplayedAtEnds = siblings + 1 + (showEdges ? 1 : 0);
    return length <= (minDisplayedAtEnds + (siblings * 2 + 2)) ? length : minDisplayedAtEnds;
  }
}
