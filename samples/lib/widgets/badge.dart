import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class BadgePage extends SampleScaffold {
  static final variants = {
    for (final value in FBadgeVariant.values)
      value.name: value,
  };

  final FBadgeVariant variant;

  BadgePage({
    @queryParam super.theme,
    @queryParam String variant = 'primary',
  }):
    variant = variants[variant]!;

  @override
  Widget child(BuildContext context) => FBadge(
    label: 'Badge',
    design: variant,
  );
}
