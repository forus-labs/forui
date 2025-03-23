import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class RootHeaderPage extends Sample {
  RootHeaderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FHeader(
    title: const Text('Edit Alarm'),
    actions: [
      FHeaderAction(icon: const Icon(FIcons.alarmClock), onPress: () {}),
      FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
    ],
  );
}

@RoutePage()
class NestedHeaderPage extends Sample {
  NestedHeaderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FHeader.nested(
    title: const Text('Appointment'),
    prefixActions: [FHeaderAction.back(onPress: () {})],
    suffixActions: [
      FHeaderAction(icon: const Icon(FIcons.info), onPress: () {}),
      FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
    ],
  );
}

@RoutePage()
class XNestedHeaderPage extends Sample {
  XNestedHeaderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FHeader.nested(
    title: const Text('Climate'),
    prefixActions: [
      FHeaderAction(icon: const Icon(FIcons.thermometer), onPress: () {}),
      const FHeaderAction(icon: Icon(FIcons.wind), onPress: null),
    ],
    suffixActions: [FHeaderAction.x(onPress: () {})],
  );
}
