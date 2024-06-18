part of 'button.dart';

class FButtonContentIcon extends StatelessWidget {

  final SvgAsset icon;

  const FButtonContentIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) => icon(
    height: 20, // TODO: Icon size should be configurable.
    // colorFilter: ColorFilter.mode(enabled ? style.enabledIcon : style.disabledIcon, BlendMode.srcIn),
  );
}

final class FButtonContentIconStyle with Diagnosticable {

  /// The icon's color when this button is enabled.
  final Color enabledIcon;

  /// The icon's color when this button is disabled.
  final Color disabledIcon;

  FButtonContentIconStyle({
    required this.enabledIcon,
    required this.disabledIcon,
  });

}
