import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverPage extends StatefulSample {
  final Axis axis;
  final FHidePopoverRegion hideOnTapOutside;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  PopoverPage({
    @queryParam String alignment = 'center',
    @queryParam String axis = 'vertical',
    @queryParam String hideOnTapOutside = 'anywhere',
    @queryParam String shift = 'flip',
    @queryParam super.theme,
  }) : axis = switch (axis) {
         'horizontal' => Axis.horizontal,
         _ => Axis.vertical,
       },
       hideOnTapOutside = switch (hideOnTapOutside) {
         'anywhere' => FHidePopoverRegion.anywhere,
         'excludeTarget' => FHidePopoverRegion.excludeTarget,
         _ => FHidePopoverRegion.none,
       },
       shift = switch (shift) {
         'flip' => FPortalShift.flip,
         'along' => FPortalShift.along,
         _ => FPortalShift.none,
       },
       super(
         alignment: switch (alignment) {
           'topCenter' => Alignment.topCenter,
           'bottomCenter' => Alignment.bottomCenter,
           _ => Alignment.center,
         },
         maxHeight: 200,
       );

  @override
  State<PopoverPage> createState() => _PopoverState();
}

class _PopoverState extends StatefulSampleState<PopoverPage> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 30),
      FPopover(
        controller: controller,
        popoverAnchor: widget.axis == Axis.horizontal ? Alignment.bottomLeft : Alignment.topCenter,
        childAnchor: widget.axis == Axis.horizontal ? Alignment.bottomRight : Alignment.bottomCenter,
        hideOnTapOutside: widget.hideOnTapOutside,
        shift: widget.shift,
        popoverBuilder: (context, style, _) => Padding(
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
                    color: context.theme.colors.mutedForeground,
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
                      Expanded(flex: 2, child: FTextField(initialText: value)),
                    ],
                  ),
                  const SizedBox(height: 7),
                ],
              ],
            ),
          ),
        ),
        child: IntrinsicWidth(
          child: FButton(style: FButtonStyle.outline, onPress: controller.toggle, child: const Text('Open popover')),
        ),
      ),
    ],
  );
}

@RoutePage()
class BlurredPopoverPage extends StatefulSample {
  BlurredPopoverPage({@queryParam super.theme});

  @override
  State<BlurredPopoverPage> createState() => _BlurredPopoverState();
}

class _BlurredPopoverState extends StatefulSampleState<BlurredPopoverPage> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Layer Properties', style: context.theme.typography.xl.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const FTextField(initialText: 'Header Component'),
          const SizedBox(height: 16),
          const FTextField(initialText: 'Navigation Bar'),
          const SizedBox(height: 30),
        ],
      ),
      FPopover(
        controller: controller,
        barrier: ImageFilter.compose(
          outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          inner: ColorFilter.mode(Colors.black.withValues(alpha: 0.2), BlendMode.srcOver),
        ),
        popoverAnchor: Alignment.topCenter,
        childAnchor: Alignment.bottomCenter,
        popoverBuilder: (context, style, _) => Padding(
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
                    color: context.theme.colors.mutedForeground,
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
                      Expanded(flex: 2, child: FTextField(initialText: value)),
                    ],
                  ),
                  const SizedBox(height: 7),
                ],
              ],
            ),
          ),
        ),
        child: IntrinsicWidth(
          child: FButton(style: FButtonStyle.outline, onPress: controller.toggle, child: const Text('Open popover')),
        ),
      ),
    ],
  );
}
