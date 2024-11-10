import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

enum Notification { all, direct, nothing }

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FRadioSelectGroupController<Notification> controller = FRadioSelectGroupController();
  late FPopoverController popoverController;

  @override
  void initState() {
    super.initState();
    popoverController = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FSelectMenuTile(
              groupController: controller,
              popoverController: popoverController,
              autoHide: true,
              validator: (value) => value == null ? 'Select an item' : null,
              prefixIcon: FIcon(FAssets.icons.bell),
              title: const Text('Notifications'),
              details: ListenableBuilder(
                listenable: controller,
                builder: (context, _) => Text(switch (controller.values.firstOrNull) {
                  Notification.all => 'All',
                  Notification.direct => 'Direct Messages',
                  null || Notification.nothing => 'None',
                }),
              ),
              menu: [
                FSelectTile(title: const Text('All'), value: Notification.all),
                FSelectTile(title: const Text('Direct Messages'), value: Notification.direct),
                FSelectTile(title: const Text('None'), value: Notification.nothing),
              ],
            ),
            const SizedBox(height: 20),
            FButton(
              autofocus: true,
              label: const Text('Save'),
              onPress: () {
                if (!_formKey.currentState!.validate()) {
                  // Handle errors here.
                  return;
                }

                _formKey.currentState!.save();
                // Do something.
              },
            )
          ],
        ),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
