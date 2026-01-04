import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PortalPage extends Example {
  PortalPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FPortal(
    spacing: const .spacing(8),
    viewInsets: const .all(5),
    portalBuilder: (context, _) => Container(
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        border: .all(color: context.theme.colors.border),
        borderRadius: .circular(4),
      ),
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
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 15),
            for (final (label, value) in [('Width', '100%'), ('Max. Width', '300px')]) ...[
              Row(
                children: [
                  Expanded(child: Text(label, style: context.theme.typography.sm)),
                  Expanded(
                    flex: 2,
                    child: FTextField(
                      control: .managed(initial: TextEditingValue(text: value)),
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
    builder: (context, controller, _) => FButton(onPress: controller.toggle, child: const Text('Portal')),
  );
}
