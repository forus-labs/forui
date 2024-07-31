import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:forui_example/example.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int index = 1;

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, child) => FTheme(
          data: FThemes.zinc.light,
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
              items: [
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
              ],
            ),
          ),
        ),
        home: const Example(),
      );
}
