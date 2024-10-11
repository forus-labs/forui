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
          FTileGroup(
            label: const Text('Network'),
            children: [
              FTile(
                prefixIcon: FIcon(FAssets.icons.wifi),
                title: const Text('WiFi'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
              FTile(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FTile(
            prefixIcon: FIcon(FAssets.icons.bluetooth),
            title: const Text('Bluetooth'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('Forus Labs (5G)'),
            suffixIcon: FIcon(FAssets.icons.chevronRight),
            onPress: () {},
          ),
        ],
      );
}
