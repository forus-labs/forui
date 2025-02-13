import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class BottomNavigationBarPage extends StatefulSample {
  BottomNavigationBarPage({@queryParam super.theme});

  @override
  State<BottomNavigationBarPage> createState() => _State();
}

class _State extends StatefulSampleState<BottomNavigationBarPage> {
  int index = 1;

  @override
  Widget sample(BuildContext context) => FBottomNavigationBar(
    index: index,
    onChange: (index) => setState(() => this.index = index),
    children: [
      FBottomNavigationBarItem(icon: FIcon(FAssets.icons.house), label: const Text('Home')),
      FBottomNavigationBarItem(icon: FIcon(FAssets.icons.layoutGrid), label: const Text('Browse')),
      FBottomNavigationBarItem(icon: FIcon(FAssets.icons.radio), label: const Text('Radio')),
      FBottomNavigationBarItem(icon: FIcon(FAssets.icons.libraryBig), label: const Text('Library')),
      FBottomNavigationBarItem(icon: FIcon(FAssets.icons.search), label: const Text('Search')),
    ],
  );
}
