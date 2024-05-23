import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The color scheme, fonts, overarching style, and widget specific styles used to configure child Forui widgets.
class FThemeData with Diagnosticable {
  /// The color scheme.
  final FColorScheme colorScheme;

  /// The font data.
  final FFont font;

  /// The overarching style.
  final FStyle style;

  /// The box style.
  final FBoxStyle boxStyle;

  /// The card style.
  final FCardStyle cardStyle;

  /// The separator style.
  final FSeparatorStyle separatorStyle;

  /// The vertical separator style.
  final FSeparatorStyle verticalSeparatorStyle;

  /// Creates a [FThemeData].
  FThemeData({
    required this.colorScheme,
    required this.font,
    required this.style,
    required this.boxStyle,
    required this.cardStyle,
    required this.separatorStyle,
    required this.verticalSeparatorStyle,
  });

  /// Creates a [FThemeData] that inherits the given arguments' properties.
  FThemeData.inherit({
    required this.colorScheme,
    required this.font,
    required this.style,
  }):
    boxStyle = FBoxStyle.inherit(colorScheme: colorScheme),
    cardStyle = FCardStyle.inherit(colorScheme: colorScheme, style: style),
    separatorStyle = FSeparatorStyle.inherit(
      colorScheme: colorScheme,
      padding: const EdgeInsets.only(top: 20, bottom: 20),
    ),
    verticalSeparatorStyle = FSeparatorStyle.inherit(
      colorScheme: colorScheme,
      padding: const EdgeInsets.only(left: 20, right: 20),
    );

  /// Creates a copy of this [FThemeData] with the given properties replaced.
  FThemeData copyWith({
    FColorScheme? colorScheme,
    FFont? font,
    FStyle? style,
    FBoxStyle? boxStyle,
    FCardStyle? cardStyle,
    FSeparatorStyle? separatorStyle,
    FSeparatorStyle? verticalSeparatorStyle,
  }) => FThemeData(
    colorScheme: colorScheme ?? this.colorScheme,
    font: font ?? this.font,
    style: style ?? this.style,
    boxStyle: boxStyle ?? this.boxStyle,
    cardStyle: cardStyle ?? this.cardStyle,
    separatorStyle: separatorStyle ?? this.separatorStyle,
    verticalSeparatorStyle: verticalSeparatorStyle ?? this.separatorStyle,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FColorScheme>('colorScheme', colorScheme, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FFont>('font', font, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FStyle>('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FBoxStyle>('boxStyle', boxStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FCardStyle>('cardStyle', cardStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FSeparatorStyle>('separatorStyle', separatorStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FSeparatorStyle>('verticalSeparatorStyle', verticalSeparatorStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FThemeData &&
    runtimeType == other.runtimeType &&
    colorScheme == other.colorScheme &&
    font == other.font &&
    style == other.style &&
    boxStyle == other.boxStyle &&
    cardStyle == other.cardStyle &&
    separatorStyle == other.separatorStyle &&
    verticalSeparatorStyle == other.verticalSeparatorStyle;

  @override
  int get hashCode =>
    colorScheme.hashCode ^
    font.hashCode ^
    style.hashCode ^
    boxStyle.hashCode ^
    cardStyle.hashCode ^
    separatorStyle.hashCode ^
    verticalSeparatorStyle.hashCode;

}
