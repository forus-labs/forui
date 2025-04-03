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

  /// Creates a [_FNestedHeader].
  const _FNestedHeader({
    this.style,
    this.prefixes = const [],
    this.suffixes = const [],
    super.title = const SizedBox(),
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
            child:
                prefixes.isEmpty && suffixes.isEmpty
                    ? header
                    : Stack(
                      children: [
                        Positioned.fill(child: header),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children:
                                  prefixes.expand((action) => [action, SizedBox(width: style.actionSpacing)]).toList(),
                            ),
                            Row(
                              children:
                                  suffixes.expand((action) => [SizedBox(width: style.actionSpacing), action]).toList(),
                            ),
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
    properties.add(DiagnosticsProperty('style', style));
  }
}
