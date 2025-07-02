import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        FTileGroup.merge(
          children: [
            FTileGroup(
              style: FThemes.green.dark.tileGroupStyle,
              children: [
                FTile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                FTile(
                  prefix: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
