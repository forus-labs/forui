import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SeparatorPage extends SampleScaffold {
  SeparatorPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final typography = theme.typography;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forui',
            style: TextStyle(
              fontSize: typography.base,
              fontWeight: FontWeight.w600,
              color: colorScheme.foreground,
            ),
          ),
          const FSeparator(),
          Text(
            'An open-source UI component library.',
            style: TextStyle(
              fontSize: typography.sm,
              color: colorScheme.mutedForeground,
            ),
          ),
        ],
        ),
    );
  }
}
