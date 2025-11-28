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
  TextEditingValue _v = TextEditingValue(text: 'Banana');

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        FTextField(
          control: .lifted(value: _v, onChange: (v) => setState(() => _v = v)),
        ),
      ],
    ),
  );
}

class FDefaultTextEditingController extends StatefulWidget {
  final TextEditingValue value;
  final ValueChanged<TextEditingValue> onChange;
  final ValueWidgetBuilder<TextEditingController> builder;

  const FDefaultTextEditingController({required this.value, required this.onChange, required this.builder, super.key});

  @override
  State<FDefaultTextEditingController> createState() => _FDefaultTextEditingControllerState();
}

class _FDefaultTextEditingControllerState extends State<FDefaultTextEditingController> {
  late final _controller = _Controller(widget.value, onChange: widget.onChange);

  @override
  void didUpdateWidget(covariant FDefaultTextEditingController old) {
    super.didUpdateWidget(old);
    print('didUpdateWidget');
    print('old: ${old.value}');
    print('new: ${widget.value}');
    if (widget.value != old.value) {
      _controller._set(widget.value);
    }

    if (widget.onChange != old.onChange) {
      _controller.onChange = widget.onChange;
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller, null);
}

class _Controller extends TextEditingController {
  ValueChanged<TextEditingValue> onChange;

  _Controller(super.value, {required this.onChange}) : super.fromValue();

  void _set(TextEditingValue newValue) {
    super.value = newValue;
  }

  @override
  set value(TextEditingValue newValue) {
    if (newValue == super.value) {
      return;
    }
    onChange(newValue);
  }
}
