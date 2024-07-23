import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class ResizablePage extends SampleScaffold {
  ResizablePage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FResizable(
        axis: Axis.vertical,
        crossAxisExtent: 400,
        interaction: const FResizableInteraction.selectAndResize(0),
        children: [
          FResizableRegion.raw(
            initialSize: 200,
            minSize: 100,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.foreground : colorScheme.background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  border: Border.all(color: colorScheme.border),
                ),
                child: Label(data: data, icon: FAssets.icons.sunrise, label: 'Morning'),
              );
            },
          ),
          FResizableRegion.raw(
            initialSize: 200,
            minSize: 100,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.foreground : colorScheme.background,
                  border: Border.all(color: colorScheme.border),
                ),
                child: Label(data: data, icon: FAssets.icons.sun, label: 'Afternoon'),
              );
            },
          ),
          FResizableRegion.raw(
            initialSize: 200,
            minSize: 100,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.foreground : colorScheme.background,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                  border: Border.all(color: colorScheme.border),
                ),
                child: Label(data: data, icon: FAssets.icons.moon, label: 'Night'),
              );
            },
          ),
        ],
      );
}

class Label extends StatelessWidget {
  static final DateFormat format = DateFormat.jm(); // Requires package:intl

  final FResizableRegionData data;
  final SvgAsset icon;
  final String label;

  const Label({required this.data, required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colorScheme, :typography) = context.theme;
    final color = data.selected ? colorScheme.background : colorScheme.foreground;
    final start = DateTime.fromMillisecondsSinceEpoch(
      (data.offsetPercentage.min * Duration.millisecondsPerDay).round(),
      isUtc: true,
    );
    final end = DateTime.fromMillisecondsSinceEpoch(
      (data.offsetPercentage.max * Duration.millisecondsPerDay).round(),
      isUtc: true,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon(height: 15, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            const SizedBox(width: 3),
            Text(label, style: typography.sm.copyWith(color: color)),
          ],
        ),
        const SizedBox(height: 5),
        Text('${format.format(start)} - ${format.format(end)}', style: typography.sm.copyWith(color: color)),
      ],
    );
  }
}

@RoutePage()
class HorizontalResizablePage extends SampleScaffold {
  HorizontalResizablePage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FResizable(
        axis: Axis.horizontal,
        crossAxisExtent: 300,
        children: [
          FResizableRegion.raw(
            initialSize: 100,
            minSize: 100,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.foreground : colorScheme.background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  border: Border.all(color: colorScheme.border),
                ),
                child: Text('Sidebar', style: context.theme.typography.sm),
              );
            },
          ),
          FResizableRegion.raw(
            initialSize: 300,
            minSize: 100,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                  border: Border.all(color: colorScheme.border),
                ),
                child: Text('Content', style: context.theme.typography.sm),
              );
            },
          ),
        ],
      );
}
