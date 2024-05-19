import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:sugar/collection.dart';

const _borderRadius = 8.0;
const _overlayOpacity = 0.20;
const _textStyle = TextStyle(
  overflow: TextOverflow.ellipsis,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);

/// [FButtonStyle]'s style.
class FButtonStyle {
  /// The primary style.
  final ButtonStyle primary;

  /// The secondary style.
  final ButtonStyle secondary;

  /// The destructive style.
  final ButtonStyle destructive;

  /// The outlined style.
  final ButtonStyle outlined;

  /// The link style.
  final ButtonStyle link;

  /// The text.
  final TextStyle text;

  /// The text.
  final FButtonContentStyle content;

  /// Creates a [FButtonStyle].
  const FButtonStyle({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outlined,
    required this.link,
    required this.text,
    required this.content,
  });

  /// Creates a [FButtonStyle] that inherits its properties from [data] and [style].
  FButtonStyle.inherit({required FFontData font, required FStyleData style})
      // TODO: How do I link the default buttonStyles to the corresponding Factory constructor
      : primary = _primaryStyle,
        secondary = _secondaryStyle,
        destructive = _destructiveStyle,
        outlined = _outlinedStyle,
        link = _linkStyle,
        text = ScaledTextStyle(_textStyle, font),
        content = FButtonContentStyle.inherit(style: style, font: font);
}

final _primaryStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.disabled) ? const Color(0xFFBFBFBF) : Colors.black,
  ),
  elevation: MaterialStateProperty.all(0),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  overlayColor: MaterialStateProperty.resolveWith(
    (states) => switch (states) {
      _ when !disjoint(states, const {MaterialState.hovered, MaterialState.focused, MaterialState.pressed}) =>
        Colors.white.withOpacity(_overlayOpacity),
      _ => null
    },
  ),
  splashFactory: NoSplash.splashFactory,
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
  ),
  textStyle: MaterialStateProperty.all(_textStyle),
);

final _secondaryStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(const Color(0xFFE4E5E7)),
  elevation: MaterialStateProperty.all(0),
  overlayColor: MaterialStateProperty.resolveWith(
    (states) => switch (states) {
      _ when !disjoint(states, const {MaterialState.hovered, MaterialState.focused, MaterialState.pressed}) =>
        Colors.white.withOpacity(0.3),
      _ => null
    },
  ),
  foregroundColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.disabled) ? Colors.white : Colors.black,
  ),
  splashFactory: NoSplash.splashFactory,
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
  ),
  textStyle: MaterialStateProperty.all(_textStyle),
);

final _destructiveStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.disabled) ? const Color(0xFFBFBFBF) : Colors.red,
  ),
  elevation: MaterialStateProperty.all(0),
  overlayColor: MaterialStateProperty.resolveWith(
    (states) => switch (states) {
      _ when !disjoint(states, const {MaterialState.hovered, MaterialState.focused, MaterialState.pressed}) =>
        Colors.white.withOpacity(_overlayOpacity),
      _ => null
    },
  ),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  splashFactory: NoSplash.splashFactory,
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
  ),
  textStyle: MaterialStateProperty.all(_textStyle),
);

final _outlinedStyle = ButtonStyle(
  side: MaterialStateProperty.all(const BorderSide(color: Color(0xFFE4E5E7))),
  elevation: MaterialStateProperty.all(0),
  backgroundColor: MaterialStateProperty.all(Colors.white),
  foregroundColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.disabled) ? const Color(0xFFBFBFBF) : Colors.black,
  ),
  overlayColor: MaterialStateProperty.all(const Color(0xFFE4E5E7)),
  splashFactory: NoSplash.splashFactory,
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
  ),
  textStyle: MaterialStateProperty.all(_textStyle),
);

final _linkStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
  foregroundColor: MaterialStateProperty.resolveWith(
    (states) => switch (states) {
      _ when !disjoint(states, const {MaterialState.hovered, MaterialState.focused, MaterialState.pressed}) =>
        Colors.black,
      _ when states.contains(MaterialState.disabled) => const Color(0xFFBFBFBF),
      _ => const Color(0xFF8E97AA),
    },
  ),
  overlayColor: MaterialStateProperty.all(Colors.transparent),
  splashFactory: NoSplash.splashFactory,
  shape: MaterialStateProperty.all(LinearBorder.bottom()),
  side: MaterialStateProperty.resolveWith(
    (states) => switch (states) {
      _ when !disjoint(states, const {MaterialState.hovered, MaterialState.focused, MaterialState.pressed}) =>
        const BorderSide(),
      _ when states.contains(MaterialState.disabled) => const BorderSide(color: Color(0xFFBFBFBF)),
      _ => const BorderSide(color: Color(0xFF8E97AA)),
    },
  ),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  visualDensity: VisualDensity.compact,
  padding: MaterialStateProperty.all(const EdgeInsets.only(bottom: 10)),
  minimumSize: MaterialStateProperty.all(Size.zero),
  textStyle: MaterialStateProperty.all(
    const TextStyle(
      color: Color(0xFF8E97AA),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  ),
);
