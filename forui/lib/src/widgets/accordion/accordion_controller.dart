import 'package:flutter/widgets.dart';

/// A controller that controls which sections are shown and hidden.
class FAccordionController extends ChangeNotifier {
  /// The duration of the expanding and collapsing animations.
  final Duration animationDuration;

  /// The animation controllers for each of the sections in the accordion.
  final Map<int, ({AnimationController controller, Animation animation})> controllers;
  final Set<int> _expanded;
  final int _min;
  final int? _max;

  /// An [FAccordionController] that allows only one section to be expanded at a time.
  factory FAccordionController.radio({Duration? animationDuration}) => FAccordionController(
        max: 1,
        animationDuration: animationDuration ?? const Duration(milliseconds: 200),
      );

  /// Creates a [FAccordionController].
  ///
  /// The [min] and [max] values are the minimum and maximum number of selections allowed. Defaults to no minimum and maximum.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [min] < 0.
  /// * Throws [AssertionError] if [max] < 0.
  /// * Throws [AssertionError] if [min] > [max].
  FAccordionController({
    int min = 0,
    int? max,
    this.animationDuration = const Duration(milliseconds: 100),
  })  : _min = min,
        _max = max,
        controllers = {},
        _expanded = {},
        assert(min >= 0, 'The min value must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max value must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max value must be greater than or equal to the min value.');

  /// Adds an item to the accordion.
  void addItem(int index, AnimationController controller, Animation animation, {required bool initiallyExpanded}) {
    controller
      ..value = initiallyExpanded ? 1 : 0
      ..duration = animationDuration;

    controllers[index] = (controller: controller, animation: animation);

    if (initiallyExpanded) {
      if (_max != null && _expanded.length >= _max) {
        return;
      }
      _expanded.add(index);
    }
  }

  /// Removes the item at the given [index] from the accordion. Returns true if the item was removed.
  bool removeItem(int index) {
    final removed = controllers.remove(index);
    _expanded.remove(index);
    return removed != null;
  }

  /// Convenience method for toggling the current expansion status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle(int index) async {
    final value = controllers[index]?.animation.value;

    if (value == null) {
      return;
    }

    value == 100 ? await collapse(index) : await expand(index);
  }

  /// Expands the item at the given [index].
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> expand(int index) async {
    if (_expanded.contains(index)) {
      return;
    }

    final futures = <Future<void>>[];
    if (_max != null && _expanded.length >= _max) {
      futures.add(_collapse(_expanded.first));
    }

    _expanded.add(index);

    final future = controllers[index]?.controller.forward();
    if (future != null) {
      futures.add(future);
    }
    await Future.wait(futures);

    notifyListeners();
  }

  /// Collapses the item at the given [index].
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> collapse(int index) async {
    if (await _collapse(index)) {
      notifyListeners();
    }
  }

  Future<bool> _collapse(int index) async {
    if (_expanded.length <= _min || !_expanded.contains(index)) {
      return false;
    }

    _expanded.remove(index);

    await controllers[index]?.controller.reverse();
    return true;
  }

  /// Returns true if the number of expanded items is within the allowed range.
  bool validate(int length) => length >= _min && (_max == null || length <= _max);

  /// The currently selected values.
  Set<int> get expanded => {..._expanded};
}
