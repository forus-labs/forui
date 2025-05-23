import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('everything', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSonnerToast(
          icon: const Icon(FIcons.triangleAlert),
          title: const Text('Event has been created'),
          description: const Text(
            'This is a more detailed description that provides comprehensive context and additional information '
            'about the notification, explaining what happened and what the user might expect next.',
          ),
          suffix: const Text('Suffix'),
          onDismiss: () {},
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/toast/everything.png'));
  });

  testWidgets('title & description', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FSonnerToast(
          title: Text('Event has been created'),
          description: Text(
            'This is a more detailed description that provides comprehensive context and additional information '
            'about the notification, explaining what happened and what the user might expect next.',
          ),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/toast/title-description.png'));
  });
}
