import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:forui_example/sandbox.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();

  runApp(const Application());
}

const List<Widget> _pages = [Text('Home'), Text('Categories'), Text('Search'), Text('Settings'), Sandbox()];

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
    theme: FThemes.zinc.light.toMaterialTheme(),
    builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
    home: Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: _pages[index],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        selectedIndex: index,
        destinations: [
          const NavigationDestination(selectedIcon: Icon(Icons.home), icon: Icon(Icons.home_outlined), label: 'Home'),
          const NavigationDestination(
            selectedIcon: Icon(Icons.grid_view),
            icon: Icon(Icons.grid_view_outlined),
            label: 'Categories',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
          NavigationDestination(
            selectedIcon: Badge.count(count: 10, child: const Icon(Icons.castle)),
            icon: Badge.count(count: 10, child: const Icon(Icons.castle_outlined)),
            label: 'Sandbox',
          ),
        ],
      ),
    ),
  );
}
