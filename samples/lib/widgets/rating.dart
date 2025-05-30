import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class RatingBasicPage extends Sample {
  RatingBasicPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const FRating(value: 3);
}

@RoutePage()
class RatingInteractivePage extends StatefulSample {
  RatingInteractivePage({@queryParam super.theme});

  @override
  RatingInteractivePageState createState() => RatingInteractivePageState();
}

class RatingInteractivePageState extends StatefulSampleState<RatingInteractivePage> {
  double interactiveRatingValue = 2.5;

  @override
  Widget sample(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FRating(
        value: interactiveRatingValue,
        filledIcon: Icon(FIcons.star, color: context.theme.colors.primary),
        emptyIcon: Icon(FIcons.starOff, color: context.theme.colors.primary),
        halfFilledIcon: Icon(FIcons.starHalf, color: context.theme.colors.primary),
        onStateChanged: (value) {
          setState(() {
            interactiveRatingValue = value;
          });
        },
      ),
      const SizedBox(height: 8),
      Text('Current rating: ${interactiveRatingValue.toStringAsFixed(1)}'),
    ],
  );
}
