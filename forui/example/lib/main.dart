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
                child: FBadge.raw(
                  design: FBadgeVariant.outline,
                  builder: (context, style) => Padding(
                    padding: const EdgeInsets.all(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: style.background,
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                    )
                  )
                ),
              ),
            ),
          ),
        ),
      );
}
