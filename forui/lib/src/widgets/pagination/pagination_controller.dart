import 'package:forui/forui.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FValueNotifier<int> {
  final int length;
  final int visiblePageOffset;

  /// Creates a [FPaginationController].
  ///
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [length] < 0.
  /// * Throws [AssertionError] if [visiblePageOffset] < 0.
  FPaginationController({
    required this.length,
    int? initialPage,
    this.visiblePageOffset = 2,
  })  : assert(length >= 0, 'The count value must be greater than or equal to 0.'),
        assert(
          visiblePageOffset >= 1 && visiblePageOffset <= length,
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
    //final minDisplayed = visiblePageOffset * 2 + 5;

    print('value: $value');
    print('visiblePageOffset: $visiblePageOffset');
    print('minDisplayed: $minDisplayed');

    final rangeStart = value - visiblePageOffset < 1
        ? 1
        : value - visiblePageOffset > (length - minDisplayed)
            ? (length- minDisplayed)
            : value - visiblePageOffset;
    print('rangeStart: $rangeStart');

    final rangeEnd = value + visiblePageOffset > length
        ? length
        : value + visiblePageOffset < minDisplayed + 1
            ? minDisplayed + 1
            : value + visiblePageOffset;

    print('rangeEnd: $rangeEnd');

    return (rangeStart, rangeEnd);
  }


  int get minDisplayed => visiblePageOffset * 2 + 2;

  /// Returns true if given index is within the allowed range.
  bool validate(int page) => page >= 1 && page <= length;
}
