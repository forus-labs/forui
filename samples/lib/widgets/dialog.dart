import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class DialogPage extends Sample {
  final Axis direction;

  DialogPage({@queryParam super.theme, @queryParam bool vertical = false})
    : direction = vertical ? Axis.vertical : Axis.horizontal;

  @override
  Widget sample(BuildContext context) {
    final actions = [
      FButton(style: FButtonStyle.outline(), child: const Text('Cancel'), onPress: () => Navigator.of(context).pop()),
      FButton(child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
    ];

    return FButton(
      mainAxisSize: MainAxisSize.min,
      onPress: () => showFDialog(
        context: context,
        builder: (context, style, animation) => FTheme(
          data: theme,
          child: FDialog(
            style: style,
            animation: animation,
            direction: direction,
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: direction == Axis.vertical ? actions.reversed.toList() : actions,
          ),
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

@RoutePage()
class BlurredDialogPage extends Sample {
  BlurredDialogPage({@queryParam super.theme}) : super(alignment: Alignment.topCenter);

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: FButton(
      mainAxisSize: MainAxisSize.min,
      onPress: () => showFDialog(
        context: context,
        routeStyle: context.theme.dialogRouteStyle.copyWith(
          barrierFilter: (animation) => ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            inner: ColorFilter.mode(context.theme.colors.barrier, BlendMode.srcOver),
          ),
        ),
        builder: (context, style, animation) => FTheme(
          data: theme,
          child: FDialog(
            style: style,
            animation: animation,
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: [
              FButton(child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
              FButton(
                style: FButtonStyle.outline(),
                child: const Text('Cancel'),
                onPress: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
      child: const Text('Show Dialog'),
    ),
  );
}
