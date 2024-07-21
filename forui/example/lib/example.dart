import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FResizableBox(
        axis: Axis.vertical,
        interaction: const FResizableInteraction.selectAndResize(1),
        children: [
          FResizable(
            initialSize: 200,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.primary : colorScheme.border,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Label(data: data, icon: FAssets.icons.sunrise, label: 'Morning'),
              );
            },
          ),
          FResizable(
            initialSize: 200,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.primary : colorScheme.border,
                ),
                child: Label(data: data, icon: FAssets.icons.sun, label: 'Afternoon'),
              );
            },
          ),
          FResizable(
            initialSize: 200,
            builder: (context, data, _) {
              final colorScheme = context.theme.colorScheme;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.selected ? colorScheme.primary : colorScheme.border,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
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
    final color = data.selected ? colorScheme.primaryForeground : colorScheme.primary;
    final start =
        DateTime.fromMillisecondsSinceEpoch((data.percentage.min * Duration.millisecondsPerDay).round(), isUtc: true);
    final end =
        DateTime.fromMillisecondsSinceEpoch((data.percentage.max * Duration.millisecondsPerDay).round(), isUtc: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon(height: 15, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            const SizedBox(width: 3),
            Text(label, style: typography.xs.copyWith(color: color)),
          ],
        ),
        const SizedBox(height: 5),
        Text('${format.format(start)} - ${format.format(end)}', style: typography.sm.copyWith(color: color)),
      ],
    );
  }
}
