import 'package:forui/src/box/box_style.dart';
import 'package:forui/src/theme/font/font_data.dart';
import 'package:forui/src/theme/style_data.dart';

/// A class that holds the widget data.
class FWidgetData {
  /// The box style.
  final FBoxStyle box;

  /// Creates a [FWidgetData].
  FWidgetData({required this.box});

  /// Creates a [FWidgetData] that inherits the properties from the given [FFontData] and [FStyleData].
  FWidgetData.inherit({required FFontData data, required FStyleData style}):
      box = FBoxStyle.inherit(data: data, style: style);

  /// Creates a copy of this [FWidgetData] with the given properties replaced.
  FWidgetData copyWith({
    FBoxStyle? boxStyle,
  }) => FWidgetData(
      box: boxStyle ?? box,
    );
}
