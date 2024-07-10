import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:sugar/sugar.dart';

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
            content: child ?? const SizedBox(),
          ),
        ),
        home: Column(
          children: [
            const Testing(),
            // FHeaderAction(
            //   icon: FAssets.icons.plus,
            //   onPress: () => showDatePicker(context: context, firstDate: DateTime(2024, 7, 1), lastDate: DateTime(2024, 7, 31), initialDate: DateTime(2024, 7, 8)),
            // ),
          ],
        ),
      );
}

class Testing extends StatelessWidget {

  static final _selected = { LocalDate(2024, 7, 16), LocalDate(2024, 7, 17), LocalDate(2024, 7, 18),  LocalDate(2024, 7, 29)};

  const Testing({super.key});

  @override
  Widget build(BuildContext context) => Calendar(
      style: FCalendarStyle.inherit(colorScheme: context.theme.colorScheme, typography: context.theme.typography, style: context.theme.style),
      start: LocalDate(1900, 1, 8),
      end: LocalDate(2024, 7, 10),
      today: LocalDate.now(),
      initialMonth: LocalDate(2024, 7),
      enabledPredicate: (_) => true,
      selectedPredicate: _selected.contains,
      onMonthChange: print,
      onPress: print,
      onLongPress: print,
    );
}
