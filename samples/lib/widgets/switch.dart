// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

// Project imports:
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
        builder: (context, _, __) => FSwitch(
          value: notifier.value,
          onChanged: (value) => notifier.value = value,
        ),
      ),
    );
  }
}
