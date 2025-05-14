import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FButton(
          onPress: () {
            showToast(context: context, builder: buildToast, location: ToastLocation.topLeft);
          },
          child: Text('TL'),
        ),
        FButton(
          onPress: () {
            showToast(context: context, builder: buildToast, location: ToastLocation.topRight);
          },
          child: Text('TR'),
        ),
        FButton(
          onPress: () {
            showToast(context: context, builder: buildToast, location: ToastLocation.topCenter);
          },
          child: Text('TC'),
        ),
        FButton(
          onPress: () {
            showToast(context: context, builder: buildToast, location: ToastLocation.bottomLeft);
          },
          child: Text('BL'),
        ),
        FButton(
          onPress: () {
            showToast(context: context, builder: buildToast, location: ToastLocation.bottomRight);
          },
          child: Text('BR'),
        ),
      ],
    );
  }

  Widget buildToast(BuildContext context, ToastOverlay overlay) => FCard(
    title: Text('Event has been created'),
    subtitle: FButton(onPress: () => print('hi'), child: const Text('close')),
  );
}
