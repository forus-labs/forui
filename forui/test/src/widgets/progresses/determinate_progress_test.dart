import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('ticker provider', (tester) async {
    await tester.pumpWidget(TestScaffold(theme: FThemes.zinc.light, child: const FDeterminateProgress(value: 0.5)));
    await tester.pump();

    await tester.pumpWidget(TestScaffold(theme: FThemes.zinc.dark, child: const FDeterminateProgress(value: 0.6)));
    await tester.pump();

    expect(tester.takeException(), null);
  });
}
