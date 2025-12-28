import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class AlertPrimaryPage extends Sample {
  AlertPrimaryPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FAlert(
    // {@highlight}
    style: FAlertStyle.primary(),
    // {@endhighlight}
    title: const Text('Heads Up!'),
    subtitle: const Text('You can add components to your app using the cli.'),
  );
}

@RoutePage()
class AlertDestructivePage extends Sample {
  AlertDestructivePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FAlert(
    // {@highlight}
    style: FAlertStyle.destructive(),
    // {@endhighlight}
    title: const Text('Heads Up!'),
    subtitle: const Text('You can add components to your app using the cli.'),
  );
}
