import 'package:forui/forui.dart';

/// The default widget-specific theme and font data that is inherited from a [FTheme] by child Forui widgets.
class FWidgetData {
  /// The box style.
  final FBoxStyle box;

  /// The card style.
  final FCardStyle card;

  /// Creates a [FWidgetData].
  FWidgetData({
    required this.box,
    required this.card,
  });

  /// Creates a [FWidgetData] that inherits the properties from the given [FFontData] and [FStyleData].
  FWidgetData.inherit({required FFontData data, required FStyleData style})
      : box = FBoxStyle.inherit(style: style, font: data),
        card = FCardStyle.inherit(style: style, font: data);

  /// Creates a copy of this [FWidgetData] with the given properties replaced.
  FWidgetData copyWith({
    FBoxStyle? boxStyle,
    FCardStyle? cardStyle,
  }) =>
      FWidgetData(
        box: boxStyle ?? box,
        card: cardStyle ?? card,
      );
}
