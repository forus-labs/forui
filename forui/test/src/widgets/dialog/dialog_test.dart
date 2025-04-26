import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FDialog', () {
    for (final direction in Axis.values) {
      testWidgets('$direction infinite sized child', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FDialog(
              direction: direction,
              title: const Text('Are you absolutely sure?'),
              body: SingleChildScrollView(
                child: Text.rich(
                  WidgetSpan(
                    child: Stack(children: [Container(height: 200, width: double.infinity, color: Colors.red)]),
                  ),
                ),
              ),
              actions: [
                FButton(child: const Text('Continue'), onPress: () {}),
                FButton(style: FButtonStyle.outline, child: const Text('Cancel'), onPress: () {}),
              ],
            ),
          ),
        );

        expect(tester.takeException(), null);
      });
    }
  });
}
