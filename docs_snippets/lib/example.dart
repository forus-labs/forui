import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// The themes.
final themes = {'zinc-light': FThemes.zinc.light, 'zinc-dark': FThemes.zinc.dark};

abstract class Example extends StatelessWidget {
  final FThemeData theme;
  final Alignment alignment;
  final double maxWidth;
  final double maxHeight;
  final double top;

  Example({
    String theme = 'zinc-light',
    this.alignment = .center,
    this.maxWidth = 400,
    this.maxHeight = .infinity,
    this.top = 0,
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
    child: FToaster(
      child: FScaffold(
        child: Align(
          alignment: alignment,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            child: Padding(
              padding: .only(top: top),
              child: Builder(builder: example),
            ),
          ),
        ),
      ),
    ),
  );

  Widget example(BuildContext context);
}

abstract class StatefulExample extends StatefulWidget {
  final FThemeData theme;
  final Alignment alignment;
  final double maxWidth;
  final double maxHeight;
  final double top;

  StatefulExample({
    String theme = 'zinc-light',
    this.alignment = .center,
    this.maxWidth = 400,
    this.maxHeight = .infinity,
    this.top = 0,
    super.key,
  }) : theme = themes[theme]!;
}

abstract class StatefulExampleState<T extends StatefulExample> extends State<T> {
  @override
  Widget build(BuildContext context) => FTheme(
    data: widget.theme,
    child: FScaffold(
      child: Align(
        alignment: widget.alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth, maxHeight: widget.maxHeight),
          child: Padding(
            padding: .only(top: widget.top),
            child: Builder(builder: example),
          ),
        ),
      ),
    ),
  );

  Widget example(BuildContext context);
}
