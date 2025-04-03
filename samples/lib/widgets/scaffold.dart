import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ScaffoldPage extends StatefulSample {
  ScaffoldPage({@queryParam super.theme});

  @override
  State<ScaffoldPage> createState() => _State();
}

class _State extends StatefulSampleState<ScaffoldPage> {
  int index = 3;

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 500,
        child: FScaffold(
          header: headers[index],
          footer: FBottomNavigationBar(
            index: index,
            onChange: (index) => setState(() => this.index = index),
            children: const [
              FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
              FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Categories')),
              FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('Search')),
              FBottomNavigationBarItem(icon: Icon(FIcons.settings), label: Text('Settings')),
            ],
          ),
          child: contents[index],
        ),
      ),
    ],
  );
}

final headers = [
  const FHeader(title: Text('Home')),
  const FHeader(title: Text('Categories')),
  const FHeader(title: Text('Search')),
  FHeader(title: const Text('Settings'), suffixes: [FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: () {})]),
];

final contents = [
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Home Placeholder')]),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Categories Placeholder')]),
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Search Placeholder')]),
  Column(
    children: [
      const SizedBox(height: 5),
      FCard(
        title: const Text('Account'),
        subtitle: const Text('Make changes to your account here. Click save when you are done.'),
        child: Column(
          children: [
            const FTextField(label: Text('Name'), hint: 'John Renalo'),
            const SizedBox(height: 10),
            const FTextField(label: Text('Email'), hint: 'john@doe.com'),
            const SizedBox(height: 16),
            FButton(child: const Text('Save'), onPress: () {}),
          ],
        ),
      ),
    ],
  ),
];
