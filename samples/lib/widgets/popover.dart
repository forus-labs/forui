import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class PopoverPage extends StatelessWidget {
  final FThemeData theme;
  final Alignment alignment;
  final Axis axis;
  final bool hideOnTapOutside;
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  PopoverPage({
    @queryParam String theme = 'zinc-light',
    @queryParam String alignment = 'center',
    @queryParam String axis = 'vertical',
    @queryParam String hideOnTapOutside = 'true',
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
        hideOnTapOutside = bool.tryParse(hideOnTapOutside) ?? true,
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
                builder: (context) => _Popover(
                  axis: axis,
                  hideOnTapOutside: hideOnTapOutside,
                  shift: shift,
                ),
              ),
            ),
          ),
        ),
      );
}

class _Popover extends StatefulWidget {
  final Axis axis;
  final bool hideOnTapOutside;
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  const _Popover({required this.axis, required this.hideOnTapOutside, required this.shift});

  @override
  State<_Popover> createState() => _State();
}

class _State extends State<_Popover> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          FPopover(
            controller: controller,
            followerAnchor: widget.axis == Axis.horizontal ? Alignment.topLeft : Alignment.topCenter,
            targetAnchor: widget.axis == Axis.horizontal ? Alignment.topRight : Alignment.bottomCenter,
            hideOnTapOutside: widget.hideOnTapOutside,
            shift: widget.shift,
            followerBuilder: (context, style, _) => Padding(
              padding: const EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 10),
              child: SizedBox(
                width: 288,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dimensions', style: context.theme.typography.base),
                    const SizedBox(height: 7),
                    Text(
                      'Set the dimensions for the layer.',
                      style: context.theme.typography.sm.copyWith(
                        color: context.theme.colorScheme.mutedForeground,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 15),
                    for (final (label, value) in [
                      ('Width', '100%'),
                      ('Max. Width', '300px'),
                      ('Height', '25px'),
                      ('Max. Height', 'none'),
                    ]) ...[
                      Row(
                        children: [
                          Expanded(child: Text(label, style: context.theme.typography.sm)),
                          Expanded(flex: 2, child: FTextField(initialValue: value)),
                        ],
                      ),
                      const SizedBox(height: 7),
                    ],
                  ],
                ),
              ),
            ),
            target: IntrinsicWidth(
              child: FButton(
                style: FButtonStyle.outline,
                onPress: controller.toggle,
                label: const Text('Open popover'),
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
