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
            icon: FIcon(FAssets.icons.alarmClock),
            onPress: () {},
          ),
          FHeaderAction(
            icon: FIcon(FAssets.icons.plus),
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
        prefixActions: [
          FHeaderAction.back(onPress: () {}),
        ],
        suffixActions: [
          FHeaderAction(
            icon: FIcon(FAssets.icons.info),
            onPress: () {},
          ),
          FHeaderAction(
            icon: FIcon(FAssets.icons.plus),
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
        prefixActions: [
          FHeaderAction(
            icon: FIcon(FAssets.icons.thermometer),
            onPress: () {},
          ),
          FHeaderAction(
            icon: FIcon(FAssets.icons.wind),
            onPress: null,
          ),
        ],
        suffixActions: [
          FHeaderAction.x(onPress: () {}),
        ],
      );
}
