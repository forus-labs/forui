import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

import 'threshold_file_comparator.dart';

MatchesGoldenFile get isBlueScreen => MatchesGoldenFile.forStringPath(blueScreen, null);

class TestScaffold extends StatelessWidget {
  static final blueScreen = FThemeData.inherit(
    colorScheme: const FColorScheme(
      brightness: Brightness.light,
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
    ),
  );

  static List<(String, FThemeData, Color)> get themes => [
        ('zinc-light', FThemes.zinc.light, const Color(0xFFD5FFFF)),
        ('zinc-dark', FThemes.zinc.dark, const Color(0xFF104963)),
      ];

  final FThemeData data;
  final Color? background;
  final Widget child;
  final bool wrapped;

  const TestScaffold({required this.data, required this.child, this.background, super.key}) : wrapped = false;

  const TestScaffold.app({required this.data, required this.child, this.background, super.key}) : wrapped = true;

  TestScaffold.blue({required this.child, super.key})
      : data = FThemes.zinc.light,
        background = blueScreen.colorScheme.background,
        wrapped = false;

  @override
  Widget build(BuildContext context) {
    if (wrapped) {
      return MaterialApp(
        builder: (context, child) => FTheme(
          data: data,
          textDirection: TextDirection.ltr,
          child: Container(
            // We use a fixed background color to ensure that widgets set their background properly.
            color: background ?? data.colorScheme.background,
            alignment: Alignment.center,
            child: child!,
          ),
        ),
        home: Align(child: child),
      );
    } else {
      return FTheme(
        data: data,
        textDirection: TextDirection.ltr,
        child: Container(
          // We use a fixed background color to ensure that widgets set their background properly.
          color: background ?? data.colorScheme.background,
          alignment: Alignment.center,
          child: child,
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('data', data))
      ..add(ColorProperty('background', background))
      ..add(FlagProperty('wrapped', value: wrapped, ifTrue: 'wrapped'));
  }
}
