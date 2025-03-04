import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'badge_content.style.dart';

@internal
final class Content extends StatelessWidget {
  final FBadgeCustomStyle style;
  final Widget label;

  const Content({required this.style, required this.label, super.key});

  @override
  Widget build(BuildContext _) => Center(
    child: Padding(
      padding: style.contentStyle.padding,
      child: DefaultTextStyle.merge(style: style.contentStyle.labelTextStyle, child: label),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// [FBadge] content's style.
final class FBadgeContentStyle with Diagnosticable, _$FBadgeContentStyleFunctions {
  /// The label's [TextStyle].
  @override
  final TextStyle labelTextStyle;

  /// The padding.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({
    required this.labelTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
  });
}
