import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  bool value = false;
  FRadioSelectGroupController<String> selectGroupController = FRadioSelectGroupController();
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          children: [
            FSelectMenuTile(
              groupController: selectGroupController,
              autoHide: true,
              validator: (value) => value == null ? 'Select an item' : null,
              menu: [
                FSelectTile(title: const Text('Item 1'), value: '1'),
                FSelectTile(title: const Text('Item 2'), value: '2'),
                FSelectTile(title: const Text('Item 3'), value: '3'),
                FSelectTile(title: const Text('None'), value: 'None'),
              ],
              title: const Text('Repeat'),
              details: ListenableBuilder(
                listenable: selectGroupController,
                builder: (context, _) => Text(
                    (selectGroupController.values.isEmpty || selectGroupController.values.first == 'None')
                        ? 'None'
                        : 'Item ${selectGroupController.values.first}'),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    controller.dispose();
    selectGroupController.dispose();
    super.dispose();
  }
}
