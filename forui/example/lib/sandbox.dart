import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

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

  String? _a;
  TextEditingValue? _b;
  List<int> value = [9];

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      children: [
        Expanded(
          child: FPicker(
            control: .lifted(
              value: value,
              onChange: (v) {
                // setState(() {
                //   // value = v;
                //   print('setState');
                // });
              },
            ),
            children: [
              if (true)
                FPickerWheel.builder(builder: (context, index) => Text('$index'))
              else
                FPickerWheel(
                  loop: false,
                  children: const [
                    Text('January'),
                    Text('February'),
                    Text('March'),
                    Text('April'),
                    Text('May'),
                    Text('June'),
                    Text('July'),
                    Text('August'),
                    Text('September'),
                    Text('October'),
                    Text('November'),
                    Text('December'),
                  ],
                ),
            ],
          ),
        ),
        FButton(
          onPress: () => setState(() {
            value = [5];
            print('setState outer');
          }),
          child: Text('button'),
        ),
      ],
    ),
  );
}
