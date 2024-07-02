import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: FTabs(
              tabs: [
                FTabEntry(
                  label: const Text('Account'),
                  content: FCard(
                    title: const Text('Account'),
                    subtitle: const Text('Make changes to your account here. Click save when you are done.'),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.red,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                FTabEntry(
                  label: const Text('Password'),
                  content: FCard(
                    title: const Text('Password'),
                    subtitle: const Text('Change your password here. After saving, you will be logged out.'),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue,
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
