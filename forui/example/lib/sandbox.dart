import 'dart:math';

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

enum Notification { all, direct, nothing }

// change to text widgets.
const a = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late FTimePickerController timeController = FTimePickerController();
  late FPaginationController pageController = FPaginationController(length: 10, siblings: 0);

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      SizedBox(height: 300, width: 300, child: FTimePicker(controller: timeController, hourInterval: 7)),
      FButton(
        label: const Text('Funny button'),
        onPress: () => timeController.animateTo(FTime(Random().nextInt(24), Random().nextInt(61))),
      ),
      const SizedBox(height: 100),

      SizedBox(
        height: 300,
        width: 300,
        child: PageView.builder(
          itemCount: 10,
          controller: pageController,
          itemBuilder:
              (context, index) => ColoredBox(
                color: index.isEven ? Colors.red : Colors.blue,
                child: Center(child: Text('Page $index', style: const TextStyle(fontSize: 45, color: Colors.white))),
              ),
        ),
      ),
      SizedBox(height: 200, child: FPagination(controller: pageController)),
    ],
  );

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }
}
