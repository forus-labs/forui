import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// The themes.
final themes = {
  'zinc-light': FThemes.zinc.light,
  'zinc-dark': FThemes.zinc.dark,
};

abstract class SampleScaffold extends StatelessWidget {
  final FThemeData theme;

  SampleScaffold({
    String theme = 'zinc-light',
    super.key,
  }) : theme = themes[theme]!;

  // In most cases, we should create FTheme inside MaterialApp.builder(...) instead. Otherwise FDialog will not inherit
  // from FTheme since it is in a different route.
  //
  // We do not does that in this project since the theme is determined by a query parameter upon navigating to each page.
  // This requires us to immediately set the state of the page's parent widget that stores the theme data. Doing so
  // is extremely hacky and prone to infinite build cycles.
  //
  // That said, I'm open to suggestions on how to fix this issue.
  @override
  Widget build(BuildContext context) => FTheme(
        data: theme,
        child: FScaffold(
          content: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Builder(
                builder: child,
              ),
            ),
          ),
        ),
      );

  Widget child(BuildContext context);
}
