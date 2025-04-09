import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PersistentSheetPage extends StatefulSample {
  final bool keepAliveOffstage;

  PersistentSheetPage({@queryParam super.theme, @queryParam this.keepAliveOffstage = false});

  @override
  State<PersistentSheetPage> createState() => _SheetsState();
}

class _SheetsState extends StatefulSampleState<PersistentSheetPage> {
  final Map<FLayout, FPersistentSheetController> _controllers = {};

  @override
  Widget sample(BuildContext context) {
    VoidCallback onPress(FLayout side) => () {
      for (final MapEntry(:key, :value) in _controllers.entries) {
        if (key != side && value.shown) {
          return;
        }
      }

      var controller = _controllers[side];
      if (controller == null) {
        controller =
            _controllers[side] ??= showFPersistentSheet(
              context: context,
              side: side,
              keepAliveOffstage: widget.keepAliveOffstage,
              builder: (context, controller) => Form(side: side, controller: controller),
            );
      } else {
        controller.toggle();
      }
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FButton(onPress: onPress(FLayout.ltr), child: const Text('Left')),
        const SizedBox(height: 5),
        FButton(onPress: onPress(FLayout.ttb), child: const Text('Top')),
        const SizedBox(height: 5),
        FButton(onPress: onPress(FLayout.rtl), child: const Text('Right')),
        const SizedBox(height: 5),
        FButton(onPress: onPress(FLayout.btt), child: const Text('Bottom')),
      ],
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class Form extends StatelessWidget {
  final FLayout side;
  final FPersistentSheetController controller;

  const Form({required this.side, required this.controller, super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      color: context.theme.colors.background,
      border:
          side.vertical
              ? Border.symmetric(horizontal: BorderSide(color: context.theme.colors.border))
              : Border.symmetric(vertical: BorderSide(color: context.theme.colors.border)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: context.theme.typography.xl2.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colors.foreground,
                height: 1.5,
              ),
            ),
            Text(
              'Make changes to your account here. Click save when you are done.',
              style: context.theme.typography.sm.copyWith(color: context.theme.colors.mutedForeground),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 450,
              child: Column(
                children: [
                  const FTextField(label: Text('Name'), hint: 'John Renalo'),
                  const SizedBox(height: 10),
                  const FTextField(label: Text('Email'), hint: 'john@doe.com'),
                  const SizedBox(height: 16),
                  FButton(onPress: controller.toggle, child: const Text('Save')),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

@RoutePage()
class DraggablePersistentSheetPage extends StatefulSample {
  DraggablePersistentSheetPage({@queryParam super.theme});

  @override
  State<DraggablePersistentSheetPage> createState() => _DraggableState();
}

class _DraggableState extends StatefulSampleState<DraggablePersistentSheetPage> {
  FPersistentSheetController? controller;

  @override
  Widget sample(BuildContext context) => FButton(
    child: const Text('Click me'),
    onPress: () {
      if (controller != null) {
        controller!.toggle();
        return;
      }

      controller = showFPersistentSheet(
        context: context,
        side: FLayout.btt,
        mainAxisMaxRatio: null,
        builder:
            (context, _) => DraggableScrollableSheet(
              expand: false,
              builder:
                  (context, controller) => ScrollConfiguration(
                    // This is required to enable dragging on desktop.
                    // See https://github.com/flutter/flutter/issues/101903 for more information.
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad},
                    ),
                    child: FTileGroup.builder(
                      count: 25,
                      scrollController: controller,
                      tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
                    ),
                  ),
            ),
      );
    },
  );

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
