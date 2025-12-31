import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class AlertPrimaryPage extends Example {
  AlertPrimaryPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FAlert(
    // {@highlight}
    style: FAlertStyle.primary(),
    // {@endhighlight}
    title: const Text('Heads Up!'),
    subtitle: const Text('You can add components to your app using the cli.'),
  );
}

@RoutePage()
class AlertDestructivePage extends Example {
  AlertDestructivePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FAlert(
    // {@highlight}
    style: FAlertStyle.destructive(),
    // {@endhighlight}
    title: const Text('Heads Up!'),
    subtitle: const Text('You can add components to your app using the cli.'),
  );
}
