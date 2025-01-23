import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

@internal
class PickerData extends InheritedWidget {
  static PickerData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<PickerData>();

  final FPickerStyle style;

  /// Creates a [PickerData].
  const PickerData({
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(PickerData old) => style != old.style;
}