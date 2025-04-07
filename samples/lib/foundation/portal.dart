import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PortalPage extends Sample {
  PortalPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const _Portal();
}

class _Portal extends StatefulWidget {
  const _Portal();

  @override
  State<_Portal> createState() => _State();
}

class _State extends State<_Portal> with SingleTickerProviderStateMixin {
  late OverlayPortalController controller;

  @override
  void initState() {
    super.initState();
    controller = OverlayPortalController();
  }

  @override
  Widget build(BuildContext context) => FPortal(
    controller: controller,
    portalBuilder:
        (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.colors.background,
              border: Border.all(color: context.theme.colors.border),
              borderRadius: BorderRadius.circular(4),
            ),
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
                  for (final (label, value) in [('Width', '100%'), ('Max. Width', '300px')]) ...[
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
        ),
    child: FButton(child: const Text('Portal'), onPress: () => controller.toggle()),
  );
}
