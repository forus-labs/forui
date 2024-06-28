import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class NestedHeaderPage extends SampleScaffold {
  NestedHeaderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FNestedHeader(
        title: 'Appointment',
        leftActions: [
          FNestedHeaderAction.back(onPress: () {}),
        ],
        rightActions: [
          FNestedHeaderAction(
            icon: FAssets.icons.info,
            onPress: () {},
          ),
          FNestedHeaderAction(
            icon: FAssets.icons.plus,
            onPress: () {},
          ),
        ],
      );
}

@RoutePage()
class XNestedHeaderPage extends SampleScaffold {
  XNestedHeaderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FNestedHeader(
        title: 'Climate',
        leftActions: [
          FNestedHeaderAction(
            icon: FAssets.icons.thermometer,
            onPress: () {},
          ),
          FNestedHeaderAction(
            icon: FAssets.icons.wind,
            onPress: null,
          ),
        ],
        rightActions: [
          FNestedHeaderAction.x(onPress: () {}),
        ],
      );
}

void t() {
FNestedHeader(
  title: 'Climate',
  leftActions: [
    FNestedHeaderAction(
      icon: FAssets.icons.thermometer,
      onPress: () {},
    ),
    FNestedHeaderAction(
      icon: FAssets.icons.wind,
      onPress: null,
    ),
  ],
  rightActions: [
    FNestedHeaderAction.x(onPress: () {}),
  ],
);
}
