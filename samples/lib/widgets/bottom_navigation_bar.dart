import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

const _foo = 'lorem';

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
    children: const [
      FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
      FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Browse')),
      FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Radio')),
      FBottomNavigationBarItem(icon: Icon(FIcons.libraryBig), label: Text('Library')),
      FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('Search')),
    ],
  );
}
