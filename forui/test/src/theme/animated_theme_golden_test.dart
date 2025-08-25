import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

import 'package:forui/forui.dart';

void main() {
  testWidgets('FAnimatedTheme', (tester) async {
    final sheet = AnimationSheetBuilder(frameSize: const Size(200, 200));
    addTearDown(sheet.dispose);

    await tester.pumpWidget(
      sheet.record(Application(data: FThemes.zinc.light, key: const ValueKey('key'))),
    );
    await tester.pumpFrames(
      sheet.record(Application(data: FThemes.zinc.dark, key: const ValueKey('key'))),
      const Duration(milliseconds: 250),
    );

    await expectLater(sheet.collate(5), matchesGoldenFile('animated-theme/transition.png'));
  });
}

class Application extends StatelessWidget {
  final FThemeData data;

  const Application({required this.data, super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en', 'US'),
    builder: (context, child) => FAnimatedTheme(data: data, child: child!),
    debugShowCheckedModeBanner: false,
    home: RepaintBoundary(
      child: Builder(
        builder: (context) => FScaffold(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FCard(
              child: Column(spacing: 16, children: [FBadge(child: const Text('Badge'))]),
            ),
          ),
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}
