import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PopoverMenuPage extends Example {
  PopoverMenuPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader(
    title: const Text('Edit Notes'),
    suffixes: [
      FPopoverMenu(
        autofocus: true,
        menuAnchor: .topRight,
        childAnchor: .bottomRight,
        menu: [
          .group(
            children: [
              .item(prefix: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              .item(prefix: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              .item(prefix: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          .group(
            children: [
              .item(prefix: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              .item(prefix: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        builder: (_, controller, _) => FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: controller.toggle),
      ),
    ],
  );
}

@RoutePage()
class TilePopoverMenuPage extends Example {
  TilePopoverMenuPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FHeader(
    title: const Text('Edit Notes'),
    suffixes: [
      // {@highlight}
      FPopoverMenu.tiles(
        // {@endhighlight}
        autofocus: true,
        menuAnchor: .topRight,
        childAnchor: .bottomRight,
        menu: [
          .group(
            children: [
              .tile(prefix: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              .tile(prefix: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              .tile(prefix: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          .group(
            children: [
              .tile(prefix: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              .tile(prefix: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        builder: (_, controller, _) => FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: controller.toggle),
      ),
    ],
  );
}
