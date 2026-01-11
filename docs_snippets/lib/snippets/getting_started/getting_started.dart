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
      // TODO: replace with your application's supported locales.
      supportedLocales: FLocalizations.supportedLocales,
      // TODO: add your application's localizations delegates.
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      // MaterialApp's theme is also animated by default with the same duration and curve.
      // See https://api.flutter.dev/flutter/material/MaterialApp/themeAnimationStyle.html for how to configure this.
      //
      // There is a known issue with implicitly animated widgets where their transition occurs AFTER the theme's.
      // See https://github.com/duobaseio/forui/issues/670.
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, child) => FTheme(
        data: theme,
        child: FToaster(child: child!),
      ),
      // You can also replace FScaffold with Material Scaffold.
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

class _ExampleState extends State<Example> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      spacing: 10,
      children: [
        Text('Count: $_count'),
        FButton(
          onPress: () => setState(() => _count++),
          suffix: const Icon(FIcons.chevronsUp),
          child: const Text('Increase'),
        ),
      ],
    ),
  );
}
