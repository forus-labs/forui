import 'package:forui/forui.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FValueNotifier<int> {
  /// The total number of pages in the paginated content.
  final int length;

  /// The number of sibling pages to display beside the selected page number.
  ///
  /// This value determines how many pages are shown on either side of the
  /// currently selected page in the pagination control.
  ///
  /// For example, if `siblingLength` is 2 and the current page is 5,
  /// the displayed pages would be 3, 4, 5, 6, and 7.
  final int siblingLength;

  /// Whether to show the first and last pages in the pagination control.
  ///
  /// If `true`, the pagination control will always display the first and
  /// last pages, regardless of the current page.
  ///
  /// This can be useful for allowing users to quickly navigate
  /// to the beginning or end of the paginated content.
  final bool showFirstLastPages;

  /// Creates a [FPaginationController].
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [length] < 0.
  /// * Throws [AssertionError] if [siblingLength] < 0.
  FPaginationController({
    required this.length,
    int? initialPage,
    this.showFirstLastPages = true,
    this.siblingLength = 1,
  })  :  assert(length > 0, 'The total length of pages should be more than 0, but is $length.'),
        assert(siblingLength >= 0, 'The siblingLength should be non-negative, but is $siblingLength'),
        assert(
        initialPage == null || (initialPage >= 1 && initialPage <= length),
        'The initial value must be greater than or equal to 1 and less than or equal to length.',
        ),
        super(initialPage ?? 0);

  /// Moves to the previous page if the current page is greater than 1.
  void previous() {
    if (value > 1) {
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
    if (validate(newValue)) {
      super.value = newValue;
    } else {
      throw StateError('The index must be within the allowed range.');
    }
  }

  /// Calculates the start of the range for page numbers to display.
  (int, int) calculateRange() {
    print('value: $value');
    print('siblingLength: $siblingLength');
    print('minDisplayed: $minPagesDisplayedAtEnds');

    if (length <= minPagesDisplayedAtEnds) {
      return (1, length);
    }

    final rangeStart = value - siblingLength < 1
        ? 1
        : value > (length - minPagesDisplayedAtEnds)
            ? (length - minPagesDisplayedAtEnds) - siblingLength
            : value <= minPagesDisplayedAtEnds + 1
                ? 1
                : value - siblingLength;
    print('rangeStart: $rangeStart');

    final rangeEnd = value + siblingLength > length
        ? length
        : value < minPagesDisplayedAtEnds + 1
            ? minPagesDisplayedAtEnds + 1 + siblingLength
            : value >= (length - minPagesDisplayedAtEnds)
                ? length
                : value + siblingLength;

    print('rangeEnd: $rangeEnd');

    return (rangeStart, rangeEnd);
  }

  /// Returns the minimum number of pages to display at the start and end before the selected page number.
  ///
  /// If the total number of pages is less than the minimum number of pages to display at the start and end,
  /// plus a full cycle of sibling pages on either side of the selected page number,
  /// the total number of pages is returned.
  int get minPagesDisplayedAtEnds {
    final minDisplayedAtEnds = siblingLength + 1 + (showFirstLastPages ? 1 : 0);
    return length <= minDisplayedAtEnds + (siblingLength * 2 + 2) ? length : minDisplayedAtEnds;
  }

  /// Returns `true` if the page is within the range of 1 to [length], inclusive.
  bool validate(int page) => page >= 1 && page <= length;
}
