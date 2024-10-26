import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FSelectGroupController<int> selectGroupController = FRadioSelectGroupController(value: 1);
  FAccordionController controller = FAccordionController(min: 1, max: 3);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FTileGroup.merge(
    label: const Text('Settings'),
    children: [
      FTileGroup(
        children: [
          FTile(
            prefixIcon: FIcon(FAssets.icons.user),
            title: const Text('Personalization'),
            suffixIcon: FIcon(FAssets.icons.chevronRight),
            onPress: () {},
          ),
          FTile(
            prefixIcon: FIcon(FAssets.icons.wifi),
            title: const Text('WiFi'),
            details: const Text('Forus Labs (5G)'),
            suffixIcon: FIcon(FAssets.icons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
      FSelectTileGroup<int>(
        controller: selectGroupController,
        children: [
          FSelectTile.suffix(
            prefixIcon: FIcon(FAssets.icons.list),
            title: const Text('List View'),
            value: 1,
          ),
          FSelectTile.suffix(
            prefixIcon: FIcon(FAssets.icons.grid2x2),
            title: const Text('Grid View'),
            value: 2,
          ),
        ],
      ),
    ],
  );
}
