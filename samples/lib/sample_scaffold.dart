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

  @override
  Widget build(BuildContext context) => FTheme(
        data: theme,
        child: FScaffold(
          content: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: child(context),
            ),
          ),
        ),
      );

  Widget child(BuildContext context);
}
