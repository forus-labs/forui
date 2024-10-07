import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
final class Content extends StatelessWidget {
  final FBadgeCustomStyle style;
  final Widget label;

  const Content({
    required this.style,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: style.contentStyle.padding,
          child: DefaultTextStyle.merge(
            style: style.contentStyle.labelTextStyle,
            child: label,
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// [FBadge] content's style.
final class FBadgeContentStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle labelTextStyle;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({
    required this.labelTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
  });

  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  @useResult
  FBadgeContentStyle copyWith({TextStyle? labelTextStyle, EdgeInsets? padding}) => FBadgeContentStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          labelTextStyle == other.labelTextStyle;

  @override
  int get hashCode => padding.hashCode ^ labelTextStyle.hashCode;
}
