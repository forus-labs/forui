import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TileGroupPage extends Sample {
  final FTileDivider divider;

  TileGroupPage({
    @queryParam super.theme,
    @queryParam String divider = 'indented',
  }) : divider = switch (divider) {
          'indented' => FTileDivider.indented,
          'none' => FTileDivider.none,
          _ => FTileDivider.full,
        };

  @override
  Widget sample(BuildContext context) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    divider: divider,
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
  );
}

@RoutePage()
class MergeTileGroup extends Sample {
  MergeTileGroup({
    @queryParam super.theme,
  });

  @override
  Widget sample(BuildContext context) => const _MergeTileGroup();
}

class _MergeTileGroup extends StatefulWidget {
  const _MergeTileGroup();

  @override
  State<_MergeTileGroup> createState() => _MergeTileGroupState();
}

class _MergeTileGroupState extends State<_MergeTileGroup> {
  late FRadioSelectGroupController<String> controller = FRadioSelectGroupController();

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
      FSelectTileGroup(
        controller: controller,
        children: [
          FSelectTile(
            title: const Text('List View'),
            value: 'List',
          ),
          FSelectTile(
            title: const Text('Grid View'),
            value: 'Grid',
          ),
        ],
      ),
    ],
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
