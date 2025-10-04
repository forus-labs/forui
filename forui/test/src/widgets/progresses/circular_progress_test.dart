import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('ticker provider', (tester) async {
    await tester.pumpWidget(TestScaffold(theme: FThemes.zinc.light, child: const FCircularProgress()));
    await tester.pump();

    await tester.pumpWidget(TestScaffold(theme: FThemes.zinc.dark, child: const FCircularProgress()));
    await tester.pump();

    expect(tester.takeException(), null);
  });
}
