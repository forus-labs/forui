import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// The default font and theme data that are inherited by child Forui widgets.
class FThemeData {
  /// The font data.
  final FFontData font;

  /// The style data.
  final FStyleData style;

  /// The widget data.
  final FWidgetData widgets;

  /// Creates a [FThemeData].
  FThemeData({required this.font, required this.style, required this.widgets});

  /// Creates a [FThemeData] that inherits the properties from the given [FFontData] and [FStyleData].
  FThemeData.inherit({
    required this.font,
    required this.style,
  }) : widgets = FWidgetData.inherit(data: font, style: style);

  /// Creates a copy of this [ThemeData] with the given properties replaced.
  FThemeData copyWith({FFontData? fontData, FStyleData? styleData, FWidgetData? widgetData}) => FThemeData(
        font: fontData ?? font,
        style: styleData ?? style,
        widgets: widgetData ?? widgets,
      );
}
