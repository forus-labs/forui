import 'package:flutter/material.dart';

import 'package:forui/src/theme/font_data.dart';
import 'package:forui/src/theme/style_data.dart';
import 'package:forui/src/theme/widget_data.dart';

/// A class that holds the theme data for the app.
class FThemeData {
  /// The font data.
  final FFontData fontData;

  /// The style data.
  final FStyleData styleData;

  /// The widget data.
  final FWidgetData widgetData;

  /// Creates a [FThemeData].
  const FThemeData({
    required this.fontData,
    required this.styleData,
    required this.widgetData
  });

  /// Creates a copy of this [ThemeData] with the given properties replaced.
  FThemeData copyWith({
    FFontData? fontData,
    FStyleData? styleData,
    FWidgetData? widgetData
  }) => FThemeData(
    fontData: fontData ?? this.fontData,
    styleData: styleData ?? this.styleData,
    widgetData: widgetData ?? this.widgetData
  );
}
