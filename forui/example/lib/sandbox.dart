import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FSelectGroupController selectGroupController = FRadioSelectGroupController(value: 1);
  FAccordionController controller = FAccordionController(min: 1, max: 3);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FTile(
            icon: FAssets.icons.globe(
              height: 18,
              // width: 18,
            ),
          ),
          FTile(
            icon: FAssets.icons.bluetooth(
              height: 18,
              // width: 18,
            ),
          ),
          const SizedBox(height: 20),
          FButton(onPress: () {}, label: const Text('hi')),
        ],
      );
}
