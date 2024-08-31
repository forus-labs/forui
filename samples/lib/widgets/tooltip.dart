import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TooltipPage extends StatelessWidget {
  final FThemeData theme;
  final FToolTipBehavior behavior;
  final Axis axis;

  TooltipPage({
    @queryParam String theme = 'zinc-light',
    @queryParam String behavior = 'hover-or-long-press',
    @queryParam String axis = 'vertical',
  })  : theme = themes[theme]!,
        behavior = switch (behavior) {
          'long-press' => FToolTipBehavior.longPress,
          'hover' => FToolTipBehavior.hover,
          _ => FToolTipBehavior.hoverOrLongPress,
        },
        axis = switch (axis) {
          'horizontal' => Axis.horizontal,
          _ => Axis.vertical,
        };

  @override
  Widget build(BuildContext context) => FTheme(
        data: theme,
        child: FScaffold(
          content: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
              child: Builder(
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    FTooltip(
                      behavior: behavior,
                      tipAnchor: axis == Axis.horizontal ? Alignment.topLeft : Alignment.bottomCenter,
                      childAnchor: axis == Axis.horizontal ? Alignment.topRight : Alignment.topCenter,
                      tipBuilder: (context, style, _) => const Text('Add to library'),
                      child: IntrinsicWidth(
                        child: FButton(
                          style: FButtonStyle.outline,
                          onPress: () {},
                          label: const Text('Long press/Hover'),
                        ),
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
