import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:forui/src/theme/theme.dart';

/// A class that holds the font data.
class FFontData { // replace with TextStyle?
  // TODO: Figure out how to handle this.
  // Store font somehow?
  
  final double scale;
  // line height
  // spacing etc.

  /// The font style for the body.
  // final FontStyle body;

  /// Creates a [FFontData].
  const FFontData({required this.scale});

  /// Creates a copy of this [FFontData] with the given properties replaced.
  // FFontData copyWith({
  //   FontStyle? body,
  // }) => FFontData(
  //   body: body ?? this.body,
  // );
}

// class TextStyleBuilder {
//   final double fontSize;
//   final FontWeight weight;
//   // line height
//
//   // constructor
//
//   TextStyle build(BuildContext context) {
//     final data = FTheme.of(context).fontData;
//
//     return TextStyle(fontSize: fontSize * data.scale, fontWeight: );
//   }
// }

extension type TextStyleBuilder(TextStyle style) implements TextStyle {
  // implicit Text style

  TextStyleBuilder.inherit(FFontData data, TextStyle style): style = TextStyle(fontSize: (style.fontSize ?? 14) * data.scale);

}