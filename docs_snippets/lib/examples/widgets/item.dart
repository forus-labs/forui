import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ItemPage extends Example {
  ItemPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
    // {@highlight}
    onPress: () {},
    // {@endhighlight}
  );
}

@RoutePage()
class ItemDisabledPage extends Example {
  ItemDisabledPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    // {@highlight}
    enabled: false,
    // {@endhighlight}
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}

@RoutePage()
class ItemUntappablePage extends Example {
  ItemUntappablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FIcons.user),
    title: const Text('Personalization'),
    suffix: const Icon(FIcons.chevronRight),
  );
}

@RoutePage()
class ItemSubtitlePage extends Example {
  ItemSubtitlePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
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
class ItemDetailsPage extends Example {
  ItemDetailsPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FItem(
    prefix: const Icon(FIcons.wifi),
    title: const Text('WiFi'),
    // {@highlight}
    details: const Text('Duobase (5G)'),
    // {@endhighlight}
    suffix: const Icon(FIcons.chevronRight),
    onPress: () {},
  );
}
