part of 'header.dart';

/// A nested header.
///
/// A nested header contains the page's title and actions (including pop navigation).
/// It is typically used on pages that are not at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
/// * [FHeaderStyle] for customizing a header's appearance.
final class _FNestedHeader extends FHeader {
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
  
  final TextAlign titleAlignment;

  /// Creates a [_FNestedHeader].
  const _FNestedHeader({
    this.style,
    this.prefixes = const [],
    this.suffixes = const [],
    super.title = const SizedBox(),
    this.titleAlignment = TextAlign.center,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle.nestedStyle;

    final header = DefaultTextStyle.merge(
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        style: style.titleTextStyle,
        child: title,
        textAlign: titleAlignment,
      );

    return SafeArea(
      bottom: false,
      child: Semantics(
        header: true,
        child: Padding(
          padding: style.padding,
          child: FHeaderData(
            actionStyle: style.actionStyle,
            child:
                prefixes.isEmpty && suffixes.isEmpty
                    ? header
                    : Row(
  children: [
    if (prefixes.isNotEmpty)
      Row(
        mainAxisSize: MainAxisSize.min,
        children: prefixes.expand((action) => [action, SizedBox(width: style.actionSpacing)]).toList()
          ..removeLast(), // Remove the last spacing
      ),
    Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: style.actionSpacing),
        child: header,
      ),
    ),
    if (suffixes.isNotEmpty)
      Row(
        mainAxisSize: MainAxisSize.min,
        children: suffixes.expand((action) => [SizedBox(width: style.actionSpacing), action]).toList()
          ..removeAt(0), // Remove the first spacing
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
    properties..add(DiagnosticsProperty('style', style))
    ..add(DiagnosticsProperty<TextAlign>('titleAlignment', titleAlignment));
  }
}
