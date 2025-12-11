import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

final _styles = {
  'primary': FButtonStyle.primary(),
  'secondary': FButtonStyle.secondary(),
  'destructive': FButtonStyle.destructive(),
  'ghost': FButtonStyle.ghost(),
  'outline': FButtonStyle.outline(),
};

@RoutePage()
class ButtonTextPage extends Sample {
  final FBaseButtonStyle Function(FButtonStyle) style;
  final String label;

  ButtonTextPage({@queryParam super.theme, @queryParam String style = 'primary', @queryParam this.label = 'Button'})
    : style = _styles[style]!;

  @override
  Widget sample(BuildContext _) => FButton(style: style, mainAxisSize: .min, onPress: () {}, child: Text(label));
}

@RoutePage()
class ButtonIconPage extends Sample {
  final FBaseButtonStyle Function(FButtonStyle) style;

  ButtonIconPage({@queryParam super.theme, @queryParam String style = 'primary'})
    : style = _styles[style]!;

  @override
  Widget sample(BuildContext _) => FButton(
    style: style,
    mainAxisSize: .min,
    prefix: const Icon(FIcons.mail),
    onPress: () {},
    child: const Text('Login with Email'),
  );
}

@RoutePage()
class ButtonOnlyIconPage extends Sample {
  ButtonOnlyIconPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FButton.icon(child: const Icon(FIcons.chevronRight), onPress: () {});
}

@RoutePage()
class ButtonCircularProgressPage extends Sample {
  ButtonCircularProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) =>
      FButton(mainAxisSize: .min, prefix: const FCircularProgress(), onPress: null, child: const Text('Please wait'));
}
