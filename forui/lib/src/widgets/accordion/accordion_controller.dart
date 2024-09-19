import 'package:flutter/widgets.dart';

/// A controller that controls which sections are shown and hidden.
base class FAccordionController extends ChangeNotifier {
  /// The duration of the expansion and collapse animations.
  final Duration animationDuration;
  /// A list of controllers for each of the headers in the accordion.
  final List<({AnimationController controller, Animation animation})> controllers;
  final Set<int> _expanded;
  final int _min;
  final int? _max;

  /// Creates a [FAccordionController].
  ///
  /// The [min] and [max] values are the minimum and maximum number of selections allowed. Defaults to no minimum or maximum.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [min] < 0.
  /// * Throws [AssertionError] if [max] < 0.
  /// * Throws [AssertionError] if [min] > [max].
  FAccordionController({
    int min = 0,
    int? max,
    this.animationDuration = const Duration(milliseconds: 500),
  })  : _min = min,
        _max = max,
        controllers = [],
        _expanded = {},
        assert(min >= 0, 'The min value must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max value must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max value must be greater than or equal to the min value.');

  /// Adds an item to the accordion.
  // ignore: avoid_positional_boolean_parameters
  void addItem(int index, AnimationController controller, Animation animation, bool initiallyExpanded) {
    controllers.add((controller: controller, animation: animation));
    if (initiallyExpanded) {
      _expanded.add(index);
    }
  }

  /// Removes an item from the accordion.
  void removeItem(int index) {
    if (controllers.length <= index) {
      controllers.removeAt(index);
    }
    _expanded.remove(index);
  }

  /// Convenience method for toggling the current expanded status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle(int index) async {
    if (controllers[index].controller.value == 1) {
      if (_expanded.length <= _min) {
        return;
      }

      _expanded.remove(index);
      await collapse(index);
    } else {
      if (_max != null && _expanded.length >= _max) {
        return;
      }

      _expanded.add(index);
      await expand(index);
    }

    notifyListeners();
  }

  /// Shows the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> expand(int index) async {
    final controller = controllers[index].controller;
    await controller.forward();
    notifyListeners();
  }

  /// Hides the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> collapse(int index) async {
    final controller = controllers[index].controller;
    await controller.reverse();
    notifyListeners();
  }
}

/// An [FAccordionController] that allows one section to be expanded at a time.
final class FRadioAccordionController extends FAccordionController {
  /// Creates a [FRadioAccordionController].
  FRadioAccordionController({
    super.animationDuration,
    super.min,
    int super.max = 1,
  });

  @override
  void addItem(int index, AnimationController controller, Animation animation, bool initiallyExpanded) {
    if (_expanded.length > _max!) {
      super.addItem(index, controller, animation, false);
    } else {
      super.addItem(index, controller, animation, initiallyExpanded);
    }
  }

  @override
  Future<void> toggle(int index) async {
    final toggle = <Future>[];
    if (_expanded.length > _min) {
      if (!_expanded.contains(index) && _expanded.length >= _max!) {
        toggle.add(collapse(_expanded.first));
        _expanded.remove(_expanded.first);
      }
    }
    toggle.add(super.toggle(index));
    await Future.wait(toggle);
  }
}
