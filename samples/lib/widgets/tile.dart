import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TilePage extends SampleScaffold {
  final bool enabled;
  final bool tappable;

  TilePage({
    @queryParam super.theme,
    @queryParam this.enabled = true,
    @queryParam this.tappable = true,
  });

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child:  FTile(
          enabled: enabled,
          prefixIcon: FIcon(FAssets.icons.user),
          title: const Text('Personalization'),
          suffixIcon: FIcon(FAssets.icons.chevronRight),
          onPress: tappable ? () {} : null,
        ),
      ),
    ],
  );
}

@RoutePage()
class TileSubtitlePage extends SampleScaffold {
  TileSubtitlePage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child:  FTile(
          prefixIcon: FIcon(FAssets.icons.bell),
          title: const Text('Notifications'),
          subtitle: const Text('Banners, Sounds, Badges'),
          suffixIcon: FIcon(FAssets.icons.chevronRight),
          onPress: () {},
        ),
      ),
    ],
  );
}

@RoutePage()
class TileDetailsPage extends SampleScaffold {
  TileDetailsPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child:  FTile(
          prefixIcon: FIcon(FAssets.icons.wifi),
          title: const Text('WiFi'),
          details: const Text('Forus Labs (5G)'),
          suffixIcon: FIcon(FAssets.icons.chevronRight),
          onPress: () {},
        ),
      ),
    ],
  );
}