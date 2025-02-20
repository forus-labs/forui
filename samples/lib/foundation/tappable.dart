import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TappablePage extends Sample {
  TappablePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTappable.animated(
    builder:
        (context, data, child) => Container(
          decoration: BoxDecoration(
            color: data.hovered ? context.theme.colorScheme.secondary : context.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.theme.colorScheme.border),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: child!,
        ),
    child: const Text('Tappable'),
    onPress: () {},
  );
}
