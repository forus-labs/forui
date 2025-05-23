import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SonnerPage extends Sample {
  SonnerPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) {
    final cardStyle = context.theme.cardStyle.copyWith(
      contentStyle: context.theme.cardStyle.contentStyle.copyWith(
        titleTextStyle: context.theme.typography.sm.copyWith(
          color: context.theme.colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          FButton(
            intrinsicWidth: true,
            onPress: () {
              Widget buildToast(BuildContext context, FSonnerEntry toast) => IntrinsicHeight(
                child: FCard(
                  style: cardStyle,
                  title: const Text('Event has been created'),
                  subtitle: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text('This is a brief description that provides additional context.'),
                  ),
                  child: FButton(onPress: () => toast.dismiss(), child: const Text('Undo')),
                ),
              );

              showRawFSonner(context: context, builder: buildToast);
            },
            child: const Text('Show Small Toast'),
          ),
          FButton(
            intrinsicWidth: true,
            onPress: () {
              Widget buildToast(BuildContext context, FSonnerEntry toast) => IntrinsicHeight(
                child: FCard(
                  style: cardStyle,
                  title: const Text('Event has been created'),
                  subtitle: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'This is a more detailed description that provides comprehensive context and additional '
                      'information about the notification, explaining what happened and what the user might expect '
                      'next.',
                    ),
                  ),
                  child: FButton(onPress: () => toast.dismiss(), child: const Text('Undo')),
                ),
              );

              showRawFSonner(context: context, builder: buildToast);
            },
            child: const Text('Show Large Toast'),
          ),
        ],
      ),
    );
  }
}
