import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

@internal
sealed class Content extends StatelessWidget {
  final FDialogContentStyle style;
  final CrossAxisAlignment alignment;
  final Widget? title;
  final TextAlign titleTextAlign;
  final Widget? body;
  final TextAlign bodyTextAlign;
  final List<Widget> actions;

  const Content({
    required this.style,
    required this.alignment,
    required this.title,
    required this.titleTextAlign,
    required this.body,
    required this.bodyTextAlign,
    required this.actions,
    super.key,
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
                  padding: const EdgeInsets.only(bottom: 4),
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
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Semantics(
                    container: true,
                    child: DefaultTextStyle.merge(
                      textAlign: bodyTextAlign,
                      style: style.bodyTextStyle,
                      child: body!,
                    ),
                  ),
                ),
              if (title != null && body != null) const SizedBox(height: 8),
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
      ..add(EnumProperty('alignment', alignment))
      ..add(EnumProperty('titleTextAlign', titleTextAlign))
      ..add(EnumProperty('bodyTextAlign', bodyTextAlign))
      ..add(IterableProperty('actions', actions));
  }
}

@internal
class HorizontalContent extends Content {
  const HorizontalContent({
    required super.style,
    required super.title,
    required super.body,
    required super.actions,
    super.key,
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

@internal
class VerticalContent extends Content {
  const VerticalContent({
    required super.style,
    required super.title,
    required super.body,
    required super.actions,
    super.key,
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
