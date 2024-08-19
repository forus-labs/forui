part of 'header.dart';

/// A root header.
///
/// A root header contains the page's title and actions.
/// It is typically used on pages at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/header for working examples.
/// * [FRootHeaderStyle] for customizing a header's appearance.
final class _FRootHeader extends FHeader {
  /// The header's style. Defaults to [FThemeData.headerStyle.rootStyle].
  final FRootHeaderStyle? style;

  /// The title, aligned to the left.
  final Widget title;

  /// The actions, aligned to the right. Defaults to an empty list.
  final List<Widget> actions;

  /// Creates a [FHeader].
  const _FRootHeader({
    required this.title,
    this.style,
    this.actions = const [],
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle.rootStyle;

    return SafeArea(
      bottom: false,
      child: Semantics(
        header: true,
        child: Padding(
          padding: style.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DefaultTextStyle.merge(
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: style.titleTextStyle,
                  child: title,
                ),
              ),
              FHeaderData(
                actionStyle: style.actionStyle,
                child: Row(children: actions.expand((action) => [action, const SizedBox(width: 10)]).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('title', title))
      ..add(IterableProperty('actions', actions));
  }
}

/// [FHeader.new]'s style.
final class FRootHeaderStyle with Diagnosticable {
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]'s style.
  final FHeaderActionStyle actionStyle;

  /// The spacing between [FHeaderAction]s.
  final double actionSpacing;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FRootHeaderStyle].
  FRootHeaderStyle({
    required this.titleTextStyle,
    required this.actionStyle,
    required this.actionSpacing,
    required this.padding,
  });

  /// Creates a [FRootHeaderStyle] that inherits its properties from the given [FColorScheme], [FTypography] and [FStyle].
  FRootHeaderStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  })  : titleTextStyle = typography.xl3.copyWith(
          color: colorScheme.foreground,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
        actionStyle = FHeaderActionStyle.inherit(colorScheme: colorScheme, size: 30),
        actionSpacing = 10,
        padding = style.pagePadding.copyWith(bottom: 15);

  /// Returns a copy of this [FRootHeaderStyle] with the given properties replaced.
  @useResult
  FRootHeaderStyle copyWith({
    TextStyle? titleTextStyle,
    FHeaderActionStyle? actionStyle,
    double? actionSpacing,
    EdgeInsets? padding,
  }) =>
      FRootHeaderStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        actionStyle: actionStyle ?? this.actionStyle,
        actionSpacing: actionSpacing ?? this.actionSpacing,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('action', actionStyle))
      ..add(DoubleProperty('actionSpacing', actionSpacing))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FRootHeaderStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          actionStyle == other.actionStyle &&
          actionSpacing == other.actionSpacing &&
          padding == other.padding;

  @override
  int get hashCode => titleTextStyle.hashCode ^ actionStyle.hashCode ^ actionSpacing.hashCode ^ padding.hashCode;
}
