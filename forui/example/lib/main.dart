import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:forui_example/sandbox.dart';

void main() {
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
  int index = 0;

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, child) => FTheme(
          data: FThemes.zinc.dark,
          child: FScaffold(
            header: FHeader(
              title: const Text('Example'),
              actions: [
                FHeaderAction(
                  icon: FAssets.icons.plus,
                  onPress: () {},
                ),
              ],
            ),
            content: child!,
            footer: FBottomNavigationBar(
              index: index,
              onChange: (index) => setState(() => this.index = index),
              children: [
                FBottomNavigationBarItem(
                  icon: FAssets.icons.home,
                  label: 'Home',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.layoutGrid,
                  label: 'Categories',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.search,
                  label: 'Search',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.settings,
                  label: 'Settings',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.castle,
                  label: 'Sandbox',
                ),
              ],
            ),
          ),
        ),
        home: _pages[index],
      );
}
