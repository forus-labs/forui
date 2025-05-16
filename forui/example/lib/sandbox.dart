import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  int a = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FButton(
          onPress: () {
            final i = a++;
            Widget buildToast(BuildContext context, ToastOverlay overlay) => FCard(
              title: Text('Event has been created: $i'),
              subtitle: FButton(onPress: () => overlay.close(), child: const Text('close')),
            );

            showToast(context: context, builder: buildToast, location: ToastLocation.bottomRight);
          },
          child: Text('Small'),
        ),
        FButton(
          onPress: () {
            final i = a++;
            Widget buildToast(BuildContext context, ToastOverlay overlay) =>
                Container(width: 500, height: 150, color: Colors.blue);

            showToast(context: context, builder: buildToast, location: ToastLocation.bottomRight);
          },
          child: Text('Large'),
        ),
      ],
    );
  }

  Widget buildToast(BuildContext context, ToastOverlay overlay) => FCard(
    title: Text('Event has been created: $a'),
    subtitle: FButton(onPress: () => overlay.close(), child: const Text('close')),
  );
}
