import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class FocusedOutlinePage extends Sample {
  FocusedOutlinePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FFocusedOutline(
    focused: true,
    child: Container(
      decoration: BoxDecoration(color: context.theme.colors.primary, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Text(
        'Focused',
        style: context.theme.typography.base.copyWith(color: context.theme.colors.primaryForeground),
      ),
    ),
  );
}
