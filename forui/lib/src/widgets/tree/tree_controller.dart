import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

/// A controller that controls which [FTreeItem]s are expanded/collapsed.
///
/// By default, [FTreeItem]s are initially collapsed unless [FTreeItem.initiallyExpanded] is set to true.
///
/// See:
/// * https://forui.dev/docs/data/tree for working examples.
final class FTreeController extends FChangeNotifier with Diagnosticable {
  final Set<int> _expanded;

  /// Creates a [FTreeController].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `expanded` contains duplicate values.
  /// * `min <= expanded` is false for any value in `expanded`.
  FTreeController({Set<int> expanded = const {}})
    : assert(expanded.length == {...expanded}.length, 'expanded should not have duplicates.'),
      _expanded = {...expanded};

  /// The indices of the expanded items.
  Set<int> get expanded => {..._expanded};

  /// Expands the item at the given [index].
  void expand(int index) {
    if (_expanded.add(index)) {
      notifyListeners();
    }
  }

  /// Collapses the item at the given [index].
  void collapse(int index) {
    if (_expanded.remove(index)) {
      notifyListeners();
    }
  }

  /// Toggles the expansion state of the item at the given [index].
  void toggle(int index) {
    if (_expanded.contains(index)) {
      collapse(index);
    } else {
      expand(index);
    }
  }

  /// Returns true if the item at the given [index] is expanded.
  bool isExpanded(int index) => _expanded.contains(index);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('expanded', _expanded));
  }
}
