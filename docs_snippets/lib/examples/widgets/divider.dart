import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class DividerPage extends Example {
  DividerPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) {
    final colors = theme.colors;
    final text = theme.typography;

    return Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      children: [
        Text(
          'Flutter Forui',
          style: text.xl2.copyWith(color: colors.foreground, fontWeight: .w600),
        ),
        Text('An open-source widget library.', style: text.sm.copyWith(color: colors.mutedForeground)),
        const FDivider(),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Text('Blog', style: text.sm.copyWith(color: colors.foreground)),
              const FDivider(axis: .vertical),
              Text('Docs', style: text.sm.copyWith(color: colors.foreground)),
              const FDivider(axis: .vertical),
              Text('Source', style: text.sm.copyWith(color: colors.foreground)),
            ],
          ),
        ),
      ],
    );
  }
}
