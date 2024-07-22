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
          const SizedBox(height: 100),
          FProgress(value: 0.9),
          const SizedBox(height: 10),
          const FAvatar(
            child: Text('DC'),
            //backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
            child: Text('DC'),
          ),
        ],
      );
}
