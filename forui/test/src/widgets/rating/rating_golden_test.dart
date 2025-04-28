import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  group('FRating', () {
    testWidgets('renders different values', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text('Empty Rating'),
              SizedBox(height: 8),
              FRating(
              ),
              SizedBox(height: 20),
              Text('Partial Rating'),
              SizedBox(height: 8),
              FRating(
                value: 3,
              ),
              SizedBox(height: 20),
              Text('Full Rating'),
              SizedBox(height: 8),
              FRating(
                value: 5,
              ),
              SizedBox(height: 20),
              Text('Half Rating'),
              SizedBox(height: 8),
              FRating(
                value: 2.5,
                allowHalfRating: true,
                halfFilledIcon: Icon(Icons.star_half),
              ),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('goldens/rating_values.png'),
      );
    });

    testWidgets('renders with custom styling', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text('Default Icons'),
              SizedBox(height: 8),
              FRating(
                value: 3,
              ),
              SizedBox(height: 20),
              Text('Custom Color'),
              SizedBox(height: 8),
              FRating(
                value: 3,
                style: FRatingStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              Text('Custom Size'),
              SizedBox(height: 8),
              FRating(
                value: 3,
                style: FRatingStyle(
                  size: 36.0,
                ),
              ),
              SizedBox(height: 20),
              Text('Custom Icons'),
              SizedBox(height: 8),
              FRating(
                value: 3,
                filledIcon: Icon(Icons.favorite, color: Colors.red),
                emptyIcon: Icon(Icons.favorite_border, color: Colors.red),
              ),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('goldens/rating_styles.png'),
      );
    });

    testWidgets('renders with different counts', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text('3 Icons'),
              SizedBox(height: 8),
              FRating(
                count: 3,
                value: 2,
              ),
              SizedBox(height: 20),
              Text('5 Icons (Default)'),
              SizedBox(height: 8),
              FRating(
                value: 3,
              ),
              SizedBox(height: 20),
              Text('10 Icons'),
              SizedBox(height: 8),
              FRating(
                count: 10,
                value: 7,
              ),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('goldens/rating_counts.png'),
      );
    });

    testWidgets('renders in dark theme', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.dark,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text('Default Rating'),
              SizedBox(height: 8),
              FRating(
                value: 3,
              ),
              SizedBox(height: 20),
              Text('Custom Rating'),
              SizedBox(height: 8),
              FRating(
                value: 3,
                filledIcon: Icon(Icons.favorite),
                emptyIcon: Icon(Icons.favorite_border),
                style: FRatingStyle(
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('goldens/rating_dark.png'),
      );
    });
  });
}
