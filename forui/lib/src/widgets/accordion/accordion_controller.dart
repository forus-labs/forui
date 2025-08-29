import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

/// A controller shows and hides items in an [FAccordion].
///
/// When the maximum number of expanded items is reached, it automatically collapses the least recently expanded item
/// to make room for new expansions.
///
/// Methods like [toggle], [expand], and [collapse] will not work during [State.initState] or before the accordion
/// items are built. Use [FAccordionItem.initiallyExpanded] instead.
class FAccordionController extends FChangeNotifier {
  final Map<int, AnimationController> _controllers;
  final Set<int> _expanded;
  final int _min;
  final int? _max;

  /// Creates a [FAccordionController].
  ///
  /// [min] and [max] define the minimum and maximum number of expanded items allowed.
  ///
  /// # Contract:
  /// [min] and [max] must be: `0 <= min <= max`.
  FAccordionController({int min = 0, int? max})
    : _controllers = {},
      _expanded = {},
      _min = min,
      _max = max,
      assert(debugCheckInclusiveRange<FAccordionController>(min, max));

  /// Toggles the item at the given [index], expanding it if it is collapsed and vice versa.
  ///
  /// This method should not be called while the widget tree is being rebuilt.
  Future<bool> toggle(int index) async => switch (_controllers[index]?.status) {
    null => false,
    final status when status.isForwardOrCompleted => await collapse(index),
    _ => await expand(index),
  };

  /// Expands the item at the given [index], returning true if successfully expanded. It collapses the least recently
  /// expanded item if the maximum number of expanded items is reached.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<bool> expand(int index) async {
    final controller = _controllers[index];
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
      futures.add(_controllers[collapsing]!.reverse());
    }

    _expanded.add(index);
    futures.add(controller.forward());

    await Future.wait(futures);
    notifyListeners();

    return true;
  }

  /// Collapses the item at the given [index], returning true if successfully collapsed.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<bool> collapse(int index) async {
    if (controllers[index] == null || _expanded.length <= _min || !_expanded.contains(index)) {
      return false;
    }

    _expanded.remove(index);
    await _controllers[index]!.reverse();

    notifyListeners();

    return true;
  }

  /// The indexes of the currently expanded items.
  Set<int> get expanded => {..._expanded};
}

@internal
extension InternalAccordionController on FAccordionController {
  /// Adds an item at the given [index], returning true if added.
  bool add(int index, AnimationController controller) {
    if (controller.value == 1 && _max != null && _max <= _expanded.length) {
      return false;
    }

    _controllers[index] = controller;
    if (controller.value == 1) {
      _expanded.add(index);
    }

    return true;
  }

  /// Removes the item at the given [index], returning true if removed.
  bool remove(int index) {
    if (_expanded.length <= _min && _expanded.contains(index)) {
      return false;
    }

    final removed = _controllers.remove(index);
    _expanded.remove(index);
    return removed != null;
  }

  @visibleForTesting
  Map<int, AnimationController> get controllers => _controllers;
}
