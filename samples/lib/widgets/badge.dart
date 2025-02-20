// ignore_for_file: invalid_use_of_internal_member, implementation_imports

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/src/widgets/badge/badge.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class BadgePage extends Sample {
  static final styles = {for (final value in Variant.values) value.name: value};

  final FBadgeStyle style;

  BadgePage({@queryParam super.theme, @queryParam String style = 'primary'}) : style = styles[style]!;

  @override
  Widget sample(BuildContext context) => FBadge(label: const Text('Badge'), style: style);
}
