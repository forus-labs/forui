part of 'badge.dart';

@internal final class FBadgeContent extends StatelessWidget {

  final FBadgeStyle style;
  final String label;

  const FBadgeContent({required this.style, required this.label, super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: style.content.padding,
      child: Text(label, style: style.content.label.withFont(context.theme.font)),
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

  /// The text.
  final TextStyle label;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({required this.label, this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 2)});

  /// Creates a copy of this [FBadgeContentStyle] with the given properties replaced.
  FBadgeContentStyle copyWith({TextStyle? label, EdgeInsets? padding}) => FBadgeContentStyle(
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
