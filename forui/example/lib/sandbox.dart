import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        FTimeField(),
        FDateField(
          style: (style) => style.copyWith(
            fieldStyle: (fieldStyle) => fieldStyle.copyWith(
              contentTextStyle: fieldStyle.contentTextStyle
                  .replaceFirstWhere(
                    {WidgetState.focused},
                    (style) => style.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                  )
                  .replaceLastWhere({}, (style) => style.copyWith(color: Colors.blue)),
              // Modify the border based on widget state
              border: FWidgetStateMap({
                WidgetState.focused: fieldStyle.border.resolve({WidgetState.focused}).copyWith(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                WidgetState.any: fieldStyle.border.resolve({}),
              }),
            ),
          ),
        ),
        FAutocomplete(items: fruits),
        FSelect<String>(items: {for (final fruit in fruits) fruit: fruit}),
        FMultiSelect<String>(items: {for (final fruit in fruits) fruit: fruit}),
        FTextField.password(),
        FTextField(
          suffixBuilder: (_, style, states) => IconTheme(
            data: style.clearButtonStyle.iconContentStyle.iconStyle.resolve(states),
            child: Icon(Icons.search),
          ),
        ),
      ],
    ),
  );
}
