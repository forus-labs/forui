part of 'rating.dart';

class _RatingContent extends StatelessWidget {
  final double value;
  final int count;
  final double spacing;
  final Widget filledIcon;
  final Widget emptyIcon;
  final Widget? halfFilledIcon;
  final FRatingStyle style;
  final FThemeData theme;
  final String? semanticsLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;

  const _RatingContent({
    required this.value,
    required this.count,
    required this.spacing,
    required this.filledIcon,
    required this.emptyIcon,
    required this.style,
    required this.theme,
    required this.autofocus,
    this.halfFilledIcon,
    this.semanticsLabel,
    this.focusNode,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticsLabel ?? 'Rating: ${value.toStringAsFixed(1)} of $count',
    child: Focus(
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      child: LayoutBuilder(
        builder:
            (context, constraints) =>
                Row(mainAxisSize: MainAxisSize.min, children: List.generate(count, _buildRatingItem)),
      ),
    ),
  );

  Widget _buildRatingItem(int index) {
    final itemValue = index + 1.0;
    final Widget icon;

    if (itemValue <= value) {
      icon = filledIcon;
    } else if (halfFilledIcon != null && (itemValue - 0.5) <= value && value < itemValue) {
      icon = halfFilledIcon ?? filledIcon;
    } else {
      icon = emptyIcon;
    }

    return Padding(
      padding: EdgeInsets.only(right: index < count - 1 ? spacing : 0),
      child: IconTheme(
        data: IconThemeData(color: style.color ?? theme.colors.primary, size: style.size ?? 24.0),
        child: icon,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('value', value))
      ..add(IntProperty('count', count))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty<FRatingStyle>('style', style))
      ..add(DiagnosticsProperty<FThemeData>('theme', theme))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(DiagnosticsProperty<bool>('autofocus', autofocus))
      ..add(ObjectFlagProperty<ValueChanged<bool>?>.has('onFocusChange', onFocusChange));
  }
}
