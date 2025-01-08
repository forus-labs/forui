import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ModalSheetPage extends Sample {
  ModalSheetPage({
    @queryParam super.theme,
  });

  @override
  Widget sample(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FButton(
            label: const Text('Left'),
            onPress: () => showFSheet(
              context: context,
              side: FLayout.ltr,
              builder: (context) => const Form(side: FLayout.ltr),
            ),
          ),
          const SizedBox(height: 5),
          FButton(
            label: const Text('Top'),
            onPress: () => showFSheet(
              context: context,
              side: FLayout.ttb,
              builder: (context) => const Form(side: FLayout.ttb),
            ),
          ),
          const SizedBox(height: 5),
          FButton(
            label: const Text('Right'),
            onPress: () => showFSheet(
              context: context,
              side: FLayout.rtl,
              builder: (context) => const Form(side: FLayout.rtl),
            ),
          ),
          const SizedBox(height: 5),
          FButton(
            label: const Text('Bottom'),
            onPress: () => showFSheet(
              context: context,
              side: FLayout.btt,
              builder: (context) => const Form(side: FLayout.btt),
            ),
          ),
        ],
      );
}

class Form extends StatelessWidget {
  final FLayout side;

  const Form({required this.side, super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          border: side.vertical
              ? Border.symmetric(horizontal: BorderSide(color: context.theme.colorScheme.border))
              : Border.symmetric(vertical: BorderSide(color: context.theme.colorScheme.border)),
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
                    color: context.theme.colorScheme.foreground,
                    height: 1.5,
                  ),
                ),
                Text(
                  'Make changes to your account here. Click save when you are done.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 450,
                  child: Column(
                    children: [
                      const FTextField(
                        label: Text('Name'),
                        hint: 'John Renalo',
                      ),
                      const SizedBox(height: 10),
                      const FTextField(
                        label: Text('Email'),
                        hint: 'john@doe.com',
                      ),
                      const SizedBox(height: 16),
                      FButton(
                        label: const Text('Save'),
                        onPress: () => Navigator.of(context).pop(),
                      ),
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
class DraggableModalSheetPage extends Sample {
  DraggableModalSheetPage({
    @queryParam super.theme,
  });

  @override
  Widget sample(BuildContext context) => FButton(
        label: const Text('Click me'),
        onPress: () => showFSheet(
          context: context,
          side: FLayout.btt,
          mainAxisMaxRatio: null,
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            builder: (context, controller) => ScrollConfiguration(
              // This is required to enable dragging on desktop.
              // See https://github.com/flutter/flutter/issues/101903 for more information.
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: FTileGroup.builder(
                count: 25,
                scrollController: controller,
                tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
              ),
            ),
          ),
        ),
      );
}
