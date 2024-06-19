// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

// Project imports:
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TextFieldPage extends SampleScaffold {
  final bool enabled;

  TextFieldPage({
    @queryParam super.theme,
    @queryParam this.enabled = false,
  });

  @override
  Widget child(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
    child: FTextField(
      enabled: enabled,
      label: 'Email',
      hint: 'john@doe.com',
    ),
  );
}
