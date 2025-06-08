import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('non-toggleable', () {
    test('set value to existing', () {
      var count = 0;
      final controller = FSelectController(vsync: const TestVSync(), value: 1)..addListener(() => count++);
      expect(controller.value, 1);

      controller.value = 1;
      expect(controller.value, 1);
      expect(count, 0);
    });

    test('set value to new', () {
      var count = 0;
      final controller = FSelectController(vsync: const TestVSync(), value: 1)..addListener(() => count++);
      expect(controller.value, 1);

      controller.value = 2;
      expect(controller.value, 2);
      expect(count, 1);
    });
  });

  group('toggleable', () {
    test('set value to existing', () {
      var count = 0;
      final controller = FSelectController(vsync: const TestVSync(), value: 1, toggleable: true)
        ..addListener(() => count++);

      expect(controller.value, 1);

      controller.value = 1;
      expect(controller.value, null);
      expect(count, 1);
    });

    test('set value to new', () {
      var count = 0;
      final controller = FSelectController(vsync: const TestVSync(), value: 1, toggleable: true)
        ..addListener(() => count++);

      expect(controller.value, 1);

      controller.value = 2;
      expect(controller.value, 2);
      expect(count, 1);
    });
  });

  test('dispose', () {
    final controller = FSelectController(vsync: const TestVSync(), value: 1)..dispose();

    expect(controller.popover.disposed, true);
  });
}
