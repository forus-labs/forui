import 'package:flutter/material.dart';
import 'package:forui/src/theme_data.dart';

class FTheme extends StatefulWidget {
  static FThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return theme?.data ?? const FThemeData.light();
  }

  final FThemeData data;
  final Widget child;

  const FTheme({
    super.key,
    required this.data,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<FTheme> {
  late FThemeData data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) => _InheritedTheme(data: data, child: widget.child);
}

class _InheritedTheme extends InheritedWidget {
  final FThemeData data;

  const _InheritedTheme({required this.data, required super.child});

  @override
  bool updateShouldNotify(covariant _InheritedTheme old) => data != old.data;
}
