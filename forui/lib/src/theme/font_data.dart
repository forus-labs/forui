import 'package:flutter/painting.dart';

/// A class that holds the font data.
class FFontData {
  // TODO: Figure out how to handle this.

  /// The font style for the body.
  final FontStyle body;

  /// Creates a [FFontData].
  const FFontData({required this.body});

  /// Creates a copy of this [FFontData] with the given properties replaced.
  FFontData copyWith({
    FontStyle? body,
  }) => FFontData(
    body: body ?? this.body,
  );
}