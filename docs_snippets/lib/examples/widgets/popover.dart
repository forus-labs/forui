import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PopoverPage extends Example {
  PopoverPage({@queryParam super.theme}) : super(alignment: .topCenter, maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext _) => FPopover(
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
  );
}

@RoutePage()
class HorizontalPopoverPage extends Example {
  HorizontalPopoverPage({@queryParam super.theme}) : super(alignment: .topCenter, maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext _) => FPopover(
    // {@highlight}
    popoverAnchor: .bottomLeft,
    childAnchor: .bottomRight,
    // {@endhighlight}
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
  );
}

@RoutePage()
class NoHideRegionPopoverPage extends Example {
  NoHideRegionPopoverPage({@queryParam super.theme}) : super(maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext _) => FPopover(
    popoverAnchor: .topCenter,
    childAnchor: .bottomCenter,
    // {@highlight}
    hideRegion: .none,
    // {@endhighlight}
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
  );
}

@RoutePage()
class NestedPopoverPage extends Example {
  NestedPopoverPage({@queryParam super.theme}) : super(alignment: .topCenter, maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext context) => FPopover(
    // {@highlight}
    groupId: 'nested-popover',
    // {@endhighlight}
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
            Row(
              children: [
                Expanded(child: Text('Width', style: context.theme.typography.sm)),
                Expanded(
                  flex: 2,
                  child: FSelect<String>.rich(
                    // {@highlight}
                    contentGroupId: 'nested-popover',
                    // {@endhighlight}
                    hint: 'Select',
                    format: (s) => s,
                    children: [
                      .item(title: const Text('100%'), value: '100%'),
                      .item(title: const Text('75%'), value: '75%'),
                      .item(title: const Text('50%'), value: '50%'),
                    ],
                  ),
                ),
              ],
            ),
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
  );
}

@RoutePage()
class BlurredPopoverPage extends Example {
  BlurredPopoverPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Column(
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
          // {@highlight}
          barrierFilter: (animation) => ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            inner: ColorFilter.mode(
              Color.lerp(Colors.transparent, Colors.black.withValues(alpha: 0.2), animation)!,
              .srcOver,
            ),
          ),
          // {@endhighlight}
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

@RoutePage()
class FlipPopoverPage extends Example {
  FlipPopoverPage({@queryParam super.theme}) : super(alignment: .bottomCenter, maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext _) => FPopover(
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
  );
}

@RoutePage()
class SlidePopoverPage extends Example {
  SlidePopoverPage({@queryParam super.theme}) : super(maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext _) => FPopover(
    popoverAnchor: .topCenter,
    childAnchor: .bottomCenter,
    // {@highlight}
    overflow: .slide,
    // {@endhighlight}
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
  );
}

@RoutePage()
class AllowOverflowPopoverPage extends Example {
  AllowOverflowPopoverPage({@queryParam super.theme}) : super(maxHeight: 200, top: 30);

  @override
  Widget example(BuildContext _) => FPopover(
    popoverAnchor: .topCenter,
    childAnchor: .bottomCenter,
    // {@highlight}
    overflow: .allow,
    // {@endhighlight}
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
  );
}
