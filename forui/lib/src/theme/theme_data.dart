import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

/// The color scheme, fonts, overarching style, and widget specific styles used to configure child Forui widgets.
class FThemeData with Diagnosticable {

  /// The color scheme.
  final FColorScheme colorScheme;

  /// The font data.
  final FFont font;

  /// The overarching style.
  final FStyle style;

  /// The chip styles.
  final FBadgeStyles badgeStyles;

  /// The card style.
  final FCardStyle cardStyle;

  /// The header styles.
  final FHeaderStyle headerStyle;

  /// The box style.
  final FBoxStyle boxStyle;

  /// The button styles.
  final FButtonStyles buttonStyles;

  /// The card style.
  final FCardStyle cardStyle;

  /// The separator styles.
  final FSeparatorStyles separatorStyles;

  /// The switch style.
  final FSwitchStyle switchStyle;

  /// Creates a [FThemeData].
  FThemeData({
    required this.colorScheme,
    required this.font,
    required this.style,
    required this.badgeStyles,
    required this.cardStyle,
    required this.headerStyle,
    required this.boxStyle,
    required this.buttonStyles,
    required this.cardStyle,
    required this.separatorStyles,
    required this.switchStyle,
  });

  /// Creates a [FThemeData] that inherits the given properties.
  FThemeData.inherit({
    required this.colorScheme,
    required this.font,
    required this.style,
  }):
    badgeStyles = FBadgeStyles.inherit(colorScheme: colorScheme, font: font, style: style),
    boxStyle = FBoxStyle.inherit(colorScheme: colorScheme),
    buttonStyles = FButtonStyles.inherit(colorScheme: colorScheme, font: font, style: style),
    cardStyle = FCardStyle.inherit(colorScheme: colorScheme, font: font, style: style),
    separatorStyles = FSeparatorStyles.inherit(colorScheme: colorScheme, style: style),
    switchStyle = FSwitchStyle.inherit(colorScheme: colorScheme);

  /// Creates a copy of this [FThemeData] with the given properties replaced.
  FThemeData copyWith({
    FColorScheme? colorScheme,
    FFont? font,
    FStyle? style,
    FBadgeStyles? badgeStyles,

    FCardStyle? cardStyle,

    FHeaderStyle? headerStyles,
    FBoxStyle? boxStyle,
    FButtonStyles? buttonStyles,
    FCardStyle? cardStyle,
    FSeparatorStyles? separatorStyles,
    FSwitchStyle? switchStyle,
  }) => FThemeData(
    colorScheme: colorScheme ?? this.colorScheme,
    font: font ?? this.font,
    style: style ?? this.style,
    badgeStyles: badgeStyles ?? this.badgeStyles,
    boxStyle: boxStyle ?? this.boxStyle,
    buttonStyles: buttonStyles ?? this.buttonStyles,
    cardStyle: cardStyle ?? this.cardStyle,
    separatorStyles: separatorStyles ?? this.separatorStyles,
    switchStyle: switchStyle ?? this.switchStyle,
  );

        cardStyle: cardStyle ?? this.cardStyle,

        headerStyle: headerStyles ?? this.headerStyle,
        boxStyle: boxStyle ?? this.boxStyle,
        separatorStyles: separatorStyles ?? this.separatorStyles,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FColorScheme>('colorScheme', colorScheme, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FFont>('font', font, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FStyle>('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FBadgeStyles>('badgeStyles', badgeStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FBoxStyle>('boxStyle', boxStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FButtonStyles>('buttonStyles', buttonStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FCardStyle>('cardStyle', cardStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FSeparatorStyles>('separatorStyles', separatorStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<FSwitchStyle>('switchStyle', switchStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FThemeData &&
          runtimeType == other.runtimeType &&
          colorScheme == other.colorScheme &&
          font == other.font &&
          style == other.style &&
          badgeStyles == other.badgeStyles &&
          cardStyle == other.cardStyle &&
          headerStyle == other.headerStyle &&
          boxStyle == other.boxStyle &&
          buttonStyles == other.buttonStyles &&
          cardStyle == other.cardStyle &&
          separatorStyles == other.separatorStyles &&
          switchStyle == other.switchStyle;

  @override
  int get hashCode =>
      colorScheme.hashCode ^
      font.hashCode ^
      style.hashCode ^
      badgeStyles.hashCode ^
      cardStyle.hashCode ^
      headerStyle.hashCode ^
      boxStyle.hashCode ^
      buttonStyles.hashCode ^
      cardStyle.hashCode ^
      separatorStyles.hashCode ^
      switchStyle.hashCode;

}
