import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A class that holds the theme data for the app.
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
