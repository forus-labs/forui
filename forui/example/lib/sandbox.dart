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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      FButton(style: FButtonStyle.outline, child: const Text('Cancel'), onPress: () => Navigator.of(context).pop()),
      FButton(child: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
    ];

    final _ = context.theme.dialogStyle;
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
          intrinsicWidth: true,
          onPress: () => showFDialog(
            style: context.theme.dialogStyle.copyWith(
              backgroundFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              decoration: BoxDecoration(
                borderRadius: context.theme.style.borderRadius,
                color: context.theme.colors.background.withValues(alpha: 0.2),
              ),
            ),
            context: context,
            builder: (context, style) => FDialog(
              style: style,
              direction: Axis.horizontal,
              title: const Text('Are you absolutely sure?'),
              body: const Text(
                'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
              ),
              actions: Axis.horizontal == Axis.vertical ? actions.reversed.toList() : actions,
            ),
          ),
          child: const Text('Show Dialog'),
        ),
        FPopover(
          style: context.theme.popoverStyle.copyWith(
            backgroundFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            decoration: BoxDecoration(
              color: context.theme.colors.background.withValues(alpha: 0.5),
              borderRadius: context.theme.style.borderRadius,
              border: Border.all(
                width: context.theme.style.borderWidth,
                color: context.theme.colors.border,
              ),
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
