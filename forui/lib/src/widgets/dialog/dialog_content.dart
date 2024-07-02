part of 'dialog.dart';

sealed class _FDialogContent extends StatelessWidget {
  final FDialogContentStyle style;
  final CrossAxisAlignment alignment;
  final Widget? title;
  final TextAlign titleTextAlign;
  final Widget? body;
  final TextAlign bodyTextAlign;
  final List<Widget> actions;

  const _FDialogContent({
    required this.style,
    required this.alignment,
    required this.title,
    required this.titleTextAlign,
    required this.body,
    required this.bodyTextAlign,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) => IntrinsicWidth(
        child: Padding(
          padding: style.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: alignment,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Semantics(
                    container: true,
                    child: DefaultTextStyle.merge(
                      textAlign: titleTextAlign,
                      style: style.titleTextStyle,
                      child: title!,
                    ),
                  ),
                ),
              if (body != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Semantics(
                    container: true,
                    child: DefaultTextStyle.merge(
                      textAlign: bodyTextAlign,
                      style: style.bodyTextStyle,
                      child: body!,
                    ),
                  ),
                ),
              _actions(context),
            ],
          ),
        ),
      );

  Widget _actions(BuildContext context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('titleTextAlign', titleTextAlign))
      ..add(DiagnosticsProperty('bodyTextAlign', bodyTextAlign))
      ..add(IterableProperty('actions', actions));
  }
}

class _FHorizontalDialogContent extends _FDialogContent {
  const _FHorizontalDialogContent({
    required super.style,
    required super.title,
    required super.body,
    required super.actions,
  }) : super(alignment: CrossAxisAlignment.start, titleTextAlign: TextAlign.start, bodyTextAlign: TextAlign.start);

  @override
  Widget _actions(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: separate(
          [
            for (final action in actions) IntrinsicWidth(child: action),
          ],
          by: [SizedBox(width: style.actionPadding)],
        ),
      );
}

class _FVerticalDialogContent extends _FDialogContent {
  const _FVerticalDialogContent({
    required super.style,
    required super.title,
    required super.body,
    required super.actions,
  }) : super(alignment: CrossAxisAlignment.center, titleTextAlign: TextAlign.center, bodyTextAlign: TextAlign.center);

  @override
  Widget _actions(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: separate(
          actions,
          by: [SizedBox(height: style.actionPadding)],
        ),
      );
}

/// [FDialog] content's style.
final class FDialogContentStyle with Diagnosticable {
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The body's [TextStyle].
  final TextStyle bodyTextStyle;

  /// The padding surrounding the content.
  final EdgeInsets padding;

  /// The space between actions.
  final double actionPadding;

  /// Creates a [FDialogContentStyle].
  FDialogContentStyle({
    required this.titleTextStyle,
    required this.bodyTextStyle,
    required this.padding,
    required this.actionPadding,
  });

  /// Creates a [FDialogContentStyle] that inherits its properties from [colorScheme] and [typography].
  FDialogContentStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required this.padding,
    required this.actionPadding,
  })  : titleTextStyle = typography.lg.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground,
        ),
        bodyTextStyle = typography.sm.copyWith(color: colorScheme.mutedForeground);

  /// Returns a copy of this [FDialogContentStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FDialogContentStyle(
  ///   titleTextStyle: ...,
  ///   bodyTextStyle: ...,
  ///   // other properties omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   bodyTextStyle: ...,
  /// );
  ///
  /// print(style.titleTextStyle == copy.titleTextStyle); // true
  /// print(style.bodyTextStyle == copy.bodyTextStyle); // false
  /// ```
  @useResult
  FDialogContentStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
    EdgeInsets? padding,
    double? actionPadding,
  }) =>
      FDialogContentStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
        padding: padding ?? this.padding,
        actionPadding: actionPadding ?? this.actionPadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('bodyTextStyle', bodyTextStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('actionPadding', actionPadding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDialogContentStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          bodyTextStyle == other.bodyTextStyle &&
          padding == other.padding &&
          actionPadding == other.actionPadding;

  @override
  int get hashCode => titleTextStyle.hashCode ^ bodyTextStyle.hashCode ^ padding.hashCode ^ actionPadding.hashCode;
}
