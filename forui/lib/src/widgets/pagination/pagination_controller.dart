import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FValueNotifier<int> {
  final int count;
  final int minDisplayed;

  /// Creates a [FPaginationController].
  ///
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [count] < 0.
  /// * Throws [AssertionError] if [minDisplayed] < 0.
  FPaginationController({
    int? value,
    this.count = 3,
    this.minDisplayed = 1,
  })  : assert(count >= 0, 'The count value must be greater than or equal to 0.'),
        assert(minDisplayed >= 1, 'The minDisplayed value must be greater than or equal to 1.'),
        super(value ?? 0);

  /// moves to the previous page.
  void previous() {
    if (value > 0) {
      value--;
      notifyListeners();
    }
  }

  /// moves to the next page.
  void next() {
    if (value < count) {
      value++;
      notifyListeners();
    }
  }

  /// selects the page at the given [index], returning true if selected.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<bool> select(int index) async {
    if (index >= 0 && index <= count) {
      value = index;
      notifyListeners();
      return true;
    }
    return false;
  }
}
