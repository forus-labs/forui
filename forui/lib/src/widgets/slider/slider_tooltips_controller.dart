import 'package:forui/forui.dart';

/// The controller for a slider's registered tooltips.
final class FSliderTooltipsController {
  /// True if the registered tooltip(s) should be shown when the user interacts with the slider. Defaults to true.
  final bool enabled;

  final Set<FTooltipController> _tooltips;

  /// Creates a [FSliderTooltipsController].
  FSliderTooltipsController({required this.enabled}) : _tooltips = {};

  /// Registers the tooltip to the slider.
  void add(FTooltipController controller) {
    if (enabled) {
      _tooltips.add(controller);
    }
  }

  /// Toggles the visibility of the registered tooltips.
  void toggle() {
    for (final tooltip in _tooltips) {
      tooltip.toggle();
    }
  }

  /// Shows the registered tooltips.
  void show() {
    for (final tooltip in _tooltips) {
      tooltip.show();
    }
  }

  /// Hides the registered tooltips.
  void hide() {
    for (final tooltip in _tooltips) {
      tooltip.hide();
    }
  }

  /// Removes the tooltip from the slider.
  void remove(FTooltipController controller) {
    if (enabled) {
      _tooltips.remove(controller);
    }
  }
}
