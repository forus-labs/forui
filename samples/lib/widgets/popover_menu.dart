import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverMenuPage extends Sample {
  PopoverMenuPage({@queryParam super.theme = 'zinc-light'});

  @override
  Widget sample(BuildContext context) => FHeader(
    title: const Text('Edit Notes'),
    suffixes: [
      FPopoverMenu(
        menuAnchor: Alignment.topRight,
        childAnchor: Alignment.bottomRight,
        menu: [
          FTileGroup(
            children: [
              FTile(prefix: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              FTile(prefix: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              FTile(prefix: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          FTileGroup(
            children: [
              FTile(prefix: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              FTile(prefix: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        builder: (_, controller, _) => FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: controller.toggle),
      ),
    ],
  );
}
