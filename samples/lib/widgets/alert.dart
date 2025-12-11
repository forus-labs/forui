import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

final _styles = {'primary': FAlertStyle.primary(), 'destructive': FAlertStyle.destructive()};

@RoutePage()
class AlertPage extends Sample {
  final FBaseAlertStyle Function(FAlertStyle) style;

  AlertPage({@queryParam super.theme, @queryParam String style = 'primary'}) : style = _styles[style]!;

  @override
  Widget sample(BuildContext _) => FAlert(
    title: const Text('Heads Up!'),
    subtitle: const Text('You can add components to your app using the cli.'),
    style: style,
  );
}
