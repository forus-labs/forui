// ignore_for_file: diagnostic_describe_all_properties

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

final relativePath = Directory.current.path.contains('forui${Platform.pathSeparator}forui')
    ? '.'
    : '${Directory.current.path}/forui';

Future<void> expectBlueScreen([Object? actual]) =>
    expectLater(actual ?? find.byType(TestScaffold), matchesGoldenFile('blue-screen.png'));

List<FlutterErrorDetails> onFlutterError() {
  final original = FlutterError.onError;

  final errors = <FlutterErrorDetails>[];
  FlutterError.onError = errors.add;

  addTearDown(() => FlutterError.onError = original);

  return errors;
}

T autoDispose<T>(T disposable) {
  // We cast this to dynamic as there isn't a standard Disposable interface.
  addTearDown((disposable as dynamic).dispose);
  return disposable;
}

extension WidgetTesters on WidgetTester {
  Future<TestGesture> createPointerGesture({PointerDeviceKind kind = .mouse}) async {
    final gesture = await createGesture(kind: kind);
    await gesture.addPointer(location: .zero);
    addTearDown(gesture.removePointer);

    return gesture;
  }
}

class TestScaffold extends StatelessWidget {
  static final blueScreen = () {
    const colors = FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
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
    final typography = FTypography.inherit(colors: colors);
    final style = FStyle.inherit(colors: colors, typography: typography).copyWith(shadow: []);

    return FThemeData(colors: colors, typography: typography, style: style);
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
    this.alignment = .center,
    this.padded = true,
    FThemeData? theme,
    super.key,
  }) : locale = null,
       theme = theme ?? FThemes.zinc.light,
       background = switch (theme) {
         _ when theme == FThemes.zinc.light => const Color(0xFFEEFFFF),
         _ when theme == FThemes.zinc.dark => const Color(0xFF06111C),
         _ => null,
       },
       wrapped = false;

  TestScaffold.app({
    required this.child,
    this.locale,
    this.textDirection,
    this.alignment = .center,
    this.padded = true,
    FThemeData? theme,
    super.key,
  }) : theme = theme ?? FThemes.zinc.light,
       background = switch (theme) {
         _ when theme == FThemes.zinc.light => const Color(0xFFEEFFFF),
         _ when theme == FThemes.zinc.dark => const Color(0xFF06111C),
         _ => null,
       },
       wrapped = true;

  TestScaffold.blue({required this.child, this.alignment = .center, super.key})
    : theme = FThemes.zinc.light,
      background = blueScreen.colors.background,
      locale = null,
      textDirection = null,
      padded = false,
      wrapped = true;

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
            color: background ?? theme.colors.background,
            padding: padded ? const .all(16) : null,
            child: child!,
          ),
        ),
        home: Align(alignment: alignment, child: child),
      );
    } else {
      return FTheme(
        data: theme,
        textDirection: textDirection,
        child: Container(
          color: background ?? theme.colors.background,
          padding: padded ? const .all(16) : null,
          child: Align(alignment: alignment, child: child),
        ),
      );
    }
  }
}
