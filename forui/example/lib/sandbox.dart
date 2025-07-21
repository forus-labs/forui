import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FAccordionController c;

  @override
  void initState() {
    super.initState();
    c = FAccordionController(min :-1, max: -1);
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FAccordion(
        controller: c,
        children: const [
          FAccordionItem(
            title: Text('Is it accessible?'),
            child: Text('Yes. It adheres to the WAI-ARIA design pattern.'),
          ),
          FAccordionItem(
            initiallyExpanded: true,
            title: Text('Is it Styled?'),
            child: Text("Yes. It comes with default styles that matches the other components' aesthetics"),
          ),
          FAccordionItem(
            title: Text('Is it Animated?'),
            child: Text('Yes. It is animated by default, but you can disable it if you prefer'),
          ),
        ],
      ),
    );
  }
}
