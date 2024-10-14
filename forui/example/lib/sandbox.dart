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
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: FDivider(style: context.theme.tileGroupStyle.tileStyle.dividerStyle),
              ),
              FTile(
                prefixIcon: FIcon(FAssets.icons.bluetooth, size: 30,),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: FDivider(style: context.theme.tileGroupStyle.tileStyle.dividerStyle),
              ),
              FTile(
                prefixIcon: const FIcon.data(Icons.add_circle_outline),
                title: const Text('WiFi'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                onPress: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: FDivider(style: context.theme.tileGroupStyle.tileStyle.dividerStyle),
              ),
              FTile(
                prefixIcon: FIcon(FAssets.icons.ghost),
                title: const Text('WiFi'),
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
            title: const Text('Title'),
            subtitle: const Text('L                                         ong'),
            details: const Text('Forus Labs (5G)'),
            suffixIcon: FIcon(FAssets.icons.chevronRight),
            onPress: () {},
          ),
          FButton(onPress: () {}, label: const Text('Forus Labs (5G)')),
        ],
      );
}
