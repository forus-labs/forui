part of 'badge.dart';

@internal final class FBadgeContent extends StatelessWidget {
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
        style: style.content.label.scale(context.theme.typography),
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
  /// The label's style.
  final TextStyle label;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 14, vertical: 2)`.
  final EdgeInsets padding;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({
    required this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
  });

  /// Creates a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FBadgeContentStyle(
  ///   label: TextStyle(...),
  ///   padding = EdgeInsets.zero,
  /// );
  ///
  /// final copy = style.copyWith(padding: EdgeInsets.symmetric(vertical: 10));
  ///
  /// print(style.label == copy.label); // true
  /// print(style.padding == copy.padding); // false
  /// ```
  @useResult FBadgeContentStyle copyWith({TextStyle? label, EdgeInsets? padding}) => FBadgeContentStyle(
    label: label ?? this.label,
    padding: padding ?? this.padding,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('padding', padding, defaultValue: const EdgeInsets.symmetric(horizontal: 14, vertical: 2)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeContentStyle && runtimeType == other.runtimeType && padding == other.padding && label == other.label;

  @override
  int get hashCode => padding.hashCode ^ label.hashCode;
}
