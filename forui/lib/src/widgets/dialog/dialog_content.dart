import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'dialog_content.design.dart';

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
  Widget build(BuildContext context) => Padding(
    padding: style.padding,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        if (title case final title?)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Semantics(
              container: true,
              child: DefaultTextStyle.merge(textAlign: titleTextAlign, style: style.titleTextStyle, child: title),
            ),
          ),
        if (body case final body?)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Semantics(
                container: true,
                child: DefaultTextStyle.merge(textAlign: bodyTextAlign, style: style.bodyTextStyle, child: body),
              ),
            ),
          ),
        if (title != null && body != null) const SizedBox(height: 8),
        _actions(context),
      ],
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
  Widget _actions(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.end, spacing: style.actionSpacing, children: actions);
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
  Widget _actions(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.min, spacing: style.actionSpacing, children: actions);
}

/// [FDialog] content's style.
class FDialogContentStyle with Diagnosticable, _$FDialogContentStyleFunctions {
  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The body's [TextStyle].
  @override
  final TextStyle bodyTextStyle;

  /// The padding surrounding the content.
  @override
  final EdgeInsetsGeometry padding;

  /// The space between actions.
  @override
  final double actionSpacing;

  /// Creates a [FDialogContentStyle].
  FDialogContentStyle({
    required this.titleTextStyle,
    required this.bodyTextStyle,
    required this.padding,
    required this.actionSpacing,
  });
}
