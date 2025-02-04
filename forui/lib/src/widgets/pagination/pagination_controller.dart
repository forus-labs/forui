import 'package:forui/forui.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FValueNotifier<int> {
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

  /// Creates a [FPaginationController].
  ///
  /// # Contract:
  /// * Throws [AssertionError] if 1 <= [page] and [page] <= length.
  FPaginationController({
    required this.length,
    int page = 1,
    this.showEdges = true,
    this.siblings = 1,
  })  : assert(0 < length, 'The total length of pages should be more than 0, but is $length.'),
        assert(0 <= siblings, 'The siblingLength should be non-negative, but is $siblings'),
        assert(
          1 <= page && page <= length,
          'The initial value must be greater than or equal to 1 and less than or equal to length.',
        ),
        super(page);

  /// Moves to the previous page if the current page is greater than 1.
  void previous() {
    if (1 < value) {
      value = value - 1;
    }
  }

  /// Moves to the next page if the current page is less than the total number of pages.
  void next() {
    if (value < length) {
      value = value + 1;
    }
  }

  @override
  set value(int newValue) {
    if (1 <= newValue && newValue <= length) {
      super.value = newValue;
    } else {
      throw StateError('The index must be within the allowed range.');
    }
  }

  /// Calculates the range of page numbers to display around the current page.
  ///
  /// Returns a tuple of the start and end page numbers by centering the range around the current page,
  /// ensuring a balanced display of sibling pages on either side while considering pagination constraints.
  (int, int) calculateSiblingRange() {
    if (length <= minPagesDisplayedAtEdges) {
      return (1, length);
    }

    final rangeStart = value - siblings < 1
        ? 1
        : value > (length - minPagesDisplayedAtEdges)
            ? (length - minPagesDisplayedAtEdges) - siblings
            : value <= minPagesDisplayedAtEdges + 1
                ? 1
                : value - siblings;

    final rangeEnd = value + siblings > length
        ? length
        : value < minPagesDisplayedAtEdges + 1
            ? minPagesDisplayedAtEdges + 1 + siblings
            : value >= (length - minPagesDisplayedAtEdges)
                ? length
                : value + siblings;

    return (rangeStart, rangeEnd);
  }

  /// Returns the minimum number of pages to display at both the start and end of the pagination.
  ///
  /// If the total number of pages is too small to accommodate both the edge pages
  /// and the full set of sibling pages around the current page, all pages are displayed instead.
  int get minPagesDisplayedAtEdges {
    final minDisplayedAtEnds = siblings + 1 + (showEdges ? 1 : 0);
    return length <= (minDisplayedAtEnds + (siblings * 2 + 2)) ? length : minDisplayedAtEnds;
  }
}
