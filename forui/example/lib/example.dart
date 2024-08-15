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
  Widget build(BuildContext context) => const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(top: 1, left: 10, child: Align(child: Text('Hiqdqdqdqd'))),
                SizedBox(
                  width: 10,
                  height: 100,
                  child: ColoredBox(
                    color: Colors.white30,
                  ),
                ),
              ],
            ),
          )
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

    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon(height: 15, colorFilter: ColorFilter.mode(colorScheme.foreground, BlendMode.srcIn)),
              const SizedBox(width: 3),
              Text(label, style: typography.sm.copyWith(color: colorScheme.foreground)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '${format.format(start)} - ${format.format(end)}',
            style: typography.sm.copyWith(color: colorScheme.foreground),
          ),
        ],
      ),
    );
  }
}
