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
  Widget build(BuildContext context) => Column(
        children: [
          FResizable(
            controller: FResizableController.cascade(),
            axis: Axis.vertical,
            crossAxisExtent: 400,
            children: [
              FResizableRegion(
                initialSize: 200,
                minSize: 100,
                builder: (context, data, _) {
                  final colorScheme = context.theme.colorScheme;
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.foreground,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: Label(data: data, icon: FAssets.icons.sunrise, label: 'Morning'),
                  );
                },
              ),
              FResizableRegion(
                initialSize: 200,
                minSize: 100,
                builder: (context, data, _) {
                  final colorScheme = context.theme.colorScheme;
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.foreground,
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: Label(data: data, icon: FAssets.icons.sun, label: 'Afternoon'),
                  );
                },
              ),
              FResizableRegion(
                initialSize: 200,
                minSize: 100,
                builder: (context, data, _) {
                  final colorScheme = context.theme.colorScheme;
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.foreground,
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: Label(data: data, icon: FAssets.icons.sunset, label: 'Evening'),
                  );
                },
              ),
              FResizableRegion(
                initialSize: 200,
                minSize: 100,
                builder: (context, data, _) {
                  final colorScheme = context.theme.colorScheme;
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.foreground,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: Label(data: data, icon: FAssets.icons.moon, label: 'Night'),
                  );
                },
              ),
            ],
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
            icon(height: 15, colorFilter: ColorFilter.mode(colorScheme.background, BlendMode.srcIn)),
            const SizedBox(width: 3),
            Text(label, style: typography.sm.copyWith(color: colorScheme.background)),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          '${format.format(start)} - ${format.format(end)}',
          style: typography.sm.copyWith(color: colorScheme.background),
        ),
      ],
    );
  }
}
