import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class MobileWidget extends StatelessWidget {
  const MobileWidget();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class TabletWidget extends StatelessWidget {
  const TabletWidget();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

class DesktopWidget extends StatelessWidget {
  const DesktopWidget();

  @override
  Widget build(BuildContext context) => const Placeholder();
}

// {@snippet}
@override
Widget build(BuildContext context) {
  final breakpoints = context.theme.breakpoints;
  final width = MediaQuery.sizeOf(context).width;

  return switch (width) {
    _ when width < breakpoints.sm => const MobileWidget(),
    _ when width < breakpoints.lg => const TabletWidget(),
    _ => const DesktopWidget(),
  };
}

// {@endsnippet}
