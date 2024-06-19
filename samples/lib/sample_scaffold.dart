// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
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
  }):
    theme = themes[theme]!;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: theme.colorScheme.background,
    body: FTheme(
      data: theme,
      child: Center(
        child: child(context),
      ),
    ),
  );

  Widget child(BuildContext context);
}
