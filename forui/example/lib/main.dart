import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:forui_example/example.dart';

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
          child: FScaffold(
            header: FHeader(
              title: const Text('Example Example Example Example'),
              actions: [
                FHeaderAction(
                  icon: FAssets.icons.plus,
                  onPress: () {},
                ),
              ],
            ),
            content: const Example(),
          ),
        ),
      ));
}
