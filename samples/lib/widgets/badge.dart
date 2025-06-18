// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/src/widgets/badge/badge.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class BadgePage extends Sample {
  static final styles = {
    'primary': FBadgeStyle.primary(),
    'secondary': FBadgeStyle.secondary(),
    'destructive': FBadgeStyle.destructive(),
    'outline': FBadgeStyle.outline(),
  };

  final FBaseBadgeStyle Function(FBadgeStyle) style;

  BadgePage({@queryParam super.theme, @queryParam String style = 'primary'}) : style = styles[style]!;

  @override
  Widget sample(BuildContext context) => FBadge(style: style, child: const Text('Badge'));
}
