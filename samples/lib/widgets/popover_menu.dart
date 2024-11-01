import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverMenuPage extends StatefulSample {
  PopoverMenuPage({
    @queryParam super.theme = 'zinc-light',
  });

  @override
  State<PopoverMenuPage> createState() => _State();
}

class _State extends StatefulSampleState<PopoverMenuPage> with SingleTickerProviderStateMixin {
  late FPopoverController controller;
  late FRadioSelectGroupController<String> groupController;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
    groupController = FRadioSelectGroupController<String>();
  }

  @override
  Widget sample(BuildContext context) => FHeader(
        title: const Text('Edit Notes'),
        actions: [
          FPopoverMenu(
            controller: controller,
            menuAnchor: Alignment.topRight,
            childAnchor: Alignment.bottomRight,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    prefixIcon: FIcon.empty(),
                    title: const Text('Personalization'),
                    suffixIcon: FIcon(FAssets.icons.user),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: FIcon.empty(),
                    title: const Text('Add attachments'),
                    suffixIcon: FIcon(FAssets.icons.paperclip),
                    onPress: () {},
                  ),
                ],
              ),
              FSelectTileGroup(
                controller: groupController,
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
            child: FHeaderAction(
              icon: FIcon(FAssets.icons.ellipsis),
              onPress: controller.toggle,
            ),
          ),
        ],
      );

  @override
  void dispose() {
    controller.dispose();
    groupController.dispose();
    super.dispose();
  }
}
