import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

@RoutePage()
@Options(inline: _Sheet, include: [Form])
class PersistentSheetPage extends Example {
  PersistentSheetPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => const _Sheet();
}

@RoutePage()
@Options(inline: _Sheet, include: [Form])
class KeepAliveOffstagePersistentSheetPage extends Example {
  KeepAliveOffstagePersistentSheetPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => const _Sheet(keepAliveOffstage: true);
}

class _Sheet extends StatefulWidget {
  final bool keepAliveOffstage;

  const _Sheet({this.keepAliveOffstage = false});

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  final Map<FLayout, FPersistentSheetController> _controllers = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onPress(FLayout side) => () {
      for (final MapEntry(:key, :value) in _controllers.entries) {
        if (key != side && value.status.isCompleted) {
          return;
        }
      }

      var controller = _controllers[side];
      if (controller == null) {
        controller = _controllers[side] ??= showFPersistentSheet(
          context: context,
          side: side,
          // {@highlight}
          keepAliveOffstage: widget.keepAliveOffstage,
          // {@endhighlight}
          builder: (context, controller) => Form(side: side, controller: controller),
        );
      } else {
        controller.toggle();
      }
    };

    return Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 5,
      children: [
        FButton(onPress: onPress(.ltr), child: const Text('Left')),
        FButton(onPress: onPress(.ttb), child: const Text('Top')),
        FButton(onPress: onPress(.rtl), child: const Text('Right')),
        FButton(onPress: onPress(.btt), child: const Text('Bottom')),
      ],
    );
  }
}

class Form extends StatelessWidget {
  final FLayout side;
  final FPersistentSheetController controller;

  const Form({required this.side, required this.controller, super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: .infinity,
    width: .infinity,
    decoration: BoxDecoration(
      color: context.theme.colors.background,
      border: side.vertical
          ? .symmetric(horizontal: BorderSide(color: context.theme.colors.border))
          : .symmetric(vertical: BorderSide(color: context.theme.colors.border)),
    ),
    child: Padding(
      padding: const .symmetric(horizontal: 15, vertical: 8.0),
      child: Column(
        mainAxisAlignment: .center,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(
            'Account',
            style: context.theme.typography.xl2.copyWith(
              fontWeight: .w600,
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
  );
}

@RoutePage()
class DraggablePersistentSheetPage extends StatefulExample {
  DraggablePersistentSheetPage({@queryParam super.theme});

  @override
  State<DraggablePersistentSheetPage> createState() => _DraggableState();
}

class _DraggableState extends StatefulExampleState<DraggablePersistentSheetPage> {
  FPersistentSheetController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget example(BuildContext context) => FButton(
    child: const Text('Click me'),
    onPress: () {
      if (controller != null) {
        controller!.toggle();
        return;
      }

      controller = showFPersistentSheet(
        context: context,
        side: .btt,
        mainAxisMaxRatio: null,
        builder: (context, _) => DraggableScrollableSheet(
          expand: false,
          builder: (context, controller) => ScrollConfiguration(
            // This is required to enable dragging on desktop.
            // See https://github.com/flutter/flutter/issues/101903 for more information.
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {.touch, .mouse, .trackpad}),
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
}
