import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class RootHeaderPage extends Example {
  RootHeaderPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader(
    title: const Text('Edit Alarm'),
    suffixes: [
      FHeaderAction(icon: const Icon(FIcons.alarmClock), onPress: () {}),
      FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
    ],
  );
}

@RoutePage()
class NestedHeaderPage extends Example {
  NestedHeaderPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader.nested(
    title: const Text('Appointment'),
    // {@highlight}
    prefixes: [FHeaderAction.back(onPress: () {})],
    // {@endhighlight}
    suffixes: [
      FHeaderAction(icon: const Icon(FIcons.info), onPress: () {}),
      FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
    ],
  );
}

@RoutePage()
class XNestedHeaderPage extends Example {
  XNestedHeaderPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader.nested(
    title: const Text('Climate'),
    prefixes: [
      FHeaderAction(icon: const Icon(FIcons.thermometer), onPress: () {}),
      const FHeaderAction(icon: Icon(FIcons.wind), onPress: null),
    ],
    // {@highlight}
    suffixes: [FHeaderAction.x(onPress: () {})],
    // {@endhighlight}
  );
}
