import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FTabController c;

  @override
  void initState() {
    super.initState();
    c = FTabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: const FProgress.circularIcon());
  }
}
