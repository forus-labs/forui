import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverMenuPage extends StatefulSample {
  PopoverMenuPage({@queryParam super.theme = 'zinc-light'});

  @override
  State<PopoverMenuPage> createState() => _State();
}

class _State extends StatefulSampleState<PopoverMenuPage> with SingleTickerProviderStateMixin {
  late final controller = FPopoverController(vsync: this);

  @override
  Widget sample(BuildContext context) => FHeader(
    title: const Text('Edit Notes'),
    actions: [
      FPopoverMenu(
        popoverController: controller,
        menuAnchor: Alignment.topRight,
        childAnchor: Alignment.bottomRight,
        menu: [
          FTileGroup(
            children: [
              FTile(prefixIcon: const Icon(FIcons.user), title: const Text('Personalization'), onPress: () {}),
              FTile(prefixIcon: const Icon(FIcons.paperclip), title: const Text('Add attachments'), onPress: () {}),
              FTile(prefixIcon: const Icon(FIcons.qrCode), title: const Text('Scan Document'), onPress: () {}),
            ],
          ),
          FTileGroup(
            children: [
              FTile(prefixIcon: const Icon(FIcons.list), title: const Text('List View'), onPress: () {}),
              FTile(prefixIcon: const Icon(FIcons.layoutGrid), title: const Text('Grid View'), onPress: () {}),
            ],
          ),
        ],
        child: FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: controller.toggle),
      ),
    ],
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
