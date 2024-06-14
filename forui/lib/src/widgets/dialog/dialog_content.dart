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
    return IntrinsicWidth(
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
                  child: Text(
                    title!,
                    style: style.title.scale(typography),
                    textAlign: titleTextAlign,
                  ),
                ),
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Semantics(
                  container: true,
                  child: Text(
                    subtitle!,
                    style: style.subtitle.scale(typography),
                    textAlign: subtitleTextAlign,
                  ),
                ),
              ),
            _actions(context),
          ],
        ),
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
    mainAxisAlignment: MainAxisAlignment.end,
    children: separate(
      [
        for (final action in actions)
          IntrinsicWidth(
            child: action,
          ),
      ],
      by: [ SizedBox(width: style.actionPadding) ],
    ),
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
    children: separate(
      actions,
      by: [ SizedBox(height: style.actionPadding) ],
    ),
  );
}

/// The dialog content's style.
final class FDialogContentStyle with Diagnosticable {
  /// The padding surrounding the content.
  final EdgeInsets padding;

  /// The title style.
  final TextStyle title;

  /// The subtitle style.
  final TextStyle subtitle;

  /// The padding between actions.
  final double actionPadding;
  
  /// Creates a [FDialogContentStyle].
  FDialogContentStyle({
    required this.padding,
    required this.title,
    required this.subtitle,
    required this.actionPadding,
  });
  
  /// Creates a [FDialogContentStyle] that inherits its properties from [colorScheme] and [typography].
  FDialogContentStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required this.padding,
    required this.actionPadding,
  }):
    title = TextStyle(
      fontSize: typography.lg,
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
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DoubleProperty('actionPadding', actionPadding));
  }
}
