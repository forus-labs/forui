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
    prefixIcon: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffixIcon: const Icon(FIcons.chevronRight),
    onPress: tappable ? () {} : null,
  );
}

@RoutePage()
class TileSubtitlePage extends Sample {
  TileSubtitlePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTile(
    prefixIcon: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    subtitle: const Text('Banners, Sounds, Badges'),
    suffixIcon: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class TileDetailsPage extends Sample {
  TileDetailsPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTile(
    prefixIcon: const Icon(FIcons.wifi),
    title: const Text('WiFi'),
    details: const Text('Forus Labs (5G)'),
    suffixIcon: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}
