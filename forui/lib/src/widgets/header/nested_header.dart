part of 'header.dart';

/// A nested header.
///
/// A nested header contains the page's title and actions (including pop navigation).
/// It is typically used on pages that are not at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
/// * [FNestedHeaderStyle] for customizing a header's appearance.
final class _FNestedHeader extends FHeader {
  /// The style.
  final FNestedHeaderStyle? style;

  /// The title, aligned to the center.
  final Widget title;

  /// The actions, aligned to the left in LTR locales. Defaults to an empty list.
  ///
  /// They are aligned to the right in RTL locales.
  final List<Widget> prefixActions;

  /// The actions, aligned to the right. Defaults to an empty list.
  ///
  /// They are aligned to the left in RTL locales.
  final List<Widget> suffixActions;

  /// Creates a [_FNestedHeader].
  const _FNestedHeader({
    required this.title,
    this.style,
    this.prefixActions = const [],
    this.suffixActions = const [],
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle.nestedStyle;

    final header = Align(
      child: DefaultTextStyle.merge(
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        style: style.titleTextStyle,
        child: title,
      ),
    );

    return SafeArea(
      bottom: false,
      child: Semantics(
        header: true,
        child: Padding(
          padding: style.padding,
          child: FHeaderData(
            actionStyle: style.actionStyle,
            child: prefixActions.isEmpty && suffixActions.isEmpty
                ? header
                : Stack(
                    children: [
                      Positioned.fill(child: header),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: prefixActions.expand((action) => [action, const SizedBox(width: 10)]).toList()),
                          Row(children: suffixActions.expand((action) => [const SizedBox(width: 10), action]).toList()),
                        ],
                      ),
                    ],
                  ),
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
      ..add(IterableProperty('leftActions', prefixActions))
      ..add(IterableProperty('rightActions', suffixActions));
  }
}

/// [FHeader.nested]'s style.
final class FNestedHeaderStyle with Diagnosticable {
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]s' style.
  final FHeaderActionStyle actionStyle;

  /// The spacing between [FHeaderAction]s. Defaults to 10.
  final double actionSpacing;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FNestedHeaderStyle].
  const FNestedHeaderStyle({
    required this.titleTextStyle,
    required this.actionStyle,
    required this.padding,
    this.actionSpacing = 10,
  });

  /// Creates a [FNestedHeaderStyle] that inherits its properties from the given [FColorScheme], [FTypography] and
  /// [FStyle].
  FNestedHeaderStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          titleTextStyle: typography.xl.copyWith(
            color: colorScheme.foreground,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
          actionStyle: FHeaderActionStyle.inherit(colorScheme: colorScheme, style: style, size: 25),
          padding: style.pagePadding.copyWith(bottom: 15),
        );

  /// Returns a copy of this [FNestedHeaderStyle] with the given properties replaced.
  @useResult
  FNestedHeaderStyle copyWith({
    TextStyle? titleTextStyle,
    FHeaderActionStyle? actionStyle,
    double? actionSpacing,
    EdgeInsets? padding,
  }) =>
      FNestedHeaderStyle(
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
      ..add(DiagnosticsProperty('actionStyle', actionStyle))
      ..add(DoubleProperty('actionSpacing', actionSpacing))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FNestedHeaderStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          actionStyle == other.actionStyle &&
          actionSpacing == other.actionSpacing &&
          padding == other.padding;

  @override
  int get hashCode => titleTextStyle.hashCode ^ actionStyle.hashCode ^ actionSpacing.hashCode ^ padding.hashCode;
}
