import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class VerticalLabelPage extends Sample {
  final String state;

  VerticalLabelPage({
    @queryParam super.theme,
    @queryParam this.state = 'enabled',
    super.maxWidth = 320,
  });

  @override
  Widget sample(BuildContext context) {
    final labelState = switch (state) {
      'enabled' => FLabelState.enabled,
      'disabled' => FLabelState.disabled,
      'error' => FLabelState.error,
      String() => FLabelState.enabled,
    };

    return FLabel(
      axis: Axis.vertical,
      label: const Text('Email'),
      description: const Text('Enter your email address.'),
      error: const Text('Please enter a valid email address.'),
      state: labelState,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.grey,
        ),
        child: SizedBox(width: 250, height: 30),
      ),
    );
  }
}

@RoutePage()
class HorizontalLabelPage extends Sample {
  final String state;

  HorizontalLabelPage({
    @queryParam super.theme,
    @queryParam this.state = 'enabled',
    super.maxWidth = 320,
  });

  @override
  Widget sample(BuildContext context) {
    final labelState = switch (state) {
      'enabled' => FLabelState.enabled,
      'disabled' => FLabelState.disabled,
      'error' => FLabelState.error,
      String() => FLabelState.enabled,
    };

    return FLabel(
      axis: Axis.horizontal,
      label: const Text('Accept terms and conditions'),
      description: const Text('You agree to our terms and conditions.'),
      error: const Text('Please accept the terms.'),
      state: labelState,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.grey,
        ),
        child: SizedBox(width: 16, height: 16),
      ),
    );
  }
}
