part of 'badge.dart';

@internal
final class FBadgeContent extends StatelessWidget {
  final FBadgeCustomStyle style;
  final String? label;
  final Widget? rawLabel;

  const FBadgeContent({
    required this.style,
    this.label,
    this.rawLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: style.content.padding,
      child: DefaultTextStyle.merge(
        style: style.content.labelTextStyle,
        child: switch ((label, rawLabel)) {
          (final String label, _) => Text(label),
          (_, final Widget label) => label,
          _ => const Placeholder(),
        },
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('label', label));
  }
}

/// A badge content's style.
final class FBadgeContentStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle labelTextStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 14, vertical: 2)`.
  final EdgeInsets padding;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({
    required this.labelTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
  @useResult FBadgeContentStyle copyWith({TextStyle? labelTextStyle, EdgeInsets? padding}) => FBadgeContentStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    padding: padding ?? this.padding,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('padding', padding, defaultValue: const EdgeInsets.symmetric(horizontal: 14, vertical: 2)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeContentStyle && runtimeType == other.runtimeType && padding == other.padding && labelTextStyle == other.labelTextStyle;

  @override
  int get hashCode => padding.hashCode ^ labelTextStyle.hashCode;
}
