import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

final variants = {
  'primary': FButtonStyle.primary(),
  'secondary': FButtonStyle.secondary(),
  'destructive': FButtonStyle.destructive(),
  'ghost': FButtonStyle.ghost(),
  'outline': FButtonStyle.outline(),
};

@RoutePage()
class ButtonTextPage extends Sample {
  final FBaseButtonStyle Function(FButtonStyle) variant;
  final String label;

  ButtonTextPage({@queryParam super.theme, @queryParam String style = 'primary', @queryParam this.label = 'Button'})
    : variant = variants[style]!;

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
    child: FButton(style: variant, onPress: () {}, child: Text(label)),
  );
}

@RoutePage()
class ButtonIconPage extends Sample {
  final FBaseButtonStyle Function(FButtonStyle) variant;

  ButtonIconPage({@queryParam super.theme = 'zinc-light', @queryParam String variant = 'primary'})
    : variant = variants[variant]!;

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
    child: FButton(
      prefix: const Icon(FIcons.mail),
      style: variant,
      onPress: () {},
      child: const Text('Login with Email'),
    ),
  );
}

@RoutePage()
class ButtonOnlyIconPage extends Sample {
  ButtonOnlyIconPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
    child: FButton.icon(child: const Icon(FIcons.chevronRight), onPress: () {}),
  );
}

@RoutePage()
class ButtonCircularProgressPage extends Sample {
  ButtonCircularProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
    child: FButton(
      style: context.theme.buttonStyles.primary.copyWith(),
      prefix: const FProgress.circularIcon(),
      onPress: null,
      child: const Text('Please wait'),
    ),
  );
}
