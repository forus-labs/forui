import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class BreadcrumbPage extends Sample {
  BreadcrumbPage({
    @queryParam super.theme,
  });

  @override
  Widget sample(BuildContext context) => FBreadcrumb(
        children: [
          FBreadcrumbItem.of(onPress: () {}, child: const Text('Forui')),
          FBreadcrumbItem.collapsed(
            menu: [
              FTileGroup(children: [
                FTile(
                  title: const Text('Documentation'),
                  onPress: () {},
                ),
                FTile(
                  title: const Text('Themes'),
                  onPress: () {},
                ),
              ]),
            ],
          ),
          FBreadcrumbItem.of(onPress: () {}, child: const Text('Layout')),
          FBreadcrumbItem.of(onPress: () {}, child: const Text('Widgets'), selected: true),
        ],
      );
}
