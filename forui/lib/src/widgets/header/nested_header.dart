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

  /// Controls the alignment of the title widget.
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
    final style = this.style ?? context.theme.headerStyle.nestedStyle;
    final hasPrefix = prefixes.isNotEmpty;
    final hasSuffix = suffixes.isNotEmpty;
    final isCenterAligned = titleAlignment == Alignment.center;

    final titleWidget = Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: DefaultTextStyle.merge(
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style: style.titleTextStyle,
      child: title,
    ));

    return SafeArea(
      bottom: false,
      child: Semantics(
        header: true,
        child: Padding(
          padding: style.padding,
          child: FHeaderData(
            actionStyle: style.actionStyle,
            child: _buildLayout(titleWidget, hasPrefix, hasSuffix, isCenterAligned, style),
          ),
        ),
      ),
    );
  }

  /// Builds the layout based on presence of prefixes, suffixes, and title alignment
  Widget _buildLayout(Widget titleWidget, bool hasPrefix, bool hasSuffix, bool isCenterAligned, FHeaderStyle style) {
    // Simple case - just the title
    if (!hasPrefix && !hasSuffix) {
      return Align(alignment: titleAlignment, child: titleWidget);
    }

    // Center-aligned title uses a stack
    if (isCenterAligned) {
      return Stack(
        children: [
          Align(child: titleWidget),
          if (hasPrefix) Align(alignment: Alignment.centerLeft, child: _buildActions(prefixes, style)),
          if (hasSuffix)
            Align(alignment: Alignment.centerRight, child: _buildActions(suffixes, style, isPrefix: false)),
        ],
      );
    }

    // Non-centered title uses Row
    return Row(
      children: [
        if (hasPrefix) _buildActions(prefixes, style),
        Expanded(child: Align(alignment: titleAlignment, child: titleWidget)),
        if (hasSuffix) _buildActions(suffixes, style, isPrefix: false),
      ],
    );
  }

  /// Builds action widgets with appropriate spacing
  Widget _buildActions(List<Widget> actions, FHeaderStyle style, {bool isPrefix = true}) {
    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(actions.length * 2 - 1, (index) {
        final isAction = index.isEven;
        final actionIndex = index ~/ 2;

        return isAction ? actions[actionIndex] : SizedBox(width: style.actionSpacing);
      }),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty<AlignmentGeometry>('titleAlignment', titleAlignment));
  }
}
