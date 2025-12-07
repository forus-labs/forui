import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'accordion_controller.control.dart';

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

  /// Removes the controller at the given [index] if it matches the given [controller], returning true if removed.
  bool remove(int index, AnimationController controller) {
    if (_controllers[index] != controller) {
      return false;
    }

    if (_expanded.length <= _min && _expanded.contains(index)) {
      return false;
    }

    final removed = _controllers.remove(index);
    _expanded.remove(index);
    return removed != null;
  }

  @protected
  Map<int, AnimationController> get controllers => _controllers;
}

@internal
class LiftedController extends FAccordionController {
  bool Function(int index) _supply;
  void Function(int index, bool expanded) _onChange;
  Set<int> _items;

  LiftedController(this._supply, this._onChange, int length)
    : _items = {
        for (var i = 0; i < length; i++)
          if (_supply(i)) i,
      };

  void update(bool Function(int index) supply, void Function(int index, bool expanded) onChange, int length) {
    _supply = supply;
    _onChange = onChange;
    _items = {
      for (var i = 0; i < length; i++)
        if (_supply(i)) i,
    };
  }

  @override
  Future<bool> expand(int index) async {
    _onChange(index, true);
    return true;
  }

  @override
  Future<bool> collapse(int index) async {
    _onChange(index, false);
    return true;
  }

  Set<int> get items => _items;
}

/// Defines how the accordion's expanded state is controlled.
sealed class FAccordionControl with Diagnosticable {
  /// Creates a [FAccordionControl] for controlling an accordion using lifted state.
  ///
  /// The [expanded] function should return true if the item at the given index is expanded. It must be idempotent.
  /// The [onChange] callback is invoked when the user toggles an item.
  const factory FAccordionControl.lifted({
    required bool Function(int index) expanded,
    required void Function(int index, bool expanded) onChange,
  }) = Lifted;

  /// Creates a [FAccordionControl] for controlling an accordion using a controller.
  ///
  /// Either [controller], or [min]/[max] constraints should be provided. If neither is provided, an internal controller
  /// with no min and max is created.
  ///
  /// The [onChange] callback is invoked when the expanded state changes, receiving the set of currently expanded indices.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [min]/[max] are provided.
  const factory FAccordionControl.managed({
    FAccordionController? controller,
    int? min,
    int? max,
    void Function(Set<int> expanded)? onChange,
  }) = Managed;

  const FAccordionControl._();

  FAccordionController _create(VoidCallback callback, int children);

  (FAccordionController, bool) _update(
    FAccordionControl old,
    FAccordionController controller,
    VoidCallback callback,
    int children,
  );

  void _dispose(FAccordionController controller, VoidCallback callback);
}

@internal
final class Lifted extends FAccordionControl with _$LiftedFunctions {
  @override
  final bool Function(int index) expanded;
  @override
  final void Function(int index, bool expanded) onChange;

  const Lifted({required this.expanded, required this.onChange}) : super._();

  @override
  FAccordionController _create(VoidCallback _, int children) => LiftedController(expanded, onChange, children);

  @override
  void _updateController(FAccordionController controller, int children) =>
      (controller as LiftedController).update(expanded, onChange, children);
}

@internal
final class Managed extends FAccordionControl with _$ManagedFunctions {
  @override
  final FAccordionController? controller;
  @override
  final int? min;
  @override
  final int? max;
  @override
  final void Function(Set<int> expanded)? onChange;

  const Managed({this.controller, this.min, this.max, this.onChange})
    : assert(
        controller == null || (min == null && max == null),
        'Cannot provide both controller and min/max constraints',
      ),
      assert(min == null || min >= 0, 'min must be non-negative'),
      assert(max == null || min == null || max >= min, 'max must be greater than or equal to min'),
      super._();

  @override
  FAccordionController _create(VoidCallback callback, int children) =>
      (controller ?? .new(min: min ?? 0, max: max))..addListener(callback);
}
