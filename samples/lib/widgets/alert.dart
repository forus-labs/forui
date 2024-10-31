import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/src/widgets/alert.dart';

import 'package:forui_samples/sample.dart';

// ignore_for_file: invalid_use_of_internal_member, implementation_imports

final variants = {
  for (final value in Variant.values) value.name: value,
};

@RoutePage()
class AlertPage extends Sample {
  final Variant variant;

  AlertPage({
    @queryParam super.theme,
    @queryParam String style = 'primary',
  }) : variant = variants[style] ?? Variant.primary;

  @override
  Widget sample(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAlert(
            title: const Text('Heads Up!'),
            subtitle: const Text('You can add components to your app using the cli.'),
            style: variant,
          ),
        ],
      );
}
