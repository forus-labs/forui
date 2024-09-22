import 'package:flutter/widgets.dart';

/// A controller that controls which sections are shown and hidden.
abstract base class FAccordionController extends ChangeNotifier {
  /// The duration of the expansion and collapse animations.
  final Duration animationDuration;

  /// A list of controllers for each of the headers in the accordion.
  final Map<int, ({AnimationController controller, Animation animation})> controllers;
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
  factory FAccordionController({int min, int? max, Duration animationDuration}) = _MultiSelectAccordionController;

  FAccordionController._({
    int min = 0,
    int? max,
    this.animationDuration = const Duration(milliseconds: 500),
  })  : _min = min,
        _max = max,
        controllers = {},
        _expanded = {},
        assert(min >= 0, 'The min value must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max value must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max value must be greater than or equal to the min value.');

  /// Adds an item to the accordion.
  // ignore: avoid_positional_boolean_parameters
  void addItem(int index, AnimationController controller, Animation animation, bool initiallyExpanded);

  /// Removes an item from the accordion.
  void removeItem(int index);

  /// Convenience method for toggling the current expanded status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle(int index);

  /// Shows the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> expand(int index);

  /// Hides the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> collapse(int index);
}

final class _MultiSelectAccordionController extends FAccordionController {
  _MultiSelectAccordionController({
    super.min,
    super.max,
    super.animationDuration,
  }) : super._();

  /// Adds an item to the accordion.
  // ignore: avoid_positional_boolean_parameters
  @override
  void addItem(int index, AnimationController controller, Animation animation, bool initiallyExpanded) {
    controllers[index] = (controller: controller, animation: animation);
    if (initiallyExpanded && _expanded.length < _max!) {
      //TODO: check min, max items
      _expanded.add(index);
    }
  }

  /// Removes an item from the accordion.
  @override
  void removeItem(int index) {
    controllers.remove(index);
    _expanded.remove(index);
  }

  /// Convenience method for toggling the current expanded status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  @override
  Future<void> toggle(int index) async => controllers[index]?.animation.value == 100 ? collapse(index) : expand(index);

  /// Shows the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  @override
  Future<void> expand(int index) async {
    if (_max != null && _expanded.length >= _max) {
      return;
    }

    _expanded.add(index);

    final controller = controllers[index]?.controller;
    await controller?.forward();
    notifyListeners();
  }

  /// Hides the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  @override
  Future<void> collapse(int index) async {
    if (_expanded.length <= _min) {
      return;
    }

    _expanded.remove(index);

    final controller = controllers[index]?.controller;
    await controller?.reverse();
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
  }) : super._();

  @override
  void addItem(int index, AnimationController controller, Animation animation, bool initiallyExpanded) {

    controllers[index] = (controller: controller, animation: animation);

    if (initiallyExpanded) {
      //TODO: check min, max items
      _expanded.add(index);
    }
  }

  @override
  void removeItem(int index) {
    controllers.remove(index);
    _expanded.remove(index);
  }

  @override
  Future<void> toggle(int index) async => controllers[index]?.animation.value == 100 ? collapse(index) : expand(index);


  @override
  Future<void> collapse(int index) async {
    if (_expanded.length <= _min) {
      return;
    }

    _expanded.remove(index);

    final controller = controllers[index]?.controller;
    await controller?.reverse();
    notifyListeners();
  }

  @override
  Future<void> expand(int index) async {
    final expand = <Future<void>>[];
    if (_expanded.length > _min && _expanded.length >= _max!) {

      if(_expanded.contains(index)) {
        return;
      }
      expand.add(collapse(_expanded.first));
    }

    _expanded.add(index);

    final controller = controllers[index]?.controller;

    expand.add(controller!.forward() as Future<void>);
    await Future.wait(expand);

    notifyListeners();

  }
}
