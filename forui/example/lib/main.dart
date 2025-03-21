import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:forui_example/sandbox.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();

  runApp(const Application());
}

const List<Widget> _pages = [
  Text('Home'),
  Text('Categories'),
  Text('Search'),
  Text('Settings'),
  Sandbox(key: PageStorageKey<String>('Sandbox')),
];

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with SingleTickerProviderStateMixin {
  int index = 4;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en', 'US'),
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
    home: PageStorage(
      bucket: _bucket,
      child: FScaffold(
        header: const FHeader(title: Text('Example')),
        content: _pages[index],
        footer: FBottomNavigationBar(
          index: index,
          onChange: (index) => setState(() => this.index = index),
          children: [
            FBottomNavigationBarItem(icon: FIcon(FAssets.icons.house), label: const Text('Home')),
            FBottomNavigationBarItem(icon: FIcon(FAssets.icons.layoutGrid), label: const Text('Categories')),
            FBottomNavigationBarItem(icon: FIcon(FAssets.icons.search), label: const Text('Search')),
            FBottomNavigationBarItem(icon: FIcon(FAssets.icons.settings), label: const Text('Settings')),
            FBottomNavigationBarItem(icon: FIcon(FAssets.icons.castle), label: const Text('Sandbox')),
          ],
        ),
      ),
    ),
  );
}
