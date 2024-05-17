import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A [FButton] widget.
abstract class FButton extends StatelessWidget {
  /// The style.
  final FButtonStyle? style;

  /// This FButton's content.
  final Widget content;

  /// Called when the FButton is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// Creates a [FButton] widget.
  const FButton._({
    required this.content,
    required this.onPressed,
    this.style,
    super.key,
  });

  /// Creates a primary [FButton].
  ///
  /// ```dart
  /// FButton.primary(
  ///   content: FTextButtonContent('Example'),
  ///   onPressed: (){}
  /// );
  /// ```
  factory FButton.primary({
    required Widget content,
    required VoidCallback? onPressed,
    FButtonStyle? style,
    Key? key,
  }) =>
      _FlatButton(
        key: key,
        style: style,
        content: content,
        onPressed: onPressed,
      );

  /// Creates a secondary [FButton].
  ///
  /// ```dart
  /// FButton.secondary(
  ///   content: FTextButtonContent('Example'),
  ///   onPressed: (){}
  /// );
  /// ```
  factory FButton.secondary({
    required Widget content,
    required VoidCallback? onPressed,
    FButtonStyle? style,
    Key? key,
  }) =>
      // TODO: How do I link the default buttonStyles to the corresponding Factory constructor
      _FlatButton(
        key: key,
        style: style,
        content: content,
        onPressed: onPressed,
      );

  /// Creates a destructive [FButton].
  ///
  /// ```dart
  /// FButton.destructive(
  ///   content: FTextButtonContent('Example'),
  ///   onPressed: (){}
  /// );
  /// ```
  factory FButton.destructive({
    required Widget content,
    required VoidCallback? onPressed,
    FButtonStyle? style,
    Key? key,
  }) =>
      _FlatButton(
        key: key,
        style: style,
        content: content,
        onPressed: onPressed,
      );

  /// Creates an outlined [FButton].
  ///
  /// ```dart
  /// FButton.outline(
  ///   content: FTextButtonContent('Example'),
  ///   onPressed: (){}
  /// );
  /// ```
  factory FButton.outlined({
    required Widget content,
    required VoidCallback? onPressed,
    FButtonStyle? style,
    Key? key,
  }) =>
      _OutlinedButton(
        key: key,
        style: style,
        content: content,
        onPressed: onPressed,
      );
}

class _FlatButton extends FButton {
  const _FlatButton({
    required super.content,
    required super.onPressed,
    super.style,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    // TODO: Insert button type here?
    final style = this.style ?? FTheme.of(context).widgets.button;

    return FTappable(
      onPressed: onPressed,
      builder: (context, onPressed) => ElevatedButton(
        style: style.button,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 17,
          ),
          child: content,
        ),
      ),
    );
  }
}

class _OutlinedButton extends FButton {
  const _OutlinedButton({
    required super.content,
    required super.onPressed,
    super.style,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgets.button;

    return FTappable(
      onPressed: onPressed,
      builder: (context, onPressed) => OutlinedButton(
        style: style.button,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 17,
          ),
          child: content,
        ),
      ),
    );
  }
}
