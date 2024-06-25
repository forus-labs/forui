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
  Widget child(BuildContext context) => const Switch();
}

class Switch extends StatefulWidget {
  const Switch({super.key});

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  late final ValueNotifier<bool> notifier;

  @override
  void initState() {
    super.initState();
    notifier = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, _, __) => FSwitch(
        value: true,
        autofocus: true,
        onChanged: (value) {},
      ),
    ),
  );
}

