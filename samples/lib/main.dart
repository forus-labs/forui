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
          data: FZincTheme.light,
          child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              // TODO: Replace with FText.
              child: Text(
                'Hello',
                style: ScaledTextStyle(const TextStyle(fontWeight: FontWeight.w500), FTheme.of(context).font),
              ),
            ),
          ),
        ),
      );
}
