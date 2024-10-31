import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  bool value = false;
  FRadioSelectGroupController<String> selectGroupController = FRadioSelectGroupController();
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FPopover(
            controller: controller,
            followerAnchor: Alignment.topRight,
            targetAnchor: Alignment.bottomRight,
            // hideOnTapOutside: widget.hideOnTapOutside,
            // shift: widget.shift,
            followerBuilder: (context, style, _) => ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: FTileGroup.merge(
                    children: [
                      FTileGroup(
                        children: [
                          FTile(
                            prefixIcon: FIcon(FAssets.icons.user, color: Colors.transparent),
                            title: const Text('Personalization'),
                            suffixIcon: FIcon(FAssets.icons.user),
                            onPress: () {},
                          ),
                          FTile(
                            prefixIcon: FIcon(FAssets.icons.wifi, color: Colors.transparent),
                            title: const Text('Network'),
                            suffixIcon: FIcon(FAssets.icons.appWindowMac),
                            onPress: () {},
                          ),
                        ],
                      ),
                      FSelectTileGroup(
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
            target: IntrinsicWidth(
              child: FButton(
                style: FButtonStyle.outline,
                onPress: controller.toggle,
                label: const Text('Open popover'),
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    controller.dispose();
    selectGroupController.dispose();
    super.dispose();
  }
}
