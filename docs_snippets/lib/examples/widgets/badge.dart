import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class BadgePrimaryPage extends Example {
  BadgePrimaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.primary(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}

@RoutePage()
class BadgeSecondaryPage extends Example {
  BadgeSecondaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.secondary(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}

@RoutePage()
class BadgeDestructivePage extends Example {
  BadgeDestructivePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.destructive(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}

@RoutePage()
class BadgeOutlinePage extends Example {
  BadgeOutlinePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FBadge(
    // {@highlight}
    style: FBadgeStyle.outline(),
    // {@endhighlight}
    child: const Text('Badge'),
  );
}
