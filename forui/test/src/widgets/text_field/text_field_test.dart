import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('lifted', (tester) async {
      var value = const TextEditingValue(text: 'initial');
      TextEditingValue? received;

      Widget buildWidget() => TestScaffold.app(
        child: FTextField(
          control: .lifted(value: value, onChange: (v) => received = v),
        ),
      );

      await tester.pumpWidget(buildWidget());

      expect(find.text('initial'), findsOneWidget);

      await tester.enterText(find.byType(EditableText), 'typed');
      await tester.pumpAndSettle();
      expect(received?.text, 'typed');

      value = const TextEditingValue(text: 'external');
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('external'), findsOneWidget);
    });
  });

  group('managed', () {
    testWidgets('onChange called', (tester) async {
      TextEditingValue? lastValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTextField(control: .managed(onChange: (value) => lastValue = value)),
        ),
      );

      await tester.enterText(find.byType(EditableText), 'hello');
      await tester.pumpAndSettle();

      expect(lastValue?.text, 'hello');
    });
  });

  group('embedding', () {
    testWidgets('embedded in CupertinoApp', (tester) async {
      await tester.pumpWidget(CupertinoApp(home: TestScaffold(child: const FTextField())));

      expect(tester.takeException(), null);
    });

    testWidgets('embedded in MaterialApp', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestScaffold(child: const FTextField())));

      expect(tester.takeException(), null);
    });

    testWidgets('not embedded in any App', (tester) async {
      await tester.pumpWidget(TestScaffold(child: const FTextField()));

      expect(tester.takeException(), null);
    });

    testWidgets('non-English Locale', (tester) async {
      await tester.pumpWidget(
        Localizations(
          locale: const Locale('fr', 'FR'),
          delegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          child: TestScaffold(theme: FThemes.zinc.light, child: const FTextField()),
        ),
      );

      expect(tester.takeException(), null);
    });
  });

  group('clearable', () {
    testWidgets('no icon when clearable return false', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(clearable: (_) => false),
        ),
      );

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('no icon when disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(enabled: false, clearable: (_) => true),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('suffix & no icon when disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(enabled: false, clearable: (_) => true, suffixBuilder: (_, _, _) => const SizedBox()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('clears text-field', (tester) async {
      final controller = autoDispose(TextEditingController(text: 'Testing'));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(
            control: .managed(controller: controller),
            clearable: (value) => value.text.isNotEmpty,
          ),
        ),
      );

      expect(find.text('Testing'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Clear'));
      await tester.pumpAndSettle();

      expect(find.text('Testing'), findsNothing);
    });

    testWidgets('suffix & clears text-field', (tester) async {
      final controller = autoDispose(TextEditingController(text: 'Testing'));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(
            control: .managed(controller: controller),
            clearable: (value) => value.text.isNotEmpty,
            suffixBuilder: (_, _, _) => const SizedBox(),
          ),
        ),
      );

      expect(find.text('Testing'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Clear'));
      await tester.pumpAndSettle();

      expect(find.text('Testing'), findsNothing);
    });
  });

  testWidgets('email - localized', (tester) async {
    await tester.pumpWidget(TestScaffold.app(locale: const Locale('zh'), child: const FTextField.email()));

    expect(find.text('电子邮件'), findsOneWidget);
  });

  testWidgets('password - localized', (tester) async {
    await tester.pumpWidget(TestScaffold.app(locale: const Locale('zh'), child: FTextField.password()));

    expect(find.text('密码'), findsOneWidget);
  });

  testWidgets('expands', (tester) async {
    await tester.pumpWidget(TestScaffold.app(child: const FTextField(maxLines: null, expands: true)));

    expect(tester.takeException(), null);
  });

  testWidgets('height does not change due to visual density on different platforms', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    await tester.pumpWidget(TestScaffold.app(theme: FThemes.zinc.light, child: const FTextField()));
    final macos = tester.getSize(find.byType(FTextField)).height;

    await tester.pumpWidget(const SizedBox());

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    await tester.pumpWidget(TestScaffold.app(theme: FThemes.zinc.light, child: const FTextField()));
    final ios = tester.getSize(find.byType(FTextField)).height;

    expect(macos, ios);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('error does not cause overlay to fail', (tester) async {
    final controller = autoDispose(FPopoverController(vsync: tester));

    await tester.pumpWidget(
      TestScaffold.app(
        child: FTextField(
          builder: (_, _, _, child) => FPopover(
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => Container(height: 100, width: 100, color: Colors.blue),
            child: child,
          ),
        ),
      ),
    );

    unawaited(controller.show());
    await tester.pumpAndSettle();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FTextField(
          error: Container(height: 100, width: 100, color: Colors.red),
          builder: (_, _, _, child) => FPopover(
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => Container(height: 100, width: 100, color: Colors.blue),
            child: child,
          ),
        ),
      ),
    );

    expect(tester.takeException(), null);
  });
}
