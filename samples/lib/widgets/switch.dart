import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SwitchPage extends SampleScaffold {
  SwitchPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) {
    final notifier = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, __) => FSwitch(
          value: value,
          onChanged: (value) => notifier.value = value,
        ),
      ),
    );
  }
}
