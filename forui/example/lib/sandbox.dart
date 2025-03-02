import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}


class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late FTimePickerController timeController = FTimePickerController();
  late Locale locale = const Locale('en', 'US');

  @override
  Widget build(BuildContext context) {
    final _ = DateTime(1970, 1, 1, 13, 30);
    return const LocaleScaffold(child: FTimeField.picker());
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }
}

class LocaleScaffold extends StatefulWidget {
  final List<Locale> locales;
  final Widget child;

  const LocaleScaffold({required this.child, this.locales = const [Locale('en', 'US'), Locale('ko')]});

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
  late FPaginationController pageController = FPaginationController(length: 10);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      Localizations.override(
        context: context,
        locale: widget.locales[index % widget.locales.length],
        child: widget.child,
      ),
      FButton(onPress: () => setState(() => index++), label: const Text('Change Locale')),

      SizedBox(
        height: 300,
        width: 300,
        child: PageView.builder(
          itemCount: 10,
          controller: pageController,
          itemBuilder:
              (context, index) => ColoredBox(
                color: index.isEven ? Colors.red : Colors.blue,
                child: Center(child: Text('Page $index', style: const TextStyle(fontSize: 45, color: Colors.white))),
              ),
        ),
      ),
      SizedBox(height: 200, child: FPagination(controller: pageController)),
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
