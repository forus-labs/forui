import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:forui_example/portal/visualizer.dart';
import 'package:intl/intl.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        FButton(
          onPress: () {
            Widget buildToast(BuildContext context, ToastEntry overlay) => IntrinsicHeight(
              child: FCard(
                title: Text('Event has been created'),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FButton(onPress: () => overlay.close(), child: const Text('close')),
                ),
              ),
            );

            showToast(context: context, builder: buildToast, location: ToastLocation.bottomRight);
          },
          child: Text('Small'),
        ),
        FButton(
          onPress: () {
            Widget buildToast(BuildContext context, ToastEntry overlay) => IntrinsicHeight(
              child: FCard(
                style: FThemes.zinc.dark.cardStyle,
                title: Text('Event has been created'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('This is a large card.'),
                        Text('It can span multiple lines.'),
                        Text('It can also have a lot of text.'),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                      ],
                    ),
                    FButton(
                      style: FThemes.zinc.dark.buttonStyles.primary,
                      onPress: () => overlay.close(),
                      child: const Text('close'),
                    ),
                  ],
                ),
              ),
            );

            showToast(context: context, builder: buildToast, location: ToastLocation.bottomRight);
          },
          child: Text('Large'),
        ),
      ],
    );
  }
}
