import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SonnerPage extends Sample {
  SonnerPage({@queryParam super.theme, super.key});

  @override
  Widget sample(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        for (final (alignment, description) in [
          (FSonnerAlignment.topLeft, 'Top Left'),
          (FSonnerAlignment.topCenter, 'Top Center'),
          (FSonnerAlignment.topRight, 'Top Right'),
          (FSonnerAlignment.bottomLeft, 'Bottom Left'),
          (FSonnerAlignment.bottomCenter, 'Bottom Center'),
          (FSonnerAlignment.bottomRight, 'Bottom Right'),
        ])
          FButton(
            onPress: () => showFSonner(
              context: context,
              alignment: alignment,
              title: const Text('Event has been created'),
              description: const Text('Friday, May 23, 2025 at 9:00 AM'),
              suffixBuilder: (context, entry, _) => IntrinsicHeight(
                child: FButton(
                  style: context.theme.buttonStyles.primary.copyWith(
                    contentStyle: context.theme.buttonStyles.primary.contentStyle.copyWith(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
                      textStyle: FWidgetStateMap.all(
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
class NoAutoDismissSonnerPage extends Sample {
  NoAutoDismissSonnerPage({@queryParam super.theme, super.key});

  @override
  Widget sample(BuildContext context) => Center(
    child: FButton(
      intrinsicWidth: true,
      onPress: () => showFSonner(
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
class RawSonnerPage extends Sample {
  RawSonnerPage({@queryParam super.theme, super.key});

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
        intrinsicWidth: true,
        onPress: () => showRawFSonner(
          context: context,
          duration: null,
          builder: (context, toast) => IntrinsicHeight(
            child: FCard(
              style: cardStyle,
              title: const Text('Event has been created'),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
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
class BehaviorSonnerPage extends StatelessWidget {
  final FThemeData theme;
  final FSonnerExpandBehavior behavior;

  BehaviorSonnerPage({@queryParam String theme = 'zinc-light', @queryParam String behavior = 'always', super.key})
    : theme = themes[theme]!,
      behavior = behavior == 'always' ? FSonnerExpandBehavior.always : FSonnerExpandBehavior.disabled;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FScaffold(
      sonnerStyle: context.theme.sonnerStyle.copyWith(expandBehavior: behavior),
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Builder(
            builder: (context) => Center(
              child: FButton(
                intrinsicWidth: true,
                onPress: () => showFSonner(
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
