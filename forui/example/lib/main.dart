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

class _ApplicationState extends State<Application>
    with SingleTickerProviderStateMixin {
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
    builder: (context, child) =>
        FTheme(data: FThemes.zinc.light, child: child!),
    home: FScaffold(
      header: const FHeader(title: Text('Example')),
      sidebar: FSidebar(
        children: [
          FSidebarGroup(
            label: const Text('Navigation Navigation Navigation Navigation'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(
                icon: const Icon(FIcons.house),
                label: const Text('Home'),
                selected: true,
                onPress: () {},
                children: [
                  FSidebarItem(
                    icon: const Icon(FIcons.settings),
                    label: const Text('Generalasdasdasdasdsaasdas'),
                    onPress: () {},
                  ),
                  FSidebarItem(icon: const Icon(FIcons.user), label: const Text('Profile'), onPress: () {}),
                  FSidebarItem(icon: const Icon(FIcons.bell), label: const Text('Notifications'), onPress: () {}),
                ],
              ),
              FSidebarItem(
                icon: const Icon(FIcons.layoutGrid),
                label: const Text('Categories'),
                initiallyExpanded: true,
                onPress: () {},
                children: [
                  FSidebarItem(
                    label: const Text('Some super looooong option'),
                    onPress: () {},
                    children: [
                      FSidebarItem(label: const Text('Profile'), onPress: () {}),
                      FSidebarItem(label: const Text('Notifications'), onPress: () {}),
                    ],
                  ),
                  FSidebarItem(label: const Text('Profile'), onPress: () {}),
                  FSidebarItem(label: const Text('Notifications'), onPress: () {}),
                ],
              ),
              FSidebarItem(icon: const Icon(FIcons.search), label: const Text('Search'), onPress: () {}),
            ],
          ),
          FSidebarGroup(
            label: const Text('Settings'),
            children: [
              FSidebarItem(
                icon: const Icon(FIcons.settings),
                label: const Text('Generalasdasdasdasdsaasdas'),
                onPress: () {},
              ),
              FSidebarItem(icon: const Icon(FIcons.user), label: const Text('Profile')),
              FSidebarItem(
                icon: const Icon(FIcons.bell),
                label: const Text('Notifications'),
                onPress: () {},
              ),
            ],
          ),
          FSidebarGroup(
            children: [
              FSidebarItem(icon: const Icon(FIcons.info), label: const Text('Help Center'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.mail), label: const Text('Contact Us'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Documentation')),
            ],
          ),
        ],
      ),
      footer: FBottomNavigationBar(
        index: index,
        onChange: (index) => setState(() => this.index = index),
        children: const [
          FBottomNavigationBarItem(
            icon: Icon(FIcons.house),
            label: Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.layoutGrid),
            label: Text('Categories'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.search),
            label: Text('Search'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.settings),
            label: Text('Settings'),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.castle),
            label: Text('Sandbox'),
          ),
        ],
      ),
      child: _pages[index],
    ),
  );
}
