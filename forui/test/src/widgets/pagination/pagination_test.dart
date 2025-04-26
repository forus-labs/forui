import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPagination', () {
    group('controller', () {
      testWidgets('update controller', (tester) async {
        final first = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: first)));

        expect(first.disposed, false);

        final second = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: second)));

        expect(first.disposed, false);
        expect(second.disposed, false);
      });

      testWidgets('dispose controller', (tester) async {
        final controller = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: controller)));

        expect(controller.disposed, false);

        await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

        expect(controller.disposed, false);
      });
    });

    group('onChange', () {
      testWidgets('when controller changes but onChange callback is the same', (tester) async {
        int count = 0;
        void onChange(int _) => count++;

        final firstController = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: firstController, onChange: onChange)));

        firstController.page = 1;
        await tester.pump();

        expect(count, 1);

        final secondController = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: secondController, onChange: onChange)));

        firstController.page = 2;
        secondController.page = 3;
        await tester.pump();

        expect(count, 2);
      });

      testWidgets('when onChange callback changes but controller is the same', (tester) async {
        int first = 0;
        int second = 0;

        final controller = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: controller, onChange: (_) => first++)));

        controller.page = 1;
        await tester.pump();

        expect(first, 1);

        await tester.pumpWidget(
          TestScaffold.app(child: FPagination(controller: controller, onChange: (_) => second++)),
        );

        controller.page = 2;
        await tester.pump();

        expect(first, 1);
        expect(second, 1);
      });

      testWidgets('when both controller and onChange callback change', (tester) async {
        int first = 0;
        int second = 0;

        final firstController = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(
          TestScaffold.app(child: FPagination(controller: firstController, onChange: (_) => first++)),
        );

        firstController.page = 1;
        await tester.pump();

        expect(first, 1);

        final secondController = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(
          TestScaffold.app(child: FPagination(controller: secondController, onChange: (_) => second++)),
        );

        firstController.page = 2;
        secondController.page = 3;
        await tester.pump();

        expect(first, 1);
        expect(second, 1);
      });

      testWidgets('disposed when controller is external', (tester) async {
        int count = 0;

        final controller = autoDispose(FPaginationController(pages: 10));
        await tester.pumpWidget(TestScaffold.app(child: FPagination(controller: controller, onChange: (_) => count++)));

        controller.page = 1;
        await tester.pump();

        expect(count, 1);

        await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

        controller.page = 2;
        await tester.pump();

        expect(count, 1);
      });
    });

    group('constructor', () {
      test('cannot provide both controller and initialPage', () {
        expect(() => FPagination(controller: FPaginationController(pages: 10), initialPage: 0), throwsAssertionError);
      });

      test('cannot provide both controller and pages', () {
        expect(() => FPagination(controller: FPaginationController(pages: 10), pages: 5), throwsAssertionError);
      });

      test('initialPage must be >= 0', () {
        expect(() => FPagination(initialPage: -1, pages: 10), throwsAssertionError);
      });

      test('initialPage must be < pages', () {
        expect(() => FPagination(initialPage: 10, pages: 10), throwsAssertionError);
      });

      test('pages must be > 0', () {
        expect(() => FPagination(pages: 0), throwsAssertionError);
      });
    });

    group('Actions', () {
      testWidgets('previous', (tester) async {
        final controller = autoDispose(FPaginationController(pages: 10));

        await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
        expect(controller.page, 0);

        await tester.tap(find.byType(Action).first);
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(controller.page, 0);

        await tester.tap(find.byType(Action).last);
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(controller.page, 1);

        await tester.tap(find.text('10'));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await tester.tap(find.byType(Action).last);
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(controller.page, 9);

        await tester.tap(find.byType(Action).first);
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(controller.page, 8);
      });

      testWidgets('next', (tester) async {
        final controller = autoDispose(FPaginationController(pages: 10, initialPage: 9));

        await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
        expect(controller.page, 9);

        await tester.tap(find.byType(Action).last);
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(controller.page, 9);

        await tester.tap(find.byType(Action).first);
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(controller.page, 8);
      });
    });

    testWidgets('select page', (tester) async {
      final controller = autoDispose(FPaginationController(pages: 10, initialPage: 2));

      await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
      expect(controller.page, 2);

      await tester.tap(find.text('5'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.page, 4);
    });

    testWidgets('notifyListener', (tester) async {
      int notifyCount = 0;
      final controller = autoDispose(
        FPaginationController(pages: 10)..addListener(() {
          notifyCount++;
        }),
      );

      await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));

      controller.page = 6;
      await tester.pumpAndSettle();
      controller.previous();
      await tester.pumpAndSettle();
      controller.next();
      await tester.pumpAndSettle();

      expect(notifyCount, 3);
    });
  });
}
