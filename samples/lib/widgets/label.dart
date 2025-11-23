import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class VerticalLabelPage extends Sample {
  final Set<WidgetState> states;

  VerticalLabelPage({@queryParam super.theme, @queryParam bool enabled = true, super.maxWidth = 320})
    : states = enabled ? {} : {WidgetState.disabled};

  @override
  Widget sample(BuildContext context) => FLabel(
    axis: .vertical,
    label: const Text('Email'),
    description: const Text('Enter your email address.'),
    error: const Text('Please enter a valid email address.'),
    states: states,
    child: const DecoratedBox(
      decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
      child: SizedBox(width: 250, height: 30),
    ),
  );
}

@RoutePage()
class HorizontalLabelPage extends Sample {
  final Set<WidgetState> states;

  HorizontalLabelPage({@queryParam super.theme, @queryParam bool enabled = true, super.maxWidth = 320})
    : states = enabled ? {} : {WidgetState.disabled};

  @override
  Widget sample(BuildContext context) => FLabel(
    axis: .horizontal,
    label: const Text('Accept terms and conditions'),
    description: const Text('You agree to our terms and conditions.'),
    error: const Text('Please accept the terms.'),
    states: states,
    child: const DecoratedBox(
      decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
      child: SizedBox(width: 16, height: 16),
    ),
  );
}
