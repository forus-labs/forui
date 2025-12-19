import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('vertical and expands', (tester) async {
    expect(
      () => TestScaffold(
        child: const FLabel(axis: .vertical, expands: true, child: Text('Child')),
      ),
      returnsNormally,
    );
  });

  testWidgets('horizontal and expands', (tester) async {
    expect(
      () => TestScaffold(
        child: FLabel(axis: .horizontal, expands: true, child: const Text('Child')),
      ),
      throwsAssertionError,
    );
  });

  testWidgets('renders child only when label, description, and error are null', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FLabel(axis: .horizontal, child: Text('Child')),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
  });

  testWidgets('renders error even when label and description are null', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FLabel(axis: .horizontal, states: {.error}, error: Text('Error'), child: Text('Child')),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('renders horizontal label with label, description, and error', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FLabel(
          axis: .horizontal,
          label: Text('Label'),
          description: Text('Description'),
          error: Text('Error'),
          states: {.error},
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
          axis: .vertical,
          label: Text('Label'),
          description: Text('Description'),
          error: Text('Error'),
          states: {.error},
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
      TestScaffold(
        child: const FLabel(axis: .horizontal, error: Text('Error'), child: Text('Child')),
      ),
    );

    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Error'), findsNothing);
  });
}
