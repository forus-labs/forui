import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ToastPage extends Example {
  ToastPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Column(
    mainAxisSize: .min,
    mainAxisAlignment: .center,
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
                    padding: const .symmetric(horizontal: 12, vertical: 7.5),
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
  );
}

@RoutePage()
class NoAutoDismissToastPage extends Example {
  NoAutoDismissToastPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    mainAxisSize: .min,
    onPress: () => showFToast(
      context: context,
      // {@highlight}
      duration: null,
      // {@endhighlight}
      icon: const Icon(FIcons.triangleAlert),
      title: const Text('Event start time cannot be earlier than 8am'),
    ),
    child: const Text('Show Toast'),
  );
}

@RoutePage()
class RawToastPage extends Example {
  RawToastPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) {
    final cardStyle = context.theme.cardStyle.copyWith(
      contentStyle: context.theme.cardStyle.contentStyle.copyWith(
        titleTextStyle: context.theme.typography.sm.copyWith(
          color: context.theme.colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return FButton(
      mainAxisSize: .min,
      // {@highlight}
      onPress: () => showRawFToast(
        // {@endhighlight}
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
    );
  }
}

@RoutePage()
class AlwaysExpandToastPage extends StatelessWidget {
  final FThemeData theme;

  AlwaysExpandToastPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FToaster(
      style: context.theme.toasterStyle.copyWith(
        // {@highlight}
        expandBehavior: .always,
        // {@endhighlight}
      ),
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
    ),
  );
}

@RoutePage()
class DisabledExpandToastPage extends StatelessWidget {
  final FThemeData theme;

  DisabledExpandToastPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FToaster(
      style: context.theme.toasterStyle.copyWith(
        // {@highlight}
        expandBehavior: .disabled,
        // {@endhighlight}
      ),
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
    ),
  );
}

@RoutePage()
class SwipeToastPage extends StatelessWidget {
  final FThemeData theme;

  SwipeToastPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext _) => FTheme(
    data: theme,
    child: FToaster(
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
    ),
  );
}

@RoutePage()
class DownSwipeToastPage extends StatelessWidget {
  final FThemeData theme;

  DownSwipeToastPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext _) => FTheme(
    data: theme,
    child: FToaster(
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
                    // {@highlight}
                    swipeToDismiss: [.down],
                    // {@endhighlight}
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
    ),
  );
}

@RoutePage()
class DisabledSwipeToastPage extends StatelessWidget {
  final FThemeData theme;

  DisabledSwipeToastPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext _) => FTheme(
    data: theme,
    child: FToaster(
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
                    // {@highlight}
                    swipeToDismiss: [],
                    // {@endhighlight}
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
    ),
  );
}
