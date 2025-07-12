import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

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
    return Center(child: FSelect<String>(
      divider: FItemDivider.full,
      format: (s) => s,
      children: [
        FSelectSection.fromMap(
          label: const Text('Group 1'),
          divider: FItemDivider.indented,
          items: {
            for (final item in ['1A', '1B']) item: item,
          },
        ),
        FSelectSection.fromMap(
          label: const Text('Group 2'),
          items: {
            for (final item in ['2A', '2B']) item: item,
          },
        ),
        FSelectItem('Item 3', 'Item 3'),
        FSelectItem('Item 4', 'Item 4'),
      ],
    ));
  }
}
