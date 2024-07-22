import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ResizableBoxPage extends SampleScaffold {
  ResizableBoxPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FResizableBox(
    axis: Axis.vertical,
    crossAxisExtent: 400,
    interaction: const FResizableInteraction.selectAndResize(0),
    children: [
      FResizable.raw(
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
      FResizable.raw(
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
      FResizable.raw(
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

  final FResizableData data;
  final SvgAsset icon;
  final String label;

  const Label({required this.data, required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colorScheme, :typography) = context.theme;
    final color = data.selected ? colorScheme.background : colorScheme.foreground;
    final start =
    DateTime.fromMillisecondsSinceEpoch((data.percentage.min * Duration.millisecondsPerDay).round(), isUtc: true);
    final end =
    DateTime.fromMillisecondsSinceEpoch((data.percentage.max * Duration.millisecondsPerDay).round(), isUtc: true);

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
class HorizontalResizableBoxPage extends SampleScaffold {
  HorizontalResizableBoxPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FResizableBox(
    axis: Axis.horizontal,
    crossAxisExtent: 300,
    interaction: const FResizableInteraction.resize(),
    children: [
      FResizable.raw(
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
            child: Text('Sidebar', style: context.theme.typography.sm)
          );
        },
      ),
      FResizable.raw(
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
