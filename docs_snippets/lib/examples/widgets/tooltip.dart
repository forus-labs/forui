import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TooltipPage extends StatelessWidget {
  final FThemeData theme;

  TooltipPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: .center,
              children: [
                const SizedBox(height: 30),
                FTooltip(
                  tipBuilder: (context, _) => const Text('Add to library'),
                  child: FButton(
                    style: FButtonStyle.outline(),
                    mainAxisSize: .min,
                    onPress: () {},
                    child: const Text('Long press/Hover'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

@RoutePage()
class HorizontalTooltipPage extends StatelessWidget {
  final FThemeData theme;

  HorizontalTooltipPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: .center,
              children: [
                const SizedBox(height: 30),
                FTooltip(
                  // {@highlight}
                  tipAnchor: .topLeft,
                  childAnchor: .topRight,
                  // {@endhighlight}
                  tipBuilder: (context, _) => const Text('Add to library'),
                  child: FButton(
                    style: FButtonStyle.outline(),
                    mainAxisSize: .min,
                    onPress: () {},
                    child: const Text('Long press/Hover'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

@RoutePage()
class LongPressOnlyTooltipPage extends StatelessWidget {
  final FThemeData theme;

  LongPressOnlyTooltipPage({@queryParam String theme = 'zinc-light'}) : theme = themes[theme]!;

  @override
  Widget build(BuildContext context) => FTheme(
    data: theme,
    child: FScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: .center,
              children: [
                const SizedBox(height: 30),
                FTooltip(
                  // {@highlight}
                  hover: false,
                  // {@endhighlight}
                  tipBuilder: (context, _) => const Text('Add to library'),
                  child: FButton(
                    style: FButtonStyle.outline(),
                    mainAxisSize: .min,
                    onPress: () {},
                    child: const Text('Long press'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
