import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class BadgePrimaryPage extends Sample {
  BadgePrimaryPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.primary(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}

@RoutePage()
class BadgeSecondaryPage extends Sample {
  BadgeSecondaryPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.secondary(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}

@RoutePage()
class BadgeDestructivePage extends Sample {
  BadgeDestructivePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.destructive(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}

@RoutePage()
class BadgeOutlinePage extends Sample {
  BadgeOutlinePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.outline(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}
