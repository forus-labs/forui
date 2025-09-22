import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('everything', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FToast(
          icon: Icon(FIcons.triangleAlert),
          title: Text('Event has been created'),
          description: Text(
            'This is a more detailed description that provides comprehensive context and additional information '
            'about the notification, explaining what happened and what the user might expect next.',
          ),
          suffix: Text('Suffix'),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/everything.png'));
  });

  testWidgets('title & description', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FToast(
          title: Text('Event has been created'),
          description: Text(
            'This is a more detailed description that provides comprehensive context and additional information '
            'about the notification, explaining what happened and what the user might expect next.',
          ),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/title-description.png'));
  });

  testWidgets('glassmorphic', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: Stack(
          children: [
            const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
            FToast(
              style: FThemes.zinc.light.toasterStyle.toastStyle.copyWith(
                backgroundFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                decoration: BoxDecoration(
                  color: FThemes.zinc.light.colors.background.withValues(alpha: 0.5),
                  borderRadius: FThemes.zinc.light.style.borderRadius,
                  border: Border.all(
                    width: FThemes.zinc.light.style.borderWidth,
                    color: FThemes.zinc.light.colors.border,
                  ),
                ),
              ),
              title: const Text('Event has been created'),
              description: const Text(
                'This is a more detailed description that provides comprehensive context and additional information '
                'about the notification, explaining what happened and what the user might expect next.',
              ),
            ),
          ],
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/glassmorphic.png'));
  });
}
