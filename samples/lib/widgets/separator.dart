import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SeparatorPage extends SampleScaffold {
  SeparatorPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) {
    final colorScheme = theme.colorScheme;
    final typography = theme.typography;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Flutter Forui',
              style: typography.xl2.copyWith(
                color: colorScheme.foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'An open-source widget library.',
              style: typography.sm.copyWith(color: colorScheme.mutedForeground),
            ),
            const FSeparator(),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Blog',
                    style: typography.sm.copyWith(color: colorScheme.foreground),
                  ),
                  const FSeparator(vertical: true),
                  Text(
                    'Docs',
                    style: typography.sm.copyWith(color: colorScheme.foreground),
                  ),
                  const FSeparator(vertical: true),
                  Text(
                    'Source',
                    style: typography.sm.copyWith(color: colorScheme.foreground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
