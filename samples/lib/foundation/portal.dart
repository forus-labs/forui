import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class PortalPage extends SampleScaffold {
  PortalPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _Portal();
}

class _Portal extends StatefulWidget {
  const _Portal();

  @override
  State<_Portal> createState() => _State();
}

class _State extends State<_Portal> with SingleTickerProviderStateMixin {
  late OverlayPortalController controller;

  @override
  void initState() {
    super.initState();
    controller = OverlayPortalController();
  }

  @override
  Widget build(BuildContext context) => FPortal(
        controller: controller,
        followerBuilder: (context) => const ColoredBox(
          color: Colors.red,
          child: SizedBox.square(
            dimension: 100,
          ),
        ),
        child: FButton(
          label: const Text('Target'),
          onPress: () => controller.toggle(),
        ),
      );
}
