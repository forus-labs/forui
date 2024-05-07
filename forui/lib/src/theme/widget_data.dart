import 'package:forui/src/box/box_style.dart';

class FWidgetData {
  /// The box style.
  final FBoxStyle fBoxStyle;

  /// Creates a [WidgetData].
  FWidgetData({required this.fBoxStyle});

  /// Creates a copy of this [FWidgetData] with the given properties replaced.
  FWidgetData copyWith({
    FBoxStyle? fBoxStyle,
  }) => FWidgetData(
      fBoxStyle: fBoxStyle ?? this.fBoxStyle,
    );
}
