import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ModalSheetPage extends Sample {
  ModalSheetPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: .center,
    mainAxisSize: .min,
    children: [
      FButton(
        child: const Text('Left'),
        onPress: () => showFSheet(
          context: context,
          side: .ltr,
          builder: (context) => const Form(side: .ltr),
        ),
      ),
      const SizedBox(height: 5),
      FButton(
        child: const Text('Top'),
        onPress: () => showFSheet(
          context: context,
          side: .ttb,
          builder: (context) => const Form(side: .ttb),
        ),
      ),
      const SizedBox(height: 5),
      FButton(
        child: const Text('Right'),
        onPress: () => showFSheet(
          context: context,
          side: .rtl,
          builder: (context) => const Form(side: .rtl),
        ),
      ),
      const SizedBox(height: 5),
      FButton(
        child: const Text('Bottom'),
        onPress: () => showFSheet(
          context: context,
          side: .btt,
          builder: (context) => const Form(side: .btt),
        ),
      ),
    ],
  );
}

@RoutePage()
class BlurredModalSheetPage extends Sample {
  BlurredModalSheetPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Center(
    child: FButton(
      child: const Text('Open'),
      onPress: () => showFSheet(
        style: context.theme.modalSheetStyle.copyWith(
          barrierFilter: (animation) => ImageFilter.compose(
            outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            inner: ColorFilter.mode(context.theme.colors.barrier, .srcOver),
          ),
        ),
        context: context,
        side: .ltr,
        builder: (context) => const Form(side: .ltr),
      ),
    ),
  );
}

class Form extends StatelessWidget {
  final FLayout side;

  const Form({required this.side, super.key});

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
      child: Center(
        child: Column(
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
                  FButton(child: const Text('Save'), onPress: () => Navigator.of(context).pop()),
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
  DraggableModalSheetPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FButton(
    child: const Text('Click me'),
    onPress: () => showFSheet(
      context: context,
      side: .btt,
      mainAxisMaxRatio: null,
      builder: (context) => DraggableScrollableSheet(
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
    ),
  );
}
