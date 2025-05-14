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
  Sandbox(),
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
    home: FScaffold(
      header: const FHeader(title: Text('Example')),
      sidebar: Container(decoration: const BoxDecoration(color: Colors.blue), width: 200),
      footer: FBottomNavigationBar(
        index: index,
        onChange: (index) => setState(() => this.index = index),
        children: const [
          FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
          FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Categories')),
          FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('Search')),
          FBottomNavigationBarItem(icon: Icon(FIcons.settings), label: Text('Settings')),
          FBottomNavigationBarItem(icon: Icon(FIcons.castle), label: Text('Sandbox')),
        ],
      ),
      child: _pages[index],
    ),
  );
}
