import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPagination', () {
    testWidgets('select page', (tester) async {
      final controller = autoDispose(FPaginationController(pages: 10, initialPage: 2));

      await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
      expect(controller.page, 2);

      await tester.tap(find.text('5'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.page, 4);
    });

    testWidgets('Actions - previous', (tester) async {
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

    testWidgets('Actions - next', (tester) async {
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

    testWidgets('notifyListener', (tester) async {
      int notifyCount = 0;
      final controller = autoDispose(FPaginationController(pages: 10)..addListener(() {
        notifyCount++;
      }));

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
