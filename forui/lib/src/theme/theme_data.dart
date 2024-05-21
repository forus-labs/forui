import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The color scheme, fonts, overarching style, and widget specific styles used to configure child Forui widgets.
class FThemeData with Diagnosticable {
  /// The style data.
  final FColorScheme colorScheme;

  /// The font data.
  final FFont font;

  /// The overarching style.
  final FStyle style;

  /// The box style.
  final FBoxStyle boxStyle;

  /// The card style.
  final FCardStyle cardStyle;

  /// Creates a [FThemeData].
  FThemeData({
    required this.colorScheme,
    required this.font,
    required this.style,
    required this.boxStyle,
    required this.cardStyle,
  });

  /// Creates a [FThemeData] that inherits the given arguments' properties.
  FThemeData.inherit({
    required this.colorScheme,
    required this.font,
    required this.style,
  }):
    boxStyle = FBoxStyle.inherit(colorScheme: colorScheme, font: font),
    cardStyle = FCardStyle.inherit(colorScheme: colorScheme, font: font, style: style);

  /// Creates a copy of this [FThemeData] with the given properties replaced.
  FThemeData copyWith({
    FColorScheme? colorScheme,
    FFont? font,
    FStyle? style,
    FBoxStyle? boxStyle,
    FCardStyle? cardStyle,
  }) => FThemeData(
    colorScheme: colorScheme ?? this.colorScheme,
    font: font ?? this.font,
    style: style ?? this.style,
    boxStyle: boxStyle ?? this.boxStyle,
    cardStyle: cardStyle ?? this.cardStyle,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FColorScheme>('colorScheme', colorScheme, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FFont>('font', font, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FStyle>('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FBoxStyle>('boxStyle', boxStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FCardStyle>('cardStyle', cardStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FThemeData &&
    runtimeType == other.runtimeType &&
    colorScheme == other.colorScheme &&
    font == other.font &&
    style == other.style &&
    boxStyle == other.boxStyle &&
    cardStyle == other.cardStyle;

  @override
  int get hashCode => colorScheme.hashCode ^ font.hashCode ^ style.hashCode ^ boxStyle.hashCode ^ cardStyle.hashCode;
}

/// The overarching style that is used to configure the properties of widget-specific styles if they are not provided.
final class FStyle with Diagnosticable {

  /// The border radius.
  final BorderRadius borderRadius;

  /// Creates an [FStyle].
  const FStyle({required this.borderRadius});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FStyle && borderRadius == other.borderRadius;

  @override
  int get hashCode => borderRadius.hashCode;
}
