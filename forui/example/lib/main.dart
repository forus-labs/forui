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
        builder: (context, child) => FTheme(
          data: FThemes.zinc.dark,
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
            content: child ?? const SizedBox(),
          ),
        ),
        home: const Testing(),
      );
}

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) => EnabledDay(
        style: FDayStateStyle(
          decoration: BoxDecoration(
            borderRadius: context.theme.style.borderRadius,
            color: context.theme.colorScheme.border,
          ),
          textStyle: context.theme.typography.base,
        ),
        date: DateTime.now(),
        onPress: print,
        today: true,
        selected: true,
      );
}
