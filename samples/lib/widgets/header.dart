import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class HeaderPage extends SampleScaffold {
  HeaderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: FHeader(
      title: 'Edit Alarm',
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
    ),
  );
}
