import 'package:forui/src/box/box_style.dart';

/// A class that holds the widget data.
class FWidgetData {
  /// The box style.
  final FBoxStyle boxStyle;

  /// Creates a [WidgetData].
  FWidgetData({required this.boxStyle});

  /// Creates a copy of this [FWidgetData] with the given properties replaced.
  FWidgetData copyWith({
    FBoxStyle? boxStyle,
  }) => FWidgetData(
      boxStyle: boxStyle ?? this.boxStyle,
    );
}
