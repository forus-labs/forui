import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/divider.dart';

void main() {
  final style = FResizableDividerStyle(
    color: const Color(0xFF000000),
    width: 2,
    thumbStyle: FResizableDividerThumbStyle(
      decoration: const BoxDecoration(color: Color(0xFF000000)),
      foregroundColor: const Color(0xFF000000),
      height: 4,
      width: 4,
    ),
    focusedOutlineStyle: FFocusedOutlineStyle(
      color: const Color(0xFF000000),
      width: 2,
      borderRadius: BorderRadius.circular(4),
    ),
  );

  final left = FResizableRegionData(index: 0, extent: (min: 10, max: 100, total: 100), offset: (min: 0, max: 50));
  final right = FResizableRegionData(index: 1, extent: (min: 10, max: 100, total: 100), offset: (min: 50, max: 100));

  late FResizableController controller;

  setUp(() => controller = FResizableController()..regions.addAll([left, right]));

  for (final (index, constructor)
      in [
        () => HorizontalDivider(
          controller: controller,
          style: style,
          type: FResizableDivider.divider,
          left: -1,
          right: 0,
          crossAxisExtent: null,
          hitRegionExtent: 100,
          cursor: MouseCursor.defer,
          resizePercentage: 0.1,
          semanticFormatterCallback: (l, r) => '',
        ),
        () => HorizontalDivider(
          controller: controller,
          style: style,
          type: FResizableDivider.divider,
          left: 0,
          right: 0,
          crossAxisExtent: null,
          hitRegionExtent: 100,
          cursor: MouseCursor.defer,
          resizePercentage: 0.1,
          semanticFormatterCallback: (l, r) => '',
        ),
      ].indexed) {
    test('[$index] constructor throws error', () => expect(constructor, throwsAssertionError));
  }
}
