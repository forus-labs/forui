import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class RootHeaderPage extends SampleScaffold {
  RootHeaderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FHeader(
    title: const Text('Edit Alarm'),
    actions: [
      FHeaderAction(
        icon: FAssets.icons.alarmClock,
        onPress: () {},
      ),
      FHeaderAction(
        icon: FAssets.icons.plus,
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class NestedHeaderPage extends SampleScaffold {
  NestedHeaderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FHeader.nested(
    title: const Text('Appointment'),
    leftActions: [
      FHeaderAction.back(onPress: () {}),
    ],
    rightActions: [
      FHeaderAction(
        icon: FAssets.icons.info,
        onPress: () {},
      ),
      FHeaderAction(
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
  Widget child(BuildContext context) => FHeader.nested(
    title: const Text('Climate'),
    leftActions: [
      FHeaderAction(
        icon: FAssets.icons.thermometer,
        onPress: () {},
      ),
      FHeaderAction(
        icon: FAssets.icons.wind,
        onPress: null,
      ),
    ],
    rightActions: [
      FHeaderAction.x(onPress: () {}),
    ],
  );
}
