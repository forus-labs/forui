import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPagination', () {
    testWidgets('select page', (tester) async {
      final controller = FPaginationController(pages: 10, initialPage: 2);
      await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
      expect(controller.page, 2);

      await tester.tap(find.text('5'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.page, 4);
    });

    testWidgets('Actions - previous', (tester) async {
      final controller = FPaginationController(pages: 10);
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
      final controller = FPaginationController(pages: 10, initialPage: 9);
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
      final controller = FPaginationController(pages: 10)..addListener(() {
        notifyCount++;
      });
      await tester.pumpWidget(
        TestScaffold(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: PageView.builder(
                  itemCount: 10,
                  controller: controller.controller,
                  itemBuilder: (context, index) => Text('Page $index', style: const TextStyle(fontSize: 45)),
                ),
              ),
              FPagination(controller: controller),
            ],
          ),
        ),
      );

      // Perform actions that should trigger notifyListeners
      controller.page = 6;
      await tester.pumpAndSettle();
      controller.previous();
      await tester.pumpAndSettle();
      controller.next();
      await tester.pumpAndSettle();

      await tester.fling(find.byType(PageView), const Offset(-300, 0), 10);
      await tester.pump();
      expect(controller.page, 7);

      expect(notifyCount, 4);
    });
  });
}
