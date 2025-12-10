import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverPage extends Sample {
  final Axis axis;
  final FPopoverHideRegion hideRegion;
  final FPortalOverflow overflow;

  PopoverPage({
    @queryParam String alignment = 'center',
    @queryParam String axis = 'vertical',
    @queryParam String hideRegion = 'anywhere',
    @queryParam String overflow = 'flip',
    @queryParam super.theme,
  }) : axis = switch (axis) {
         'horizontal' => .horizontal,
         _ => .vertical,
       },
       hideRegion = switch (hideRegion) {
         'anywhere' => .anywhere,
         'excludeChild' => .excludeChild,
         _ => .none,
       },
       overflow = switch (overflow) {
         'flip' => .flip,
         'slide' => .slide,
         _ => .allow,
       },
       super(
         alignment: switch (alignment) {
           'topCenter' => .topCenter,
           'bottomCenter' => .bottomCenter,
           _ => .center,
         },
         maxHeight: 200,
       );

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [
      const SizedBox(height: 30),
      FPopover(
        popoverAnchor: axis == .horizontal ? .bottomLeft : .topCenter,
        childAnchor: axis == .horizontal ? .bottomRight : .bottomCenter,
        hideRegion: hideRegion,
        overflow: overflow,
        popoverBuilder: (context, _) => Padding(
          padding: const .only(left: 20, top: 14, right: 20, bottom: 10),
          child: SizedBox(
            width: 288,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text('Dimensions', style: context.theme.typography.base),
                const SizedBox(height: 7),
                Text(
                  'Set the dimensions for the layer.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                    fontWeight: .w300,
                  ),
                ),
                const SizedBox(height: 15),
                for (final (index, (label, value)) in [
                  ('Width', '100%'),
                  ('Max. Width', '300px'),
                  ('Height', '25px'),
                  ('Max. Height', 'none'),
                ].indexed) ...[
                  Row(
                    children: [
                      Expanded(child: Text(label, style: context.theme.typography.sm)),
                      Expanded(
                        flex: 2,
                        child: FTextField(
                          control: .managed(initial: TextEditingValue(text: value)),
                          autofocus: index == 0,
                        ),
                      ),
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
          mainAxisSize: .min,
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
    mainAxisAlignment: .center,
    crossAxisAlignment: .end,
    children: [
      Column(
        crossAxisAlignment: .start,
        children: [
          Text('Layer Properties', style: context.theme.typography.xl.copyWith(fontWeight: .bold)),
          const SizedBox(height: 20),
          const FTextField(
            control: .managed(initial: TextEditingValue(text: 'Header Component')),
          ),
          const SizedBox(height: 16),
          const FTextField(
            control: .managed(initial: TextEditingValue(text: 'Navigation Bar')),
          ),
          const SizedBox(height: 30),
        ],
      ),
      FPopover(
        style: context.theme.popoverStyle.copyWith(
          barrierFilter: (animation) => ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            inner: ColorFilter.mode(
              Color.lerp(Colors.transparent, Colors.black.withValues(alpha: 0.2), animation)!,
              .srcOver,
            ),
          ),
        ),
        popoverAnchor: .topCenter,
        childAnchor: .bottomCenter,
        popoverBuilder: (context, _) => Padding(
          padding: const .only(left: 20, top: 14, right: 20, bottom: 10),
          child: SizedBox(
            width: 288,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text('Dimensions', style: context.theme.typography.base),
                const SizedBox(height: 7),
                Text(
                  'Set the dimensions for the layer.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                    fontWeight: .w300,
                  ),
                ),
                const SizedBox(height: 15),
                for (final (index, (label, value)) in [
                  ('Width', '100%'),
                  ('Max. Width', '300px'),
                  ('Height', '25px'),
                  ('Max. Height', 'none'),
                ].indexed) ...[
                  Row(
                    children: [
                      Expanded(child: Text(label, style: context.theme.typography.sm)),
                      Expanded(
                        flex: 2,
                        child: FTextField(
                          control: .managed(initial: TextEditingValue(text: value)),
                          autofocus: index == 0,
                        ),
                      ),
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
          mainAxisSize: .min,
          onPress: controller.toggle,
          child: const Text('Open popover'),
        ),
      ),
    ],
  );
}
