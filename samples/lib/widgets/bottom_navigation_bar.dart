import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class BottomNavigationBarPage extends SampleScaffold {
  BottomNavigationBarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
        padding: EdgeInsets.all(15.0),
        child: _Demo(),
      );
}

class _Demo extends StatefulWidget {
  const _Demo();

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  int index = 1;

  @override
  Widget build(BuildContext context) => FBottomNavigationBar(
        index: index,
        onChange: (index) => setState(() => this.index = index),
        children: [
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.home),
            label: const Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.layoutGrid),
            label: const Text('Browse'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.radio),
            label: const Text('Radio'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.libraryBig),
            label: const Text('Library'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.search),
            label: const Text('Search'),
          ),
        ],
      );
}
