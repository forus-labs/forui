import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class LocaleScaffold extends StatefulWidget {
  final List<Locale> locales;
  final Widget child;

  const LocaleScaffold({required this.child, this.locales = const [Locale('en', 'US'), Locale('ko')], super.key});

  @override
  State<LocaleScaffold> createState() => _LocaleScaffoldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('locales', locales));
  }
}

class _LocaleScaffoldState extends State<LocaleScaffold> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    mainAxisAlignment: .center,
    spacing: 10,
    children: [
      Localizations.override(
        context: context,
        locale: widget.locales[index % widget.locales.length],
        child: widget.child,
      ),
      FButton(onPress: () => setState(() => index++), child: const Text('change')),
    ],
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('index', index));
  }
}
