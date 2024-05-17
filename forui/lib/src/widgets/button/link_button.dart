import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Creates a [FLinkButton] within a RichText.
///              Row(
///                 children: [
///                  Expanded(
///                     child: RichText(
///                       textAlign: TextAlign.center,
///                       text: TextSpan(
///                         text: 'By clicking continue, you agree to our ',
///                         style: CustomTextStyle,
///                         children: [
///                           WidgetSpan(
///                             alignment: PlaceholderAlignment.baseline,
///                             baseline: TextBaseline.alphabetic,
///                             child: FLinkButton(
///                               text: 'Terms of Service',
///                               onPressed: () {},
///                             ),
///                           ),
///                           const TextSpan(text: ' and '),
///                           WidgetSpan(
///                             alignment: PlaceholderAlignment.baseline,
///                             baseline: TextBaseline.alphabetic,
///                             child: FLinkButton(text: 'Privacy Policy', onPressed: () {}),
///                           ),
///                         ],
///                       ),
///                     ),
///                   ),
///                 ],
///               ),
/// ```
class FLinkButton extends StatelessWidget {
  /// The title.
  final String text;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The style.
  final FButtonStyle? style;

  /// Creates a [FLinkButton] widget.
  const FLinkButton({
    required this.text,
    required this.onPressed,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgets.button;
    return TextButton(
      style: style.button,
      onPressed: onPressed,
      child: Text(
        text,
        style: style.text,
      ),
    );
  }
}
