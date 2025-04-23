import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    /// Try changing this and hot reloading the application.
    ///
    /// To create a custom theme:
    /// ```shell
    /// dart forui theme create [theme template].
    /// ```
    final theme = FThemes.zinc.dark;

    return MaterialApp(
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      builder: (_, child) => FTheme(data: theme, child: child!),
      theme: theme.toApproximateMaterialTheme(),
      // You can replace FScaffold with Material's Scaffold.
      home: const FScaffold(
        // TODO: replace with your widget.
        child: Example(),
      ),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

enum Sidebar { recents, home, applications }

class _ExampleState extends State<Example> {
  int _count = 0;

  @override
  Widget build(BuildContext context) =>
      FTileGroup(
        label: const Text('Settings'),
        divider: FTileDivider.none,
        children: [
          FTile(
            prefixIcon: Icon(FIcons.user),
            title: const Text('Personalization'),
            suffixIcon: Icon(FIcons.chevronRight),
            onPress: () {},
          ),
          FTile(
            prefixIcon: Icon(FIcons.wifi),
            title: const Text('WiFi'),
            details: const Text('Forus Labs (5G)'),
            suffixIcon: Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ],
      );
}
