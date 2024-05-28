import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

/// The application widget.
class Application extends StatelessWidget {
  /// Creates an application widget.
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: FTheme(
          data: FThemes.zinc.light,
          child: Scaffold(
            backgroundColor: FThemes.zinc.light.colorScheme.background,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: FBadge(
                  design: FBadgeVariant.outline,
                  label: 'Hello, World!',
                ),
              ),
            ),
          ),
        ),
      );
}
