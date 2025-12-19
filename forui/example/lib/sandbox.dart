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
      spacing: 5,
      mainAxisSize: .min,
      children: [
        FLineCalendar(control: .managed(initial: .now().subtract(const Duration(days: 1)), selectable: (d) => d.day != 18)),
        FCalendar(control: .managedDate(initial: DateTime(2025, 12, 18), selectable: (d) => d.day != 18)),
      ],
    ),
  );
}
