import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Box extends StatelessWidget {

  static List<(String, FThemeData, Color)> get themes => [
    ('zinc-light', FThemes.zinc.light, const Color(0xFFD5FFFF)),
    ('zinc-dark', FThemes.zinc.dark, const Color(0xFF104963)),
  ];

  final FThemeData data;
  final Color? background;
  final Widget child;

  const Box({required this.data, required this.child, this.background, super.key});

  @override
  Widget build(BuildContext context) => FTheme(
    data: data,
    textDirection: TextDirection.ltr,
    child: Container(
      // We use a fixed background color to ensure that widgets set their background properly.
      color: background ?? data.colorScheme.background,
      alignment: Alignment.center,
      child: child,
    ),
  );
}
