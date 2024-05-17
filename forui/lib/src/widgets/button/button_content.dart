import 'package:flutter/material.dart';

/// The content for a text button.
class FTextButtonContent extends StatelessWidget {
  /// The label on the button.
  final String text;

  /// Creates a [FTextButtonContent].
  const FTextButtonContent(
      this.text, {
        super.key,
      });

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    child: Text(text),
  );
}
//
// /// The content for a icon button.
// class IconButtonContent extends StatelessWidget {
//   /// The label on the button.
//   final String text;
//
//   /// The icon.
//   final SvgAsset icon;
//
//   /// The icon color
//   final Color color;
//
//   /// Creates a [TextButtonContent].
//   const IconButtonContent({
//     required this.text,
//     required this.icon,
//     this.color = Colors.white,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) => Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       // [SvgTheme] provides a default color that overrides material's ButtonStyle foregroundColor
//       // This is a workaround, the color of the icon is set here instead of the ButtonStyle.
//       icon(height: 20, color: color),
//       const SizedBox(width: 10),
//       Flexible(
//         child: Text(
//           text,
//         ),
//       ),
//     ],
//   );
// }
