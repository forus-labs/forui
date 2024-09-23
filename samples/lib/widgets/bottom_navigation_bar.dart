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
            icon: FAssets.icons.home,
            label: 'Home',
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.layoutGrid,
            label: 'Browse',
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.radio,
            label: 'Radio',
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.libraryBig,
            label: 'Library',
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.search,
            label: 'Search',
          ),
        ],
      );
}

@RoutePage()
class CustomBottomNavigationBarPage extends SampleScaffold {
  CustomBottomNavigationBarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
    padding: EdgeInsets.all(15.0),
    child: _CustomDemo(),
  );
}

class _CustomDemo extends StatefulWidget {
  const _CustomDemo();

  @override
  State<_CustomDemo> createState() => _CustomDemoState();
}

class _CustomDemoState extends State<_CustomDemo> {
  int index = 1;

  @override
  Widget build(BuildContext context) => FBottomNavigationBar(
    index: index,
    onChange: (index) => setState(() => this.index = index),
    children: [
      FBottomNavigationBarItem.customIcon(
        iconBuilder: (_, data, __) => Icon(
          Icons.home_outlined,
          size: data.itemStyle.iconSize,
          color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
        ),
        label: 'Home',
      ),
      FBottomNavigationBarItem.customIcon(
        iconBuilder: (_, data, __) => Icon(
          Icons.browse_gallery_outlined,
          size: data.itemStyle.iconSize,
          color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
        ),
        label: 'Browse',
      ),
      FBottomNavigationBarItem.customIcon(
        iconBuilder: (_, data, __) => Icon(
          Icons.radio_outlined,
          size: data.itemStyle.iconSize,
          color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
        ),
        label: 'Radio',
      ),
      FBottomNavigationBarItem.customIcon(
        iconBuilder: (_, data, __) => Icon(
          Icons.library_books_outlined,
          size: data.itemStyle.iconSize,
          color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
        ),
        label: 'Library',
      ),
      FBottomNavigationBarItem.customIcon(
        iconBuilder: (_, data, __) => Icon(
          Icons.search_outlined,
          size: data.itemStyle.iconSize,
          color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
        ),
        label: 'Search',
      ),
    ],
  );
}
