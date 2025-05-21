import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TileGroupPage extends Sample {
  final FTileDivider divider;

  TileGroupPage({@queryParam super.theme, @queryParam String divider = 'indented'})
    : divider = switch (divider) {
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
        prefixIcon: const Icon(FIcons.user),
        title: const Text('Personalization'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      FTile(
        prefixIcon: const Icon(FIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Forus Labs (5G)'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class ScrollableTileGroupPage extends Sample {
  ScrollableTileGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    maxHeight: 200,
    children: [
      FTile(
        prefixIcon: const Icon(FIcons.user),
        title: const Text('Personalization'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      FTile(
        prefixIcon: const Icon(FIcons.mail),
        title: const Text('Mail'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      FTile(
        prefixIcon: const Icon(FIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Forus Labs (5G)'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      FTile(
        prefixIcon: const Icon(FIcons.alarmClock),
        title: const Text('Alarm Clock'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      FTile(
        prefixIcon: const Icon(FIcons.qrCode),
        title: const Text('QR code'),
        suffixIcon: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class LazyTileGroupPage extends Sample {
  LazyTileGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTileGroup.builder(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    maxHeight: 200,
    count: 200,
    tileBuilder: (context, index) =>
        FTile(title: Text('Tile $index'), suffixIcon: const Icon(FIcons.chevronRight), onPress: () {}),
  );
}

@RoutePage()
class MergeTileGroup extends Sample {
  MergeTileGroup({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const _MergeTileGroup();
}

class _MergeTileGroup extends StatefulWidget {
  const _MergeTileGroup();

  @override
  State<_MergeTileGroup> createState() => _MergeTileGroupState();
}

class _MergeTileGroupState extends State<_MergeTileGroup> {
  late final controller = FMultiValueNotifier.radio(value: 'List');

  @override
  Widget build(BuildContext context) => FTileGroup.merge(
    label: const Text('Settings'),
    children: [
      FTileGroup(
        children: [
          FTile(
            prefixIcon: const Icon(FIcons.user),
            title: const Text('Personalization'),
            suffixIcon: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
          FTile(
            prefixIcon: const Icon(FIcons.wifi),
            title: const Text('WiFi'),
            details: const Text('Forus Labs (5G)'),
            suffixIcon: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
      FSelectTileGroup(
        selectController: controller,
        children: const [
          FSelectTile(title: Text('List View'), value: 'List'),
          FSelectTile(title: Text('Grid View'), value: 'Grid'),
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
