part of 'dialog.dart';

@internal sealed class FDialogContent extends StatelessWidget {
  final FDialogContentStyle style;
  final CrossAxisAlignment alignment;
  final String? title;
  final TextAlign titleTextAlign;
  final String? subtitle;
  final TextAlign subtitleTextAlign;
  final List<Widget> actions;

  const FDialogContent({
    required this.style, 
    required this.alignment, 
    required this.titleTextAlign, 
    required this.subtitleTextAlign,
    required this.actions, 
    this.title, 
    this.subtitle,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return Padding(
      padding: style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title!,
                style: style.title.scale(typography),
                textAlign: titleTextAlign,
              ),
            ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                subtitle!,
                style: style.subtitle.scale(typography),
                textAlign: subtitleTextAlign,
              ),
            ),
          _actions(context),
        ],
      ),
    );
  }
  
  Widget _actions(BuildContext context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty('titleTextAlign', titleTextAlign))
      ..add(StringProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('subtitleTextAlign', subtitleTextAlign))
      ..add(IterableProperty('actions', actions));
  }
}

@internal class FHorizontalDialogContent extends FDialogContent {
  const FHorizontalDialogContent({
    required super.style,
    required super.title,
    required super.subtitle,
    required super.actions,
  }): super(
      alignment: CrossAxisAlignment.start,
      titleTextAlign: TextAlign.start,
      subtitleTextAlign: TextAlign.start
  );

  @override
  Widget _actions(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      for (final action in actions)
        Expanded(
          child: Padding(
            padding: style.actionPadding,
            child: action,
          ),
        ),
    ],
  );
}


@internal class FVerticalDialogContent extends FDialogContent {
  const FVerticalDialogContent({
    required super.style,
    required super.title,
    required super.subtitle,
    required super.actions,
  }): super(
    alignment: CrossAxisAlignment.center,
    titleTextAlign: TextAlign.center,
    subtitleTextAlign: TextAlign.center
  );

  @override
  Widget _actions(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final action in actions)
        Padding(
          padding: style.actionPadding,
          child: action,
        ),
    ],
  );
}

/// The dialog content's style.
final class FDialogContentStyle with Diagnosticable {
  /// The padding surrounding the content.
  final EdgeInsets padding;

  /// The padding surrounding each action.
  final EdgeInsets actionPadding;

  /// The title style.
  final TextStyle title;

  /// The subtitle style.
  final TextStyle subtitle;
  
  /// Creates a [FDialogContentStyle].
  FDialogContentStyle({
    required this.title,
    required this.subtitle,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 16), 
    this.actionPadding = const EdgeInsets.symmetric(vertical: 7.0),
  });
  
  /// Creates a [FDialogContentStyle] that inherits its properties from [colorScheme] and [typography].
  FDialogContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography}):
    padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
    actionPadding = const EdgeInsets.symmetric(vertical: 7.0),
    title = TextStyle(
      fontSize: typography.base,
      fontWeight: FontWeight.w600,
      color: colorScheme.foreground,
    ),
    subtitle = TextStyle(
      fontSize: typography.sm,
      color: colorScheme.mutedForeground,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('actionPadding', actionPadding))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('subtitle', subtitle));
  }
}
