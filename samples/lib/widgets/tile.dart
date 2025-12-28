import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TilePage extends Sample {
  TilePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTile(
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
    // {@highlight}
    onPress: () {},
    // {@endhighlight}
  );
}

@RoutePage()
class DisabledTilePage extends Sample {
  DisabledTilePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTile(
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
    // {@highlight}
    enabled: false,
    // {@endhighlight}
  );
}

@RoutePage()
class UntappableTilePage extends Sample {
  UntappableTilePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTile(
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
  );
}

@RoutePage()
class TileSubtitlePage extends Sample {
  TileSubtitlePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTile(
    prefix: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    // {@highlight}
    subtitle: const Text('Banners, Sounds, Badges'),
    // {@endhighlight}
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class TileDetailsPage extends Sample {
  TileDetailsPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTile(
    prefix: const Icon(FIcons.wifi),
    title: const Text('WiFi'),
    // {@highlight}
    details: const Text('Duobase (5G)'),
    // {@endhighlight}
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}
