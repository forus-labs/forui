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
  Widget build(BuildContext context) => FTileGroups(
        label: const Text('Settings'),
        children: [
          FTileGroup(
            label: const Text('Help'),
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
              FTile(
                prefixIcon: FIcon(FAssets.icons.bell),
                title: const Text('Notifications'),
                // subtitle: const Text('Badges, Sound'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ],
          ),
          FTileGroup(
            children: [
              FTile(
                prefixIcon: FIcon(FAssets.icons.check),
                title: const Text('List View'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
              FTile(
                prefixIcon: const SizedBox.square(
                  dimension: 17,
                ),
                title: const Text('Grid View'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
            ],
          ),
        ],
      );
}
