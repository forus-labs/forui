part of 'header.dart';

/// A root header.
///
/// A root header contains the page's title and actions.
/// It is typically used on pages at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
/// * [FRootHeaderStyle] for customizing a header's appearance.
final class _FRootHeader extends FHeader {
  /// The header's style.
  final FRootHeaderStyle? style;

  /// The title, aligned to the left in LTR locales.
  ///
  /// It is aligned to the right in RTL locales.
  final Widget title;

  /// The actions, aligned to the right in LTR locales. Defaults to an empty list.
  ///
  /// They are aligned to the left in RTL locales.
  final List<Widget> actions;

  /// Creates a [FHeader].
  const _FRootHeader({required this.title, this.style, this.actions = const [], super.key}) : super._();

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
final class FRootHeaderStyle with Diagnosticable, _$FRootHeaderStyleFunctions {
  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]'s style.
  @override
  final FHeaderActionStyle actionStyle;

  /// The spacing between [FHeaderAction]s. Defaults to 10.
  @override
  final double actionSpacing;

  /// The padding.
  @override
  final EdgeInsets padding;

  /// Creates a [FRootHeaderStyle].
  FRootHeaderStyle({
    required this.titleTextStyle,
    required this.actionStyle,
    required this.padding,
    this.actionSpacing = 10,
  });

  /// Creates a [FRootHeaderStyle] that inherits its properties from the given [FColorScheme], [FTypography] and
  /// [FStyle].
  FRootHeaderStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        titleTextStyle: typography.xl3.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w700, height: 1),
        actionStyle: FHeaderActionStyle.inherit(colorScheme: colorScheme, style: style, size: 30),
        padding: style.pagePadding.copyWith(bottom: 15),
      );
}
