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
  static final _selected = {DateTime(2024, 7, 16), DateTime(2024, 7, 17), DateTime(2024, 7, 18), DateTime(2024, 7, 29)};

  const Testing({super.key});

  @override
  Widget build(BuildContext context) => FCalendar(
        start: DateTime(1900, 1, 8),
        end: DateTime(2024, 7, 10),
        controller: FCalendarMultiValueController(),
      );
}
