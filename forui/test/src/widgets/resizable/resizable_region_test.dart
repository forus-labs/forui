import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

Widget stub(BuildContext context, FResizableRegionData data, Widget? child) => child!;

void main() {
  group('FResizable', () {
    for (final (index, constructor) in [
      () => FResizableRegion(initialSize: 0, sliderSize: 10, builder: stub),
      () => FResizableRegion(initialSize: 10, sliderSize: 0, builder: stub),
      () => FResizableRegion(initialSize: 10, sliderSize: 10, builder: stub),
      () => FResizableRegion(
            initialSize: 10,
            sliderSize: 10,
            minSize: 0,
            builder: stub,
          ),
      () => FResizableRegion(
            initialSize: 10,
            sliderSize: 2,
            minSize: 20,
            builder: stub,
          ),
    ].indexed) {
      test(
        '[$index] constructor throws error',
        () => expect(constructor, throwsAssertionError),
      );
    }
  });
}
