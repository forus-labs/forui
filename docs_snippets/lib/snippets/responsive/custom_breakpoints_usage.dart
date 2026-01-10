import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/responsive/custom_breakpoints.dart';
import 'package:docs_snippets/snippets/responsive/usage.dart';

class SuperSmallWidget extends StatelessWidget {
  const SuperSmallWidget();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

// {@snippet}
@override
Widget build(BuildContext context) {
  final breakpoints = context.theme.breakpoints;
  final width = MediaQuery.sizeOf(context).width;

  return switch (width) {
    _ when width < breakpoints.custom => const SuperSmallWidget(),
    _ when width < breakpoints.sm => const MobileWidget(),
    _ when width < breakpoints.lg => const TabletWidget(),
    _ => const DesktopWidget(),
  };
}

// {@endsnippet}
