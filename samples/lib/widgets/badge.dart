import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

final _styles = {
  'primary': FBadgeStyle.primary(),
  'secondary': FBadgeStyle.secondary(),
  'destructive': FBadgeStyle.destructive(),
  'outline': FBadgeStyle.outline(),
};

@RoutePage()
class BadgePage extends Sample {
  final FBaseBadgeStyle Function(FBadgeStyle) style;

  BadgePage({@queryParam String style = 'primary', @queryParam super.theme}) : style = _styles[style]!;

  @override
  Widget sample(BuildContext context) => FBadge(style: style, child: const Text('Badge'));
}
