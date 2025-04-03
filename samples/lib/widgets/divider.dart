import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class DividerPage extends Sample {
  DividerPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) {
    final color = theme.color;
    final text = theme.text;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Flutter Forui',
          style: text.xl2.copyWith(color: color.foreground, fontWeight: FontWeight.w600),
        ),
        Text('An open-source widget library.', style: text.sm.copyWith(color: color.mutedForeground)),
        const FDivider(),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Blog', style: text.sm.copyWith(color: color.foreground)),
              const FDivider(axis: Axis.vertical),
              Text('Docs', style: text.sm.copyWith(color: color.foreground)),
              const FDivider(axis: Axis.vertical),
              Text('Source', style: text.sm.copyWith(color: color.foreground)),
            ],
          ),
        ),
      ],
    );
  }
}
