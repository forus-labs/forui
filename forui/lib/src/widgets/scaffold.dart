import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A scaffold.
///
/// A scaffold is a layout structure that contains a header, content, and footer.
/// It is highly recommended to use a scaffold when creating a page even if a header and footer are not required.
///
/// See:
/// * https://forui.dev/docs/scaffold for working examples.
/// * [FScaffoldStyle] for customizing a scaffold's appearance.
class FScaffold extends StatelessWidget {
  /// The content.
  final Widget content;

  /// The header.
  final Widget? header;

  /// The footer.
  final Widget? footer;

  /// True if [FScaffoldStyle.contentPadding] should be applied to the [content]. Defaults to `true`.
  final bool contentPad;

  /// The style. Defaults to [FThemeData.scaffoldStyle].
  final FScaffoldStyle? style;

  /// Creates a [FScaffold].
  const FScaffold({
    required this.content,
    this.header,
    this.footer,
    this.contentPad = true,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.scaffoldStyle;
    Widget content = this.content;

    if (contentPad) {
      content = Padding(padding: style.contentPadding, child: content);
    }

    return ColoredBox(
      color: style.backgroundColor,
      child: Column(
        children: [
          if (header != null) DecoratedBox(decoration: style.headerDecoration, child: header!),
          Expanded(child: content),
          if (footer != null) DecoratedBox(decoration: style.footerDecoration, child: footer!),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('contentPad', value: contentPad, defaultValue: true, ifTrue: 'pad'));
  }
}

/// [FScaffold]'s style.
final class FScaffoldStyle with Diagnosticable {
  /// The background color.
  final Color backgroundColor;

  /// The content padding. Only used when [FScaffold.contentPad] is `true`.
  final EdgeInsets contentPadding;

  /// The header decoration.
  final BoxDecoration headerDecoration;

  /// The footer decoration.
  final BoxDecoration footerDecoration;

  /// Creates a [FScaffoldStyle].
  FScaffoldStyle({
    required this.backgroundColor,
    required this.contentPadding,
    required this.headerDecoration,
    required this.footerDecoration,
  });

  /// Creates a [FScaffoldStyle] that inherits its properties from the provided [colorScheme] and [style].
  FScaffoldStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : backgroundColor = colorScheme.background,
        contentPadding = style.pagePadding.copyWith(top: 0, bottom: 0),
        headerDecoration = const BoxDecoration(),
        footerDecoration = BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorScheme.border,
              width: style.borderWidth,
            ),
          ),
        );

  /// Returns a copy of this style with the provided properties replaced.
  @useResult
  FScaffoldStyle copyWith({
    Color? backgroundColor,
    EdgeInsets? contentPadding,
    BoxDecoration? headerDecoration,
    BoxDecoration? footerDecoration,
  }) =>
      FScaffoldStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        contentPadding: contentPadding ?? this.contentPadding,
        headerDecoration: headerDecoration ?? this.headerDecoration,
        footerDecoration: footerDecoration ?? this.footerDecoration,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration))
      ..add(DiagnosticsProperty('footerDecoration', footerDecoration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FScaffoldStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          contentPadding == other.contentPadding &&
          headerDecoration == other.headerDecoration &&
          footerDecoration == other.footerDecoration;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^ contentPadding.hashCode ^ headerDecoration.hashCode ^ footerDecoration.hashCode;
}
