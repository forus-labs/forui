
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';

import '../../test_scaffold.dart';

void main() {
  group('FPagination', () {
    testWidgets('select page', (tester) async {
      final controller = FPaginationController(length: 10, page: 2);
      await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
      expect(controller.value, 2);

      await tester.tap(find.text('5'));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(controller.value, 4);
    });

    testWidgets('Actions ', (tester) async {
      final controller = FPaginationController(length: 10);
      await tester.pumpWidget(TestScaffold(child: FPagination(controller: controller)));
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
  });
}
