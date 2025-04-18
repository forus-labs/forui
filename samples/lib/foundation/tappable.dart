import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TappablePage extends Sample {
  TappablePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTappable(
    builder:
        (context, states, child) => Container(
          decoration: BoxDecoration(
            color:
                (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed))
                    ? context.theme.colors.secondary
                    : context.theme.colors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.theme.colors.border),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: child!,
        ),
    child: const Text('Tappable'),
    onPress: () {},
  );
}
