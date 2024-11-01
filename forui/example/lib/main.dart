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

class _ApplicationState extends State<Application> with SingleTickerProviderStateMixin {
  int index = 4;
  FRadioSelectGroupController<String> selectGroupController = FRadioSelectGroupController();
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

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
              FPopover(
                style: context.theme.popoverStyle.copyWith(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  decoration: context.theme.popoverStyle.decoration.copyWith(
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0x0d000000),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                controller: controller,
                followerAnchor: Alignment.topRight,
                targetAnchor: Alignment.bottomRight,
                ignoreDirectionalPadding: false,
                // hideOnTapOutside: widget.hideOnTapOutside,
                // shift: widget.shift,
                followerBuilder: (context, style, _) => ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: FTileGroup.merge(
                      divider: FTileDivider.indented,
                      children: [
                        FTileGroup(
                          divider: FTileDivider.none,
                          children: [
                            FTile(
                              prefixIcon: FIcon.empty(),
                              title: const Text('Personalization'),
                              suffixIcon: FIcon(FAssets.icons.user),
                              onPress: () {},
                            ),
                            FTile(
                              prefixIcon: FIcon.empty(),
                              title: const Text('Network'),
                              suffixIcon: FIcon(FAssets.icons.appWindowMac),
                              onPress: () {},
                            ),
                          ],
                        ),
                        FSelectTileGroup(
                          divider: FTileDivider.none,
                          controller: selectGroupController,
                          children: [
                            FSelectTile(
                              title: const Text('List View'),
                              suffixIcon: FIcon(FAssets.icons.list),
                              value: 'List',
                            ),
                            FSelectTile(
                              title: const Text('Grid View'),
                              suffixIcon: FIcon(FAssets.icons.layoutGrid),
                              value: 'Grid',
                            ),
                          ],
                        ),
                      ],
                    )),
                target: FHeaderAction(
                  icon: FIcon(FAssets.icons.plus),
                  onPress: controller.toggle,
                ),
              ),
            ],
          ),
          content: _pages[index],
          footer: FBottomNavigationBar(
            index: index,
            onChange: (index) => setState(() => this.index = index),
            children: [
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.house),
                label: const Text('Home'),
              ),
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.layoutGrid),
                label: const Text('Categories'),
              ),
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.search),
                label: const Text('Search'),
              ),
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.settings),
                label: const Text('Settings'),
              ),
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.castle),
                label: const Text('Sandbox'),
              ),
            ],
          ),
        ),
      );
}
