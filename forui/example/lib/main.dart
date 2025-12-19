import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui_example/sandbox.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();

  runApp(const Application());
}

List<Widget> _pages = [
  const Text('Home'),
  const Text('Categories'),
  const Text('Search'),
  const Text('Settings'),
  const Sandbox(),
];

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with SingleTickerProviderStateMixin {
  int index = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en', 'US'),
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    theme: FThemes.zinc.light.toApproximateMaterialTheme(),
    builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
    home: Builder(
      builder: (context) {
        return FScaffold(
          header: const FHeader(title: Text('Example (B)')),
          footer: FBottomNavigationBar(
            index: index,
            onChange: (index) => setState(() => this.index = index),
            children: const [
              FBottomNavigationBarItem(icon: Icon(FIcons.house)),
              FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid)),
              FBottomNavigationBarItem(icon: Icon(FIcons.search)),
              FBottomNavigationBarItem(icon: Icon(FIcons.settings)),
              FBottomNavigationBarItem(icon: Icon(FIcons.castle)),
            ],
          ),
          child: _pages[index],
        );
      },
    ),
  );
}
