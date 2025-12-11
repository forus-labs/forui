import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TileGroupPage extends Sample {
  final FItemDivider divider;

  TileGroupPage({@queryParam super.theme, @queryParam String divider = 'indented'})
    : divider = switch (divider) {
        'indented' => .indented,
        'none' => .none,
        _ => .full,
      };

  @override
  Widget sample(BuildContext _) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    divider: divider,
    children: [
      .tile(
        prefix: const Icon(FIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Forus Labs (5G)'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class ScrollableTileGroupPage extends Sample {
  ScrollableTileGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTileGroup(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    maxHeight: 200,
    children: [
      .tile(
        prefix: const Icon(FIcons.user),
        title: const Text('Personalization'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FIcons.mail),
        title: const Text('Mail'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FIcons.wifi),
        title: const Text('WiFi'),
        details: const Text('Forus Labs (5G)'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FIcons.alarmClock),
        title: const Text('Alarm Clock'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
      .tile(
        prefix: const Icon(FIcons.qrCode),
        title: const Text('QR code'),
        suffix: const Icon(FIcons.chevronRight),
        onPress: () {},
      ),
    ],
  );
}

@RoutePage()
class LazyTileGroupPage extends Sample {
  LazyTileGroupPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTileGroup.builder(
    label: const Text('Settings'),
    description: const Text('Personalize your experience'),
    maxHeight: 200,
    count: 200,
    tileBuilder: (context, index) =>
        FTile(title: Text('Tile $index'), suffix: const Icon(FIcons.chevronRight), onPress: () {}),
  );
}

@RoutePage()
class MergeTileGroup extends StatefulSample {
  MergeTileGroup({@queryParam super.theme});

  @override
  State<MergeTileGroup> createState() => _MergeTileGroupPageState();
}

// TODO: Replace with FSelectGroupControl.radio(...).
class _MergeTileGroupPageState extends StatefulSampleState<MergeTileGroup> {
  final _controller = FMultiValueNotifier.radio('List');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FTileGroup.merge(
    label: const Text('Settings'),
    children: [
      .group(
        children: [
          .tile(
            prefix: const Icon(FIcons.user),
            title: const Text('Personalization'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
          .tile(
            prefix: const Icon(FIcons.wifi),
            title: const Text('WiFi'),
            details: const Text('Forus Labs (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ],
      ),
      .selectGroup(
        control: .managed(controller: _controller),
        children: const [
          FSelectTile(title: Text('List View'), value: 'List'),
          FSelectTile(title: Text('Grid View'), value: 'Grid'),
        ],
      ),
    ],
  );
}
