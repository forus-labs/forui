import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

Widget small(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, _) => Container(
        width: 250,
        height: 143,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.blue),
        child: Text(text),
      ),
    ),
    child: Text(text),
  ),
);

Widget big(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, _) => Container(
        width: 312,
        height: 201,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.red),
        child: Text(text),
      ),
    ),
    child: Text(text),
  ),
);

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    final cardStyle = context.theme.cardStyle.copyWith(
      contentStyle: context.theme.cardStyle.contentStyle.copyWith(
        titleTextStyle: context.theme.typography.sm.copyWith(
          color: context.theme.colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        FToast(
          icon: const Icon(FIcons.triangleAlert),
          title: const Text('Event has been created'),
          description: Text(
            'This is a more detailed description that provides comprehensive context and additional information '
            'about the notification, explaining what happened and what the user might expect next.',
          ),
          onDismiss: () {},
        ),
        FButton(
          intrinsicWidth: true,
          onPress: () {
            Widget buildToast(BuildContext context, FToasterEntry toast) => FToast(
              icon: const Icon(FIcons.triangleAlert),
              title: const Text('Event has been created'),
              description: Text(
                'This is a more detailed description that provides comprehensive context and additional information '
                'about the notification, explaining what happened and what the user might expect next.',
              ),
            );

            showRawFToast(context: context, builder: buildToast, alignment: FToastAlignment.bottomRight);
          },
          child: Text('Small'),
        ),
        FButton(
          intrinsicWidth: true,
          onPress: () {
            Widget buildToast(BuildContext context, FToasterEntry toast) => IntrinsicHeight(
              child: FCard(
                style: cardStyle,
                title: const Text('Event has been created'),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'This is a more detailed description that provides comprehensive context and additional information '
                    'about the notification, explaining what happened and what the user might expect next.',
                  ),
                ),
                child: FButton(onPress: () => toast.dismiss(), child: const Text('undo')),
              ),
            );

            showRawFToast(context: context, builder: buildToast, alignment: FToastAlignment.bottomRight);
          },
          child: Text('Large'),
        ),
      ],
    );
  }
}
