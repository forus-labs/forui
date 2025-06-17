part of 'header.dart';

/// A nested header.
///
/// A nested header contains the page's title and actions (including pop navigation).
/// It is typically used on pages that are not at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
/// * [FHeaderStyle] for customizing a header's appearance.
class _FNestedHeader extends FHeader {
  /// The style.
  final FHeaderStyle? style;

  /// The actions, aligned to the left in LTR locales. Defaults to an empty list.
  ///
  /// They are aligned to the right in RTL locales.
  final List<Widget> prefixes;

  /// The actions, aligned to the right. Defaults to an empty list.
  ///
  /// They are aligned to the left in RTL locales.
  final List<Widget> suffixes;

  /// The title's alignment.
  final AlignmentGeometry titleAlignment;

  /// Creates a [_FNestedHeader].
  const _FNestedHeader({
    this.style,
    this.prefixes = const [],
    this.suffixes = const [],
    this.titleAlignment = Alignment.center,
    super.title = const SizedBox(),
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyles.nestedStyle;
    final alignment = titleAlignment.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    Widget title = Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DefaultTextStyle.merge(
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: style.titleTextStyle,
          child: this.title,
        ),
      ),
    );

    if (prefixes.isNotEmpty || suffixes.isNotEmpty) {
      final spacing = SizedBox(width: style.actionSpacing);
      final prefixes = Row(
        mainAxisSize: MainAxisSize.min,
        children: separate(this.prefixes, by: [spacing]),
      );
      final suffixes = Row(
        mainAxisSize: MainAxisSize.min,
        children: separate(this.suffixes, by: [spacing]),
      );

      // We use a stack as a row could result in the title being off centered if the icon on the left or right is
      // missing/different sizes.
      title = alignment.x == 0
          ? Stack(
              children: [
                title,
                Align(alignment: Alignment.centerLeft, child: prefixes),
                Align(alignment: Alignment.centerRight, child: suffixes),
              ],
            )
          : Row(
              children: [
                prefixes,
                Expanded(child: title),
                suffixes,
              ],
            );
    }

    Widget header = SafeArea(
      bottom: false,
      child: Semantics(
        header: true,
        child: DecoratedBox(
          decoration: style.decoration,
          child: Padding(
            padding: style.padding,
            child: FHeaderData(actionStyle: style.actionStyle, child: title),
          ),
        ),
      ),
    );

    if (style.backgroundFilter case final filter?) {
      header = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(filter: filter, child: Container()),
            ),
          ),
          header,
        ],
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(value: style.systemOverlayStyle, child: header);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('titleAlignment', titleAlignment));
  }
}
