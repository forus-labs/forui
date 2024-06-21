// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

// Project imports:
import 'package:forui_samples/sample_scaffold.dart';

final variants = {
  for (final value in Variant.values)
    value.name: value,
};

@RoutePage()
class ButtonTextPage extends SampleScaffold {
  final Variant variant;
  final String label;

  ButtonTextPage({
    @queryParam super.theme,
    @queryParam String variant = 'primary',
    @queryParam this.label = 'Button',
  }):
    variant = variants[variant] ?? Variant.primary;

  @override
  Widget child(BuildContext context) => IntrinsicWidth(
    child: FButton(
      label: label,
      style: variant,
      onPress: () {  },
    ),
  );
}

@RoutePage()
class ButtonIconPage extends SampleScaffold {
  final Variant variant;

  ButtonIconPage({
    @queryParam super.theme = 'zinc-light',
    @queryParam String variant = 'primary',
  }):
    variant = variants[variant]!;

  @override
  Widget child(BuildContext context) => IntrinsicWidth(
    child: FButton(
      prefixIcon: FButtonIcon(icon: FAssets.icons.mail),
      label: 'Login with Email',
      style: variant,
      onPress: () {  },
    ),
  );
}
