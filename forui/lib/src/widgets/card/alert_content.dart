part of 'card.dart';

final class _FAlertCardContent extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget? subtitle;
  final Widget? child;
  final FAlertContentStyle? style;

  _FAlertCardContent({
    this.icon,
    this.title,
    this.subtitle,
    this.style,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.cardStyle.alertContent;
    final icon = this.icon ?? style.icon;

    return Padding(
      padding: style.alertPadding,
      child: Row(
        children: [
          icon,
          _FCardContent(
            title: title,
            subtitle: subtitle,
            style: context.theme.cardStyle.content.copyWith(padding: style.contentPadding),
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// [FCard] content's style.
final class FAlertContentStyle with Diagnosticable {
  /// The icon.
  final Widget icon;

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 16)`.
  final EdgeInsets alertPadding;

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 16)`.
  final EdgeInsets contentPadding;

  /// Creates a [FAlertContentStyle].
  const FAlertContentStyle({
    required this.icon,
    this.alertPadding = const EdgeInsets.all(16),
    this.contentPadding = const EdgeInsets.only(left: 8),
  });

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme] and [typography].
  FAlertContentStyle.inherit(
      {required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : icon = FAssets.icons.plus(
          height: 20,
          colorFilter: ColorFilter.mode(colorScheme.foreground, BlendMode.srcIn),
        ),
        alertPadding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
        contentPadding = const EdgeInsets.only(left: 8);
}
