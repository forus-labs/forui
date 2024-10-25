import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TileGroupPage extends SampleScaffold {
  final FTileDivider divider;

  TileGroupPage({
    @queryParam super.theme,
    @queryParam String divider = 'indented',
  }) : divider = switch (divider) {
          'indented' => FTileDivider.indented,
          'none' => FTileDivider.none,
          _ => FTileDivider.indented,
        };

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: FTileGroup(
              label: const Text('Settings'),
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
            ),
          ),
        ],
      );
}

@RoutePage()
class MergeTileGroup extends SampleScaffold {
  final FTileDivider divider;

  MergeTileGroup({
    @queryParam super.theme,
    @queryParam String divider = 'full',
  }) : divider = switch (divider) {
    'indented' => FTileDivider.indented,
    'none' => FTileDivider.none,
    _ => FTileDivider.full,
  };

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: FTileGroup.merge(
          label: const Text('Settings'),
          divider: divider,
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
        ),
      ),
    ],
  );
}
