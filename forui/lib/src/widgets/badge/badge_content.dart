part of 'badge.dart';

@internal final class FBadgeContent extends StatelessWidget {

  final FBadgeStyle style;
  final String text;

  const FBadgeContent(this.text, {required this.style, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.content.padding,
    child: Text(text, style: style.content.text.withFont(context.theme.font)),
  );

}

/// A badge content's style.
final class FBadgeContentStyle with Diagnosticable {

  /// The padding.
  final EdgeInsets padding;

  /// The text.
  final TextStyle text;

  /// Creates a [FBadgeContentStyle].
  FBadgeContentStyle({required this.text, this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5)});

  /// Creates a copy of this [FBadgeContentStyle] with the given properties replaced.
  FBadgeContentStyle copyWith({TextStyle? text, EdgeInsets? padding}) => FBadgeContentStyle(
    text: text ?? this.text,
    padding: padding ?? this.padding,
  );


  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeContentStyle && runtimeType == other.runtimeType && padding == other.padding && text == other.text;

  @override
  int get hashCode => padding.hashCode ^ text.hashCode;

}
