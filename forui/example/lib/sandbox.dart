import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool switchValue = false;
  double sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return const FTextField(
      label: Text('Forui TextField'),
      hint: 'Enter text here',
    );

    // return ListView(
    //   children: [
    //     // Material Widgets Section
    //     const Text(
    //       'Material Widgets',
    //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //     ),
    //     const SizedBox(height: 16),

    //     // Buttons
    //     Wrap(
    //       spacing: 8,
    //       children: [
    //         ElevatedButton(
    //           onPressed: () {},
    //           child: const Text('Elevated Button'),
    //         ),
    //         FilledButton(
    //           onPressed: () {},
    //           child: const Text('Filled Button'),
    //         ),
    //         OutlinedButton(
    //           onPressed: () {},
    //           child: const Text('Outlined Button'),
    //         ),
    //         TextButton(
    //           onPressed: () {},
    //           child: const Text('Text Button'),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 16),

    //     // Input Fields
    //     const TextField(
    //       decoration: InputDecoration(
    //         labelText: 'Material TextField',
    //         hintText: 'Enter text here',
    //       ),
    //     ),
    //     const SizedBox(height: 16),

    //     // Cards
    //     Card(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const Text('Material Card'),
    //             const SizedBox(height: 8),
    //             const Text('This is content inside a Material card'),
    //             const SizedBox(height: 8),
    //             Row(
    //               children: [
    //                 TextButton(
    //                   onPressed: () {},
    //                   child: const Text('Action 1'),
    //                 ),
    //                 TextButton(
    //                   onPressed: () {},
    //                   child: const Text('Action 2'),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 16),

    //     // Selection Controls
    //     Row(
    //       children: [
    //         Switch(
    //           value: switchValue,
    //           onChanged: (value) => setState(() => switchValue = value),
    //         ),
    //         const SizedBox(width: 16),
    //         Checkbox(
    //           value: switchValue,
    //           onChanged: (value) => setState(() => switchValue = value ?? false),
    //         ),
    //         const SizedBox(width: 16),
    //         Radio(
    //           value: true,
    //           groupValue: switchValue,
    //           onChanged: (value) => setState(() => switchValue = value ?? false),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 16),

    //     // Slider
    //     Slider(
    //       value: sliderValue,
    //       onChanged: (value) => setState(() => sliderValue = value),
    //     ),
    //     const SizedBox(height: 32),

    //     // Forui Widgets Section
    //     const Text('Forui Widgets', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    //     const SizedBox(height: 16),

    //     // Forui Button
    //     FButton(
    //       label: const Text('Forui Button'),
    //       onPress: () {},
    //     ),
    //     const SizedBox(height: 16),

    //     // Forui TextField
    //     // const FTextField(
    //     //   label: Text('Forui TextField'),
    //     //   hint: 'Enter text here',
    //     // ),
    //     // const SizedBox(height: 16),

    //     // Forui Card
    //     FCard(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const Text('Forui Card'),
    //           const SizedBox(height: 8),
    //           const Text('This is content inside a Forui card'),
    //           const SizedBox(height: 8),
    //           Row(
    //             children: [
    //               FButton(
    //                 label: const Text('Action 1'),
    //                 onPress: () {},
    //               ),
    //               const SizedBox(width: 8),
    //               FButton(
    //                 label: const Text('Action 2'),
    //                 onPress: () {},
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
