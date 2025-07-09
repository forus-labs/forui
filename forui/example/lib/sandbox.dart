import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        spacing: 10,
        children: [
          TextField(),
          FSelect.fromMap(const {
            'Option 1': '1',
            'Option 2': '2',
            'Option 3': '3',
            'Option 4': '4',
            'Option 5': '5',
            'Option 6': '6',
            'Option 7': '7',
            'Option 8': '8',
            'Option 9': '9',
            'Option 10': '10',
            'Option 11': '11',
            'Option 12': '12',
            'Option 13': '13',
            'Option 14': '14',
            'Option 15': '15',
            'Option 16': '16',
            'Option 17': '17',
            'Option 18': '18',
            'Option 19': '19',
            'Option 20': '20',
          },
          ),
          TextField(),
        ],
      ),
    );
  }
}
