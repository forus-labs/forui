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
          children: const [
            FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
            FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Categories')),
            FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('Search')),
            FBottomNavigationBarItem(icon: Icon(FIcons.settings), label: Text('Settings')),
            FBottomNavigationBarItem(icon: Icon(FIcons.castle), label: Text('Sandbox')),
          ],
        ),
      ),
    ),
  );
}
