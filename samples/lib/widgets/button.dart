import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

final variants = {
  for (final value in FButtonVariant.values)
    value.name: value,
};

@RoutePage()
class ButtonTextPage extends SampleScaffold {
  final FButtonVariant variant;
  final String label;

  ButtonTextPage({
    @queryParam super.theme,
    @queryParam String variant = 'primary',
    @queryParam this.label = 'Button',
  }):
    variant = variants[variant] ?? FButtonVariant.primary;

  @override
  Widget child(BuildContext context) => IntrinsicWidth(
    child: FButton(
      label: label,
      design: variant,
      onPress: () {  },
    ),
  );
}

@RoutePage()
class ButtonIconPage extends SampleScaffold {
  final FButtonVariant variant;

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
      design: variant,
      onPress: () {  },
    ),
  );
}
