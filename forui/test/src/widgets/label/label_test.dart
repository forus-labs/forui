import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FLabel', () {
    testWidgets('renders child only when label, description, and error are null', (tester) async {
      await tester.pumpWidget(TestScaffold(child: const FLabel(axis: Axis.horizontal, child: Text('Child'))));

      expect(find.text('Child'), findsOneWidget);
    });

    testWidgets('renders error even when label and description are null', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FLabel(
            axis: Axis.horizontal,
            states: {WidgetState.error},
            error: Text('Error'),
            child: Text('Child'),
          ),
        ),
      );

      expect(find.text('Child'), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('renders horizontal label with label, description, and error', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FLabel(
            axis: Axis.horizontal,
            label: Text('Label'),
            description: Text('Description'),
            error: Text('Error'),
            states: {WidgetState.error},
            child: Text('Child'),
          ),
        ),
      );

      expect(find.text('Child'), findsOneWidget);
      expect(find.text('Label'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('renders vertical label with label, description, and error', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FLabel(
            axis: Axis.vertical,
            label: Text('Label'),
            description: Text('Description'),
            error: Text('Error'),
            states: {WidgetState.error},
            child: Text('Child'),
          ),
        ),
      );

      expect(find.text('Child'), findsOneWidget);
      expect(find.text('Label'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('does not render error when state is not error', (tester) async {
      await tester.pumpWidget(
        TestScaffold(child: const FLabel(axis: Axis.horizontal, error: Text('Error'), child: Text('Child'))),
      );

      expect(find.text('Child'), findsOneWidget);
      expect(find.text('Error'), findsNothing);
    });
  });
}
