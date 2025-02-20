import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TilePage extends Sample {
  final bool enabled;
  final bool tappable;

  TilePage({@queryParam super.theme, @queryParam this.enabled = true, @queryParam this.tappable = true});

  @override
  Widget sample(BuildContext context) => FTile(
    enabled: enabled,
    prefixIcon: FIcon(FAssets.icons.user),
    title: const Text('Personalization'),
    suffixIcon: FIcon(FAssets.icons.chevronRight),
    onPress: tappable ? () {} : null,
  );
}

@RoutePage()
class TileSubtitlePage extends Sample {
  TileSubtitlePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTile(
    prefixIcon: FIcon(FAssets.icons.bell),
    title: const Text('Notifications'),
    subtitle: const Text('Banners, Sounds, Badges'),
    suffixIcon: FIcon(FAssets.icons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class TileDetailsPage extends Sample {
  TileDetailsPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTile(
    prefixIcon: FIcon(FAssets.icons.wifi),
    title: const Text('WiFi'),
    details: const Text('Forus Labs (5G)'),
    suffixIcon: FIcon(FAssets.icons.chevronRight),
    onPress: () {},
  );
}
