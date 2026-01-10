import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('FTheme', (tester) async {
    final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(200, 200)));

    await tester.pumpWidget(sheet.record(Application(data: FThemes.zinc.light, key: const ValueKey('key'))));
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
    builder: (context, child) => FTheme(data: data, child: child!),
    debugShowCheckedModeBanner: false,
    home: RepaintBoundary(
      child: Builder(
        builder: (context) => FScaffold(
          child: Padding(
            padding: const .all(16.0),
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
