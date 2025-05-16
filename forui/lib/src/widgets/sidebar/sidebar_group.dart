import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sidebar_group.style.dart';

class FSidebarGroup extends StatelessWidget {
  final Widget? label;
  final Widget? action;
  final List<Widget> children;

  const FSidebarGroup({required this.children, this.label, this.action, super.key});

  @override
  Widget build(BuildContext context) => Column(
    spacing: 5,
    children: [
      if (label != null || action != null)
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (label != null) label! else const SizedBox(),
            if (action != null) action! else const SizedBox(),
          ],
        ),
      ...children,
    ],
  );
}

class FSidebarGroupStyle with Diagnosticable, _$FSidebarGroupStyleFunctions {
  @override
  final double spacing;

  const FSidebarGroupStyle({required this.spacing});

  FSidebarGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(spacing: 5);
}
