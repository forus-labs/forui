import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class BreadcrumbPage extends Example {
  BreadcrumbPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Row(
    mainAxisAlignment: .center,
    children: [
      FBreadcrumb(
        children: [
          FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
          FBreadcrumbItem.collapsed(
            menu: [
              .group(
                children: [
                  .item(title: const Text('Documentation'), onPress: () {}),
                  .item(title: const Text('Themes'), onPress: () {}),
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
class BreadcrumbTilesPage extends Example {
  BreadcrumbTilesPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Row(
    mainAxisAlignment: .center,
    children: [
      FBreadcrumb(
        children: [
          FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
          // {@highlight}
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
          // {@endhighlight}
          FBreadcrumbItem(onPress: () {}, child: const Text('Layout')),
          const FBreadcrumbItem(current: true, child: Text('Widgets')),
        ],
      ),
    ],
  );
}

@RoutePage()
class BreadcrumbDividerPage extends Example {
  BreadcrumbDividerPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => Row(
    mainAxisAlignment: .center,
    children: [
      FBreadcrumb(
        // {@highlight}
        divider: Transform.rotate(angle: -60, child: const Icon(FIcons.slash, size: 14)),
        // {@endhighlight}
        children: [
          FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
          FBreadcrumbItem.collapsed(
            menu: [
              .group(
                children: [
                  .item(title: const Text('Documentation'), onPress: () {}),
                  .item(title: const Text('Themes'), onPress: () {}),
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
