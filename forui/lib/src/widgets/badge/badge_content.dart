part of 'badge.dart';

final class _FBadgeContent extends StatelessWidget {
  final FBadgeCustomStyle style;
  final Widget label;

  const _FBadgeContent({
    required this.style,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: style.content.padding,
          child: DefaultTextStyle.merge(
            style: style.content.labelTextStyle,
            child: label,
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('label', label));
  }
}

/// A badge content's style.
final class FBadgeContentStyle with Diagnosticable {
  static const _defaultPadding = EdgeInsets.symmetric(horizontal: 14, vertical: 2);

  /// The label's [TextStyle].
  final TextStyle labelTextStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 14, vertical: 2)`.
  final EdgeInsets padding;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({
    required this.labelTextStyle,
    this.padding = _defaultPadding,
  });

  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FBadgeContentStyle(
  ///   labelTextStyle: TextStyle(...),
  ///   padding = EdgeInsets.zero,
  /// );
  ///
  /// final copy = style.copyWith(padding: EdgeInsets.symmetric(vertical: 10));
  ///
  /// print(style.labelTextStyle == copy.labelTextStyle); // true
  /// print(style.padding == copy.padding); // false
  /// ```
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
      ..add(DiagnosticsProperty('padding', padding, defaultValue: _defaultPadding));
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
