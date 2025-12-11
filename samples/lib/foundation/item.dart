import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ItemPage extends Sample {
  final bool enabled;
  final bool tappable;

  ItemPage({@queryParam super.theme, @queryParam this.enabled = true, @queryParam this.tappable = true});

  @override
  Widget sample(BuildContext _) => FItem(
    enabled: enabled,
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
    onPress: tappable ? () {} : null,
  );
}

@RoutePage()
class ItemSubtitlePage extends Sample {
  ItemSubtitlePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FItem(
    prefix: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    subtitle: const Text('Banners, Sounds, Badges'),
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class ItemDetailsPage extends Sample {
  ItemDetailsPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FItem(
    prefix: const Icon(FIcons.wifi),
    title: const Text('WiFi'),
    details: const Text('Forus Labs (5G)'),
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}
