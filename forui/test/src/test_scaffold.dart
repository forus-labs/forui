import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class TestScaffold extends StatelessWidget {
  static final blueScreen = FThemeData.inherit(
    colorScheme: const FColorScheme(
      brightness: Brightness.light,
      disabledColorLightness: 0.1,
      background: Colors.lightBlue,
      foreground: Colors.lightBlue,
      primary: Colors.lightBlue,
      primaryForeground: Colors.lightBlue,
      secondary: Colors.lightBlue,
      secondaryForeground: Colors.lightBlue,
      muted: Colors.lightBlue,
      mutedForeground: Colors.lightBlue,
      destructive: Colors.lightBlue,
      destructiveForeground: Colors.lightBlue,
      error: Colors.lightBlue,
      errorForeground: Colors.lightBlue,
      border: Colors.lightBlue,
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
      : data = blueScreen,
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
