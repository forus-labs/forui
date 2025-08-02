import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverPage extends Sample {
  final Axis axis;
  final FPopoverHideRegion hideRegion;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  PopoverPage({
    @queryParam String alignment = 'center',
    @queryParam String axis = 'vertical',
    @queryParam String hideRegion = 'anywhere',
    @queryParam String shift = 'flip',
    @queryParam super.theme,
  }) : axis = switch (axis) {
         'horizontal' => Axis.horizontal,
         _ => Axis.vertical,
       },
       hideRegion = switch (hideRegion) {
         'anywhere' => FPopoverHideRegion.anywhere,
         'excludeChild' => FPopoverHideRegion.excludeChild,
         _ => FPopoverHideRegion.none,
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
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 30),
      FPopover(
        popoverAnchor: axis == Axis.horizontal ? Alignment.bottomLeft : Alignment.topCenter,
        childAnchor: axis == Axis.horizontal ? Alignment.bottomRight : Alignment.bottomCenter,
        hideRegion: hideRegion,
        shift: shift,
        popoverBuilder: (context, _) => Padding(
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
        builder: (_, controller, _) => FButton(
          style: FButtonStyle.outline(),
          mainAxisSize: MainAxisSize.min,
          onPress: controller.toggle,
          child: const Text('Open popover'),
        ),
      ),
    ],
  );
}

@RoutePage()
class BlurredPopoverPage extends Sample {
  BlurredPopoverPage({@queryParam super.theme});

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
        style: context.theme.popoverStyle.copyWith(
          barrierFilter: (animation) => ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            inner: ColorFilter.mode(
              Color.lerp(Colors.transparent, Colors.black.withValues(alpha: 0.2), animation)!,
              BlendMode.srcOver,
            ),
          ),
        ),
        popoverAnchor: Alignment.topCenter,
        childAnchor: Alignment.bottomCenter,
        popoverBuilder: (context, _) => Padding(
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
        builder: (_, controller, _) => FButton(
          style: FButtonStyle.outline(),
          mainAxisSize: MainAxisSize.min,
          onPress: controller.toggle,
          child: const Text('Open popover'),
        ),
      ),
    ],
  );
}
