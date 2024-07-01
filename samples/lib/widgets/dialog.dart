import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class DialogPage extends SampleScaffold {
  final Axis direction;

  DialogPage({
    @queryParam super.theme,
    @queryParam bool vertical = false,
  }) : direction = vertical ? Axis.vertical : Axis.horizontal;

  @override
  Widget child(BuildContext context) {
    final actions = [
      FButton(style: FButtonStyle.outline, label: const Text('Cancel'), onPress: () => Navigator.of(context).pop()),
      FButton(label: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntrinsicWidth(
          child: FButton(
            label: const Text('Show Dialog'),
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                direction: direction,
                title: const Text('Are you absolutely sure?'),
                body: const Text(
                  'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                ),
                actions: direction == Axis.vertical ? actions.reversed.toList() : actions,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
