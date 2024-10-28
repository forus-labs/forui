import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing }

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FMultiSelectGroupController<int> selectGroupController = FMultiSelectGroupController(min: 2);
  FAccordionController controller = FAccordionController(min: 1, max: 3);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FSelectTileGroup<int>(
        controller: selectGroupController,
        autovalidateMode: AutovalidateMode.always,
        validator: (values) => values?.isEmpty ?? true ? 'error message' : null,
        children: [
          FSelectTile.suffix(
            title: const Text('1'),
            value: 1,
          ),
          FSelectTile.suffix(
            title: const Text('2'),
            value: 2,
          ),
        ],
      );
}
