import 'package:forui/forui.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FValueNotifier<int> {
  final int length;

  /// the number of sibling pages beside the selected page number.
  final int siblingLength;
  final bool showFirstLastPages;

  /// Creates a [FPaginationController].
  ///
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [length] < 0.
  /// * Throws [AssertionError] if [siblingLength] < 0.
  FPaginationController({
    required this.length,
    int? initialPage,
    this.showFirstLastPages = true,
    this.siblingLength = 1,

  })  : assert(length >= 0, 'The count value must be greater than or equal to 0.'),
        assert(
          siblingLength >= 1 && siblingLength <= length,
          'The minDisplayed value must be greater than or equal to 1.',
        ),
        assert(
          initialPage == null || initialPage <= length && initialPage >= 1,
          'The initial value must be greater than or equal to 0 and less than count.',
        ),
        super(initialPage ?? 0);

  /// moves to the previous page.
  void previous() {
    if (value > 1) {
      value = value - 1;
    }
  }

  /// moves to the next page.
  void next() {
    if (value < length) {
      value = value + 1;
    }
  }

  // /// selects the page at the given [index], returning true if selected.
  // ///
  // /// This method should typically not be called while the widget tree is being rebuilt.
  // void select(int index) async {
  //   if (validate(index)) {
  //     value = index;
  //     notifyListeners();
  //     return true;
  //   }
  //   return false;
  // }

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
    print('visiblePageOffset: $siblingLength');
    print('minDisplayed: $minPagesDisplayedAtEnds');

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

  int get minPagesDisplayedAtEnds {
    final firstLastOffset = showFirstLastPages ? 1 : 0;
    return siblingLength + 1 + firstLastOffset;
  }

  /// Returns true if given index is within the allowed range.
  bool validate(int page) => page >= 1 && page <= length;
}
