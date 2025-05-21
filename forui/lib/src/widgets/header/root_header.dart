part of 'header.dart';

/// A root header.
///
/// A root header contains the page's title and actions.
/// It is typically used on pages at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
class _FRootHeader extends FHeader {
  /// The header's style.
  final FHeaderStyle? style;

  /// The actions, aligned to the right in LTR locales. Defaults to an empty list.
  ///
  /// They are aligned to the left in RTL locales.
  final List<Widget> suffixes;

  /// Creates a [FHeader].
  const _FRootHeader({
    this.style,
    this.suffixes = const [],
    super.title,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyles.rootStyle;
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
                child: Row(
                  children:
                      suffixes
                          .expand(
                            (action) => [
                              SizedBox(width: style.actionSpacing),
                              action,
                            ],
                          )
                          .toList(),
                ),
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
    properties.add(DiagnosticsProperty('style', style));
  }
}
