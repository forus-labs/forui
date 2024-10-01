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
  Sandbox(),
];

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int index = 4;

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, child) => FTheme(
          data: FThemes.zinc.light,
          child: child!,
        ),
        home: FScaffold(
          header: FHeader(
            title: const Text('Example'),
            actions: [
              FHeaderAction(
                icon: FAssets.icons.plus,
                onPress: () {},
              ),
            ],
          ),
          content: _pages[index],
          footer: FBottomNavigationBar(
            index: index,
            onChange: (index) => setState(() => this.index = index),
            children: [
              FBottomNavigationBarItem(
                icon: FAssets.icons.home,
                label: const Text('Home'),
              ),
              FBottomNavigationBarItem(
                icon: FAssets.icons.layoutGrid,
                label: const Text('Categories'),
              ),
              FBottomNavigationBarItem(
                icon: FAssets.icons.search,
                label: const Text('Search'),
              ),
              FBottomNavigationBarItem(
                icon: FAssets.icons.settings,
                label: const Text('Settings'),
              ),
              FBottomNavigationBarItem(
                icon: FAssets.icons.castle,
                label: const Text('Sandbox'),
              ),
            ],
          ),
        ),
      );
}
