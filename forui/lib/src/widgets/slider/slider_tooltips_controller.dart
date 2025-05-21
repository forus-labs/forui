import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The controller for a slider's registered tooltips.
final class FSliderTooltipsController {
  /// The key for the min thumb.
  static final min = UniqueKey();

  /// The key for the max thumb.
  static final max = UniqueKey();

  /// True if the registered tooltip(s) should be shown when the user interacts with the slider. Defaults to true.
  final bool enabled;

  final Map<UniqueKey, FTooltipController> _tooltips;

  /// Creates a [FSliderTooltipsController].
  FSliderTooltipsController({required this.enabled}) : _tooltips = {};

  /// Registers the tooltip to the slider.
  void add(UniqueKey key, FTooltipController controller) {
    if (enabled) {
      _tooltips[key] = controller;
    }
  }

  /// Toggles the visibility of the tooltip with the given key, or all tooltips if none is specified.
  Future<void> toggle([UniqueKey? key]) async {
    if (key != null) {
      await _tooltips[key]?.toggle();
      return;
    }

    await Future.wait([for (final tooltip in _tooltips.values) tooltip.toggle()]);
  }

  /// Shows the tooltip with the given key, or all tooltips if none is specified.
  Future<void> show([UniqueKey? key]) async {
    if (key != null) {
      await _tooltips[key]?.show();
      return;
    }

    await Future.wait([for (final tooltip in _tooltips.values) tooltip.show()]);
  }

  /// Hides the tooltip with the given key, or all tooltips if none is specified.
  Future<void> hide([UniqueKey? key]) async {
    if (key != null) {
      await _tooltips[key]?.hide();
      return;
    }

    await Future.wait([for (final tooltip in _tooltips.values) tooltip.hide()]);
  }

  /// Removes the tooltip from the slider.
  void remove(UniqueKey? key, [FTooltipController? controller]) {
    if (!enabled) {
      return;
    }

    if (controller == null) {
      _tooltips.remove(key);
    } else {
      _tooltips.removeWhere((key, controller) => key == key && controller == controller);
    }
  }
}
