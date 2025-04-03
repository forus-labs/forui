import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';

import 'package:forui_samples/sample.dart';

// ignore_for_file: invalid_use_of_internal_member, implementation_imports

final variants = {for (final value in Variant.values) value.name: value};

@RoutePage()
class ButtonTextPage extends Sample {
  final Variant variant;
  final String label;

  ButtonTextPage({@queryParam super.theme, @queryParam String style = 'primary', @queryParam this.label = 'Button'})
    : variant = variants[style] ?? Variant.primary;

  @override
  Widget sample(BuildContext context) =>
      IntrinsicWidth(child: FButton(style: variant, onPress: () {}, child: Text(label)));
}

@RoutePage()
class ButtonIconPage extends Sample {
  final Variant variant;

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
  Widget sample(BuildContext context) =>
      IntrinsicWidth(child: FButton.icon(child: const Icon(FIcons.chevronRight), onPress: () {}));
}

@RoutePage()
class ButtonCircularProgressPage extends Sample {
  ButtonCircularProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => IntrinsicWidth(
    child: FButton(prefix: const FProgress.circularIcon(), onPress: null, child: const Text('Please wait')),
  );
}
