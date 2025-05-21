import 'package:flutter/material.dart';
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
      spacing: 5,
      children: [
        FButton(
          onPress: () {
            Widget buildToast(BuildContext context, FToast toast) =>
                IntrinsicHeight(
                  child: FCard(
                    title: Text('Event has been created'),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FButton(onPress: () => toast.dismiss(), child: const Text('close')),
                    ),
                  ),
                );

            showFToast(context: context, builder: buildToast, alignment: FSonnerAlignment.bottomRight, duration: const Duration(minutes: 1));
          },
          child: Text('Small'),
        ),
        FButton(
          onPress: () {
            Widget buildToast(BuildContext context, FToast toast) =>
                IntrinsicHeight(
                  child: FCard(
                    style: FThemes.zinc.dark.cardStyle,
                    title: Text('Event has been created'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('This is a large card.'),
                            Text('It can span multiple lines.'),
                            Text('It can also have a lot of text.'),
                            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                          ],
                        ),
                        FButton(
                          style: FThemes.zinc.dark.buttonStyles.primary,
                          onPress: () => toast.dismiss(),
                          child: const Text('close'),
                        ),
                      ],
                    ),
                  ),
                );

            showFToast(context: context, builder: buildToast, alignment: FSonnerAlignment.bottomRight, duration: const Duration(minutes: 1));
          },
          child: Text('Large'),
        ),
      ],
    );
  }
}
