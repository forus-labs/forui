import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final class FHeader extends StatelessWidget {
  final Widget? left;
  final Widget? right;
  final FHeaderStyle? style;

  const FHeader.raw({this.left, this.right, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle;

    return Column(
      children: [
        left ?? const SizedBox(),
        right ?? const SizedBox(),
      ],
    );
  }
}

final class FHeaderStyle with Diagnosticable {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
