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
  var _v = FSliderValue(max: 0.35);

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        FSlider(
          control: .liftedDiscrete(
            value: _v,
            onChange: (v) {
              setState(() {
                _v = v;
              });
            },
          ),
          label: const Text('Brightness'),
          description: const Text('Adjust the brightness level.'),
          marks: const [
            .mark(value: 0, label: Text('0%')),
            .mark(value: 0.25, tick: false),
            .mark(value: 0.5, label: Text('50%')),
            .mark(value: 0.75, tick: false),
            .mark(value: 1, label: Text('100%')),
          ],
        ),
      ],
    ),
  );
}
