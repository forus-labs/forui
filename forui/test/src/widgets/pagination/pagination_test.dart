import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('lifted', (tester) async {
      var page = 0;

      Future<void> rebuild() => tester.pumpWidget(
        TestScaffold(
          child: FPagination(
            control: .lifted(page: page, pages: 10, onChange: (value) => page = value),
          ),
        ),
      );

      await rebuild();
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(page, 4);

      await rebuild();
      await tester.tap(find.text('10'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(page, 9);

      await rebuild();
      await tester.tap(find.text('7'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(page, 6);
    });
  });

  group('managed', () {
    testWidgets('onChange called', (tester) async {
      var value = -1;

      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(pages: 10, onChange: (v) => value = v)),
        ),
      );

      await tester.tap(find.text('3'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, 2);

      await tester.tap(find.text('10'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, 9);
    });
  });

  group('Actions', () {
    testWidgets('previous', (tester) async {
      final controller = autoDispose(FPaginationController(pages: 10));

      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(controller: controller)),
        ),
      );
      expect(controller.value, 0);

      await tester.tap(find.byType(Action).first);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 0);

      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 1);

      await tester.tap(find.text('10'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 9);

      await tester.tap(find.byType(Action).first);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 8);
    });

    testWidgets('next', (tester) async {
      final controller = autoDispose(FPaginationController(pages: 10, page: 9));

      await tester.pumpWidget(
        TestScaffold(
          child: FPagination(control: .managed(controller: controller)),
        ),
      );
      expect(controller.value, 9);

      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 9);

      await tester.tap(find.byType(Action).first);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 8);
    });
  });

  testWidgets('select page', (tester) async {
    final controller = autoDispose(FPaginationController(pages: 10, page: 2));

    await tester.pumpWidget(
      TestScaffold(
        child: FPagination(control: .managed(controller: controller)),
      ),
    );
    expect(controller.value, 2);

    await tester.tap(find.text('5'));
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
    expect(controller.value, 4);
  });

  testWidgets('notifyListener', (tester) async {
    int notifyCount = 0;
    final controller = autoDispose(
      FPaginationController(pages: 10)..addListener(() {
        notifyCount++;
      }),
    );

    await tester.pumpWidget(
      TestScaffold(
        child: FPagination(control: .managed(controller: controller)),
      ),
    );

    controller.value = 6;
    await tester.pumpAndSettle();
    controller.previous();
    await tester.pumpAndSettle();
    controller.next();
    await tester.pumpAndSettle();

    expect(notifyCount, 3);
  });
}
