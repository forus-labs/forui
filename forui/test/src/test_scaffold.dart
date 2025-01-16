import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'threshold_file_comparator.dart';

final relativePath =
    Directory.current.path.contains('forui${Platform.pathSeparator}forui') ? '.' : '${Directory.current.path}/forui';

MatchesGoldenFile get isBlueScreen => MatchesGoldenFile.forStringPath(blueScreen, null);

Future<void> expectBlueScreen(dynamic actual) => expectLater(actual, isBlueScreen);

class TestScaffold extends StatelessWidget {
  static final blueScreen = () {
    const colorScheme = FColorScheme(
      brightness: Brightness.light,
      barrier: Color(0xFF03A9F4),
      background: Color(0xFF03A9F4),
      foreground: Color(0xFF03A9F4),
      primary: Color(0xFF03A9F4),
      primaryForeground: Color(0xFF03A9F4),
      secondary: Color(0xFF03A9F4),
      secondaryForeground: Color(0xFF03A9F4),
      muted: Color(0xFF03A9F4),
      mutedForeground: Color(0xFF03A9F4),
      destructive: Color(0xFF03A9F4),
      destructiveForeground: Color(0xFF03A9F4),
      error: Color(0xFF03A9F4),
      errorForeground: Color(0xFF03A9F4),
      border: Color(0xFF03A9F4),
    );
    final typography = FTypography.inherit(colorScheme: colorScheme);
    final style = FStyle.inherit(colorScheme: colorScheme, typography: typography).copyWith(shadow: []);

    return FThemeData.inherit(
      colorScheme: colorScheme,
      typography: typography,
      style: style,
    );
  }();

  static List<({String name, FThemeData data})> get themes => [
        (name: 'zinc-light', data: FThemes.zinc.light),
        (name: 'zinc-dark', data: FThemes.zinc.dark),
      ];

  final FThemeData theme;
  final Color? background;
  final Locale? locale;
  final TextDirection? textDirection;
  final Widget child;
  final Alignment alignment;
  final bool padded;
  final bool wrapped;

  TestScaffold({
    required this.child,
    this.textDirection,
    this.alignment = Alignment.center,
    this.padded = true,
    FThemeData? theme,
    Color? background,
    super.key,
  })  : theme = theme ?? FThemes.zinc.light,
        locale = null,
        background = switch ((theme, background)) {
          (final theme, null) when theme == FThemes.zinc.light => const Color(0xFFEEFFFF),
          (final theme, null) when theme == FThemes.zinc.dark => const Color(0xFF06111C),
          (_, final background) => background,
        },
        wrapped = false;

  TestScaffold.app({
    required this.child,
    this.locale,
    this.textDirection,
    this.alignment = Alignment.center,
    this.padded = true,
    FThemeData? theme,
    Color? background,
    super.key,
  })  : theme = theme ?? FThemes.zinc.light,
        background = switch ((theme, background)) {
          (final theme, null) when theme == FThemes.zinc.light => const Color(0xFFEEFFFF),
          (final theme, null) when theme == FThemes.zinc.dark => const Color(0xFF06111C),
          (_, final background) => background,
        },
        wrapped = true;

  TestScaffold.blue({required this.child, this.alignment = Alignment.center, super.key})
      : theme = FThemes.zinc.light,
        background = blueScreen.colorScheme.background,
        locale = null,
        textDirection = null,
        padded = false,
        wrapped = false;

  @override
  Widget build(BuildContext context) {
    if (wrapped) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: FLocalizations.localizationsDelegates,
        supportedLocales: FLocalizations.supportedLocales,
        builder: (context, child) => FTheme(
          data: theme,
          textDirection: textDirection,
          child: Container(
            color: background ?? theme.colorScheme.background,
            alignment: Alignment.center,
            padding: padded ? const EdgeInsets.all(16) : null,
            child: child!,
          ),
        ),
        home: Align(
          alignment: alignment,
          child: child,
        ),
      );
    } else {
      return FTheme(
        data: theme,
        textDirection: textDirection,
        child: Container(
          color: background ?? theme.colorScheme.background,
          alignment: Alignment.center,
          padding: padded ? const EdgeInsets.all(16) : null,
          child: Align(
            alignment: alignment,
            child: child,
          ),
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('data', theme))
      ..add(ColorProperty('background', background))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(FlagProperty('padded', value: padded, ifTrue: 'padded'))
      ..add(FlagProperty('wrapped', value: wrapped, ifTrue: 'wrapped'));
  }
}
