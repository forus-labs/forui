import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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
  FPaginationController({int initialPage = 0, this.pages = 1, this.showEdges = true, this.siblings = 1})
    : assert(0 < pages, 'The total length of pages should be more than 0, but is $pages.'),
      assert(0 <= siblings, 'The siblingLength should be non-negative, but is $siblings'),
      assert(
        0 <= initialPage && initialPage < pages,
        'The initial page must be greater than or equal to 0 and less than pages.',
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
extension MinPagesDisplayedAtEdges on FPaginationController {
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
