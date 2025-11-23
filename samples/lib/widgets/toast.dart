import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ToastPage extends Sample {
  ToastPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      spacing: 5,
      children: [
        for (final (FToastAlignment alignment, description) in [
          (.topLeft, 'Top Left'),
          (.topCenter, 'Top Center'),
          (.topRight, 'Top Right'),
          (.bottomLeft, 'Bottom Left'),
          (.bottomCenter, 'Bottom Center'),
          (.bottomRight, 'Bottom Right'),
        ])
          FButton(
            onPress: () => showFToast(
              context: context,
              alignment: alignment,
              title: const Text('Event has been created'),
              description: const Text('Friday, May 23, 2025 at 9:00 AM'),
              suffixBuilder: (context, entry) => IntrinsicHeight(
                child: FButton(
                  style: context.theme.buttonStyles.primary.copyWith(
                    contentStyle: context.theme.buttonStyles.primary.contentStyle.copyWith(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
                      textStyle: .all(
                        context.theme.typography.xs.copyWith(color: context.theme.colors.primaryForeground),
                      ),
                    ),
                  ),
                  onPress: entry.dismiss,
                  child: const Text('Undo'),
                ),
              ),
            ),
            child: Text('Show $description Toast'),
          ),
      ],
    ),
  );
}

@RoutePage()
class NoAutoDismissToastPage extends Sample {
  NoAutoDismissToastPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Center(
    child: FButton(
      mainAxisSize: .min,
      onPress: () => showFToast(
        context: context,
        duration: null,
        icon: const Icon(FIcons.triangleAlert),
        title: const Text('Event start time cannot be earlier than 8am'),
      ),
      child: const Text('Show Toast'),
    ),
  );
}

@RoutePage()
class RawToastPage extends Sample {
  RawToastPage({@queryParam super.theme});

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
      child: FButton(
        mainAxisSize: .min,
        onPress: () => showRawFToast(
          context: context,
          duration: null,
          builder: (context, toast) => IntrinsicHeight(
            child: FCard(
              style: cardStyle,
              title: const Text('Event has been created'),
              subtitle: const Padding(
                padding: .symmetric(vertical: 5),
                child: Text(
                  'This is a more detailed description that provides comprehensive context and additional information '
                  'about the notification, explaining what happened and what the user might expect next.',
                ),
              ),
              child: FButton(onPress: () => toast.dismiss(), child: const Text('undo')),
            ),
          ),
        ),
        child: const Text('Show Toast'),
      ),
    );
  }
}

@RoutePage()
class BehaviorToastPage extends StatelessWidget {
  final FThemeData theme;
  final FToasterExpandBehavior behavior;

  BehaviorToastPage({@queryParam String theme = 'zinc-light', @queryParam String behavior = 'always'})
    : theme = themes[theme]!,
      behavior = behavior == 'always' ? .always : .disabled;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FScaffold(
      toasterStyle: context.theme.toasterStyle.copyWith(expandBehavior: behavior),
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Builder(
            builder: (context) => Center(
              child: FButton(
                mainAxisSize: .min,
                onPress: () => showFToast(
                  context: context,
                  icon: const Icon(FIcons.info),
                  title: const Text('Event has been created'),
                ),
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

@RoutePage()
class SwipeToastPage extends StatelessWidget {
  final FThemeData theme;
  final List<AxisDirection> directions;

  SwipeToastPage({@queryParam String theme = 'zinc-light', @queryParam bool down = false})
    : theme = themes[theme]!,
      directions = [if (down) .down];

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FScaffold(
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Builder(
            builder: (context) => Center(
              child: FButton(
                mainAxisSize: .min,
                onPress: () => showFToast(
                  context: context,
                  swipeToDismiss: directions,
                  icon: const Icon(FIcons.info),
                  title: const Text('Event has been created'),
                ),
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
