import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class DialogPage extends Example {
  DialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: FDialog(
          style: style,
          animation: animation,
          // {@highlight}
          direction: .horizontal,
          // {@endhighlight}
          title: const Text('Are you absolutely sure?'),
          body: const Text(
            'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
          ),
          actions: [
            FButton(
              style: FButtonStyle.outline(),
              child: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop(),
            ),
            FButton(child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    ),
    child: const Text('Show Dialog'),
  );
}

@RoutePage()
class VerticalDialogPage extends Example {
  VerticalDialogPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FButton(
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
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
  );
}

@RoutePage()
class BlurredDialogPage extends Example {
  BlurredDialogPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 10);

  @override
  Widget example(BuildContext context) => FButton(
    mainAxisSize: .min,
    onPress: () => showFDialog(
      context: context,
      routeStyle: context.theme.dialogRouteStyle.copyWith(
        // {@highlight}
        barrierFilter: (animation) => ImageFilter.compose(
          outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
          inner: ColorFilter.mode(context.theme.colors.barrier, .srcOver),
        ),
        // {@endhighlight}
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
  );
}
