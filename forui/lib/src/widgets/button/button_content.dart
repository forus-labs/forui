part of 'button.dart';

@internal final class FButtonContent extends StatelessWidget {

  final FButtonStyle style;
  final bool enabled;
  final String? text;
  final SvgAsset? icon;
  final Widget? child;

  const FButtonContent({
    required this.style,
    this.enabled = true,
    this.text,
    this.icon,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style.content;
    return Padding(
      padding: style.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!(
              height: 20,
              colorFilter: ColorFilter.mode(enabled ? style.enabledIcon : style.disabledIcon, BlendMode.srcIn),
            ),
            const SizedBox(width: 10)
          ],
          if (text != null) Flexible(child: Text(text!, style: enabled ? style.enabledText : style.disabledText)),
          if (child != null) child!
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, defaultValue: true))
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty('icon', icon));
  }

}
