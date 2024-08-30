import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/platform.dart'; // ignore: implementation_imports

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TooltipPage extends StatelessWidget {
  final FThemeData theme;
  final Alignment alignment;
  final Axis axis;
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  TooltipPage({
    @queryParam String theme = 'zinc-light',
    @queryParam String alignment = 'center',
    @queryParam String axis = 'vertical',
    @queryParam String shift = 'flip',
  })  : theme = themes[theme]!,
        alignment = switch (alignment) {
          'topCenter' => Alignment.topCenter,
          'bottomCenter' => Alignment.bottomCenter,
          _ => Alignment.center,
        },
        axis = switch (axis) {
          'horizontal' => Axis.horizontal,
          _ => Axis.vertical,
        },
        shift = switch (shift) {
          'flip' => FPortalFollowerShift.flip,
          'along' => FPortalFollowerShift.along,
          _ => FPortalFollowerShift.none,
        };

  @override
  Widget build(BuildContext context) => FTheme(
        data: theme,
        child: FScaffold(
          content: Align(
            alignment: alignment,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
              child: Builder(
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    FTooltip(
                      tipAnchor: axis == Axis.horizontal ? Alignment.topLeft : Alignment.bottomCenter,
                      childAnchor: axis == Axis.horizontal ? Alignment.topRight : Alignment.topCenter,
                      shift: shift,
                      tipBuilder: (context, style, _) => const Text('Add to library'),
                      child: IntrinsicWidth(
                        child: FButton(
                          style: FButtonStyle.outline,
                          onPress: () {},
                          // ignore: invalid_use_of_internal_member
                          label: Text(touchPlatforms.contains(defaultTargetPlatform) ? 'Long press' : 'Hover'),
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
