import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class BreadcrumbPage extends Sample {
  BreadcrumbPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FBreadcrumb(
        children: [
          FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
          FBreadcrumbItem.collapsed(
            menu: [
              FItemGroup(
                children: [
                  FItem(title: const Text('Documentation'), onPress: () {}),
                  FItem(title: const Text('Themes'), onPress: () {}),
                ],
              ),
            ],
          ),
          FBreadcrumbItem(onPress: () {}, child: const Text('Layout')),
          const FBreadcrumbItem(current: true, child: Text('Widgets')),
        ],
      ),
    ],
  );
}

@RoutePage()
class BreadcrumbTilesPage extends Sample {
  BreadcrumbTilesPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FBreadcrumb(
        children: [
          FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
          FBreadcrumbItem.collapsedTiles(
            menu: [
              FTileGroup(
                children: [
                  FTile(title: const Text('Documentation'), onPress: () {}),
                  FTile(title: const Text('Themes'), onPress: () {}),
                ],
              ),
            ],
          ),
          FBreadcrumbItem(onPress: () {}, child: const Text('Layout')),
          const FBreadcrumbItem(current: true, child: Text('Widgets')),
        ],
      ),
    ],
  );
}

@RoutePage()
class BreadcrumbDividerPage extends Sample {
  BreadcrumbDividerPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FBreadcrumb(
        divider: Transform.rotate(angle: -60, child: const Icon(FIcons.slash, size: 14)),
        children: [
          FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
          FBreadcrumbItem.collapsed(
            menu: [
              FItemGroup(
                children: [
                  FItem(title: const Text('Documentation'), onPress: () {}),
                  FItem(title: const Text('Themes'), onPress: () {}),
                ],
              ),
            ],
          ),
          FBreadcrumbItem(onPress: () {}, child: const Text('Layout')),
          const FBreadcrumbItem(current: true, child: Text('Widgets')),
        ],
      ),
    ],
  );
}
