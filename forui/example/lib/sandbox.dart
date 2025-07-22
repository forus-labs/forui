import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
    return Center(
      child: FTabs(
        controller: c,
        initialIndex: 0,
        children: [
          FTabEntry(
            label: const Text('Account'),
            child: FCard(
              title: const Text('Account'),
              subtitle: const Text('Make changes to your account here. Click save when you are done.'),
              child: Container(color: Colors.blue, height: 100),
            ),
          ),
          FTabEntry(
            label: const Text('Password'),
            child: FCard(
              title: const Text('Password'),
              subtitle: const Text('Change your password here. After saving, you will be logged out.'),
              child: Container(color: Colors.red, height: 100),
            ),
          ),
        ],
      ),
    );
  }
}
