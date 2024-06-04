import 'package:flutter/cupertino.dart';
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
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: CupertinoColors.activeBlue,
            selectionColor: CupertinoColors.activeBlue.withOpacity(0.4),
            selectionHandleColor: CupertinoColors.activeBlue,
          ),
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: CupertinoColors.activeBlue,
          ),
        ),
        home: FTheme(
          data: FThemes.zinc.light,
          child: Scaffold(
            backgroundColor: FThemes.zinc.light.colorScheme.background,
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: ExampleWidget(),
            ),
          ),
        ),
      );
}

/// The example widget.
class ExampleWidget extends StatelessWidget {
  /// Creates an example widget.
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final font = context.theme.font;
    return Center(
      child: TextField(
        // enabled: false,
        // cursorColor: CupertinoColors.activeBlue,
        style: TextStyle(
          fontFamily: font.family,
          fontSize: font.sm,
          color: context.theme.colorScheme.primary,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: 'Email',
          hintStyle: TextStyle(
            inherit: false,
            fontFamily: font.family,
            fontSize: font.sm,
            color: context.theme.colorScheme.mutedForeground, // TODO: change color dynamically when disabled
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.colorScheme.border,
              width: context.theme.style.borderWidth,
            ),
            borderRadius: context.theme.style.borderRadius,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.colorScheme.border.withOpacity(0.5),
              width: context.theme.style.borderWidth,
            ),
            borderRadius: context.theme.style.borderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.colorScheme.border,
              width: context.theme.style.borderWidth,
            ),
            borderRadius: context.theme.style.borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.colorScheme.mutedForeground,
              width: context.theme.style.borderWidth,
            ),
            borderRadius: context.theme.style.borderRadius,
          ),
        ),
      ),
    );
  }
}
