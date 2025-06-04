import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

Widget small(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, _) => Container(
        width: 250,
        height: 143,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.blue),
        child: Text(text),
      ),
    ),
    child: Text(text),
  ),
);

Widget big(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, _) => Container(
        width: 312,
        height: 201,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.red),
        child: Text(text),
      ),
    ),
    child: Text(text),
  ),
);

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final controller = FPopoverController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        FButton(
          child: const Text('Click me'),
          onPress: () => showFSheet(
            context: context,
            side: FLayout.btt,
            mainAxisMaxRatio: null,
            builder: (context) => DraggableScrollableSheet(
              expand: false,
              builder: (context, controller) => ScrollConfiguration(
                // This is required to enable dragging on desktop.
                // See https://github.com/flutter/flutter/issues/101903 for more information.
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad}),
                child: FTileGroup.builder(
                  count: 25,
                  scrollController: controller,
                  tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
                ),
              ),
            ),
          ),
        ),
        FPopover(
          style: context.theme.popoverStyle.copyWith(
            barrierFilter: (animation) => ImageFilter.compose(
              outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
              inner: ColorFilter.mode(Colors.black.withValues(alpha: animation * 0.2), BlendMode.srcOver),
            ),
          ),
          controller: controller,
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
          builder: (_, controller, _) => IntrinsicWidth(
            child: FButton(style: FButtonStyle.outline, onPress: controller.toggle, child: const Text('Open popover')),
          ),
        ),
      ],
    );
  }
}
