import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FTabController c;
  final controller = ValueNotifier<bool>(false);
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    c = FTabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  void dispose() {
    c.dispose();
    controller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        for (final (alignment, description) in [
          (FToastAlignment.topLeft, 'Top Left'),
          (FToastAlignment.topCenter, 'Top Center'),
          (FToastAlignment.topRight, 'Top Right'),
          (FToastAlignment.bottomLeft, 'Bottom Left'),
          (FToastAlignment.bottomCenter, 'Bottom Center'),
          (FToastAlignment.bottomRight, 'Bottom Right'),
        ])
          FButton(
            onPress: () => showFToast(
              context: context,
              alignment: alignment,
              title: const Text('Event has been created'),
              description: const Text('Friday, May 23, 2025 at 9:00 AM'),
              suffixBuilder: (context, entry) => IntrinsicHeight(
                child: FButton(
                  style: context.theme.buttonStyles.primary.copyWith(
                    contentStyle: context.theme.buttonStyles.primary.contentStyle.copyWith(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
                      textStyle: FWidgetStateMap.all(
                        context.theme.typography.xs.copyWith(color: context.theme.colors.primaryForeground),
                      ),
                    ),
                  ),
                  onPress: entry.dismiss,
                  child: const Text('Undo'),
                ),
              ),
            ),
            child: Text('Show $description Toast'),
          ),
      ],
    ),
  );
}
