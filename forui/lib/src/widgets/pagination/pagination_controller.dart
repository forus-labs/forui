import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A controller that controls which page is selected.
class FPaginationController extends FChangeNotifier {
  /// The animation controllers for each of the sections in the accordion.
  final Map<int, AnimationController> controllers;
  final Set<int> _expanded;
  final int selected;
  final int count;

  /// Creates a [FAccordionController].
  ///
  /// The [min] and [max] values define the minimum and maximum number of expanded sections allowed.
  ///
  /// Defaults to no minimum and maximum.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [min] < 0.
  /// * Throws [AssertionError] if [max] < [min].
  FPaginationController({
    this.selected = 0,
  })  : controllers = {},
        _expanded = {},
        assert(selected >= 0, 'The min value must be greater than or equal to 0.'),

  /// Adds an item at the given [index], returning true if added.
  @internal
  bool addItem(int index, AnimationController controller) {
    if (controller.value == 1 && _max != null && _max <= _expanded.length) {
      return false;
    }

    controllers[index] = controller;
    if (controller.value == 1) {
      _expanded.add(index);
    }

    return true;
  }

  /// Removes the item at the given [index], returning true if removed.
  @internal
  bool removeItem(int index) {
    if (_expanded.length <= _min && _expanded.contains(index)) {
      return false;
    }

    final removed = controllers.remove(index);
    _expanded.remove(index);
    return removed != null;
  }

  /// Convenience method for toggling the current expansion status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<bool> toggle(int index) async => switch (controllers[index]?.value) {
    null => false,
    1 => await collapse(index),
    _ => await expand(index),
  };

  /// Expands the item at the given [index], returning true if expanded.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<bool> expand(int index) async {
    final controller = controllers[index];
    if (_expanded.contains(index) || controller == null) {
      return false;
    }

    final futures = <Future<void>>[];
    if (_max != null && _max <= _expanded.length) {
      final collapsing = _expanded.firstOrNull;
      if (collapsing == null) {
        return false;
      }

      _expanded.remove(collapsing);
      futures.add(controllers[collapsing]!.reverse());
    }

    _expanded.add(index);
    futures.add(controller.forward());

    await Future.wait(futures);
    notifyListeners();

    return true;
  }

  /// Collapses the item at the given [index], returning true if collapsed.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<bool> select(int index) async {
    if (_expanded.length <= selected || !_expanded.contains(index)) {
      return false;
    }

    _expanded.remove(index);
    await controllers[index]!.reverse();

    notifyListeners();

    return true;
  }

  /// Returns true if the number of expanded items is within the allowed range.
  bool validate(int length) => _min <= length && (_max == null || length <= _max);

  /// The indexes of the currently expanded items.
  Set<int> get expanded => {..._expanded};
}
