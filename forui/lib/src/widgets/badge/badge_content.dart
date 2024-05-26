part of 'badge.dart';

@internal final class FBadgeContent extends StatelessWidget {

  final String label;
  final FBadgeStyle style;

  const FBadgeContent({required this.label, required this.style, super.key});

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
      ..add(DiagnosticsProperty<FBadgeStyle>('style', style))
      ..add(StringProperty('text', label));
  }

}

/// A badge content's style.
final class FBadgeContentStyle with Diagnosticable {

  /// The padding.
  final EdgeInsets padding;

  /// The text.
  final TextStyle label;

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
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('text', label));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeContentStyle && runtimeType == other.runtimeType && padding == other.padding && label == other.label;

  @override
  int get hashCode => padding.hashCode ^ label.hashCode;

}
