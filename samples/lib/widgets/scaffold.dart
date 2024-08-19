import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class ScaffoldPage extends SampleScaffold {
  ScaffoldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            child: _Demo(),
          ),
        ],
      );
}

final headers = [
  const FHeader(title: Text('Home')),
  const FHeader(title: Text('Categories')),
  const FHeader(title: Text('Search')),
  FHeader(
    title: const Text('Settings'),
    actions: [
      FHeaderAction(
        icon: FAssets.icons.ellipsis,
        onPress: () {},
      ),
    ],
  ),
];

final contents = [
  const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text('Home Placeholder')],
  ),
  const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text('Categories Placeholder')],
  ),
  const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text('Search Placeholder')],
  ),
  Column(
    children: [
      const SizedBox(height: 5),
      FCard(
        title: const Text('Account'),
        subtitle: const Text('Make changes to your account here. Click save when you are done.'),
        child: Column(
          children: [
            const FTextField(
              label: Text('Name'),
              hint: 'John Renalo',
            ),
            const SizedBox(height: 10),
            const FTextField(
              label: Text('Email'),
              hint: 'john@doe.com',
            ),
            const SizedBox(height: 16),
            FButton(
              label: const Text('Save'),
              onPress: () {},
            ),
          ],
        ),
      ),
    ],
  ),
];

class _Demo extends StatefulWidget {
  const _Demo();

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  int index = 3;

  @override
  Widget build(BuildContext context) => FScaffold(
        header: headers[index],
        content: contents[index],
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
          ],
        ),
      );
}
