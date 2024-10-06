import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A vertically stacked set of interactive headings that each reveal a section of content.
///
/// See:
/// * https://forui.dev/docs/accordion for working examples.
/// * [FAccordionController] for customizing the accordion's behavior.
/// * [FAccordionItem] for adding items to an accordion.
/// * [FAccordionStyle] for customizing an accordion's appearance.
class FAccordion extends StatefulWidget {
  /// The controller. Defaults to [FAccordionController.new].
  ///
  /// See:
  /// * [FAccordionController] for multiple selections.
  /// * [FAccordionController.radio] for a radio-like selection.
  final FAccordionController? controller;

  /// The style. Defaults to [FThemeData.accordionStyle].
  final FAccordionStyle? style;

  /// The children.
  final List<FAccordionItem> children;

  /// Creates a [FAccordion].
  const FAccordion({
    required this.children,
    this.controller,
    this.style,
    super.key,
  });

  @override
  State<FAccordion> createState() => _FAccordionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('items', children));
  }
}

class _FAccordionState extends State<FAccordion> {
  late FAccordionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FAccordionController();
  }

  @override
  void didUpdateWidget(covariant FAccordion old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    if (old.controller != null) {
      _controller.dispose();
    }
    _controller = widget.controller ?? FAccordionController();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? FTheme.of(context).accordionStyle;
    return Column(
      children: [
        for (final (index, child) in widget.children.indexed)
          FAccordionItemData(
            index: index,
            controller: _controller,
            style: style,
            child: child,
          ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// The [FAccordion]'s style.
final class FAccordionStyle with Diagnosticable {
  /// The title's default text style.
  final TextStyle titleTextStyle;

  /// The child's default text style.
  final TextStyle childTextStyle;

  /// The padding around the title.
  final EdgeInsets titlePadding;

  /// The padding around the content.
  final EdgeInsets childPadding;

  /// The icon's color.
  final Color iconColor;

  /// The icon's size. Defaults to 20.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [iconSize] is not positive.
  final double iconSize;

  /// The divider's color.
  final FDividerStyle dividerStyle;

  /// The expanding/collapsing animation duration.
  final Duration animationDuration;

  /// Creates a [FAccordionStyle].
  FAccordionStyle({
    required this.titleTextStyle,
    required this.childTextStyle,
    required this.titlePadding,
    required this.childPadding,
    required this.iconColor,
    required this.dividerStyle,
    this.iconSize = 20,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : assert(0 < iconSize, 'iconSize should be positive.');

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme].
  FAccordionStyle.inherit({required FStateColorScheme colorScheme, required FTypography typography})
      : this(
          titleTextStyle: typography.base.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.foreground,
          ),
          childTextStyle: typography.sm.copyWith(
            color: colorScheme.foreground,
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: 15),
          childPadding: const EdgeInsets.only(bottom: 15),
          iconColor: colorScheme.primary,
          dividerStyle: FDividerStyle(color: colorScheme.border, padding: EdgeInsets.zero),
        );

  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  @useResult
  FAccordionStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? childTextStyle,
    EdgeInsets? titlePadding,
    EdgeInsets? childPadding,
    Color? iconColor,
    double? iconSize,
    FDividerStyle? dividerStyle,
    Duration? animationDuration,
  }) =>
      FAccordionStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        childTextStyle: childTextStyle ?? this.childTextStyle,
        titlePadding: titlePadding ?? this.titlePadding,
        childPadding: childPadding ?? this.childPadding,
        iconColor: iconColor ?? this.iconColor,
        iconSize: iconSize ?? this.iconSize,
        dividerStyle: dividerStyle ?? this.dividerStyle,
        animationDuration: animationDuration ?? this.animationDuration,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', titleTextStyle))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle))
      ..add(DiagnosticsProperty('padding', titlePadding))
      ..add(DiagnosticsProperty('contentPadding', childPadding))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('animationDuration', animationDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAccordionStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          childTextStyle == other.childTextStyle &&
          titlePadding == other.titlePadding &&
          childPadding == other.childPadding &&
          iconColor == other.iconColor &&
          iconSize == other.iconSize &&
          animationDuration == other.animationDuration &&
          dividerStyle == other.dividerStyle;

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      childTextStyle.hashCode ^
      titlePadding.hashCode ^
      childPadding.hashCode ^
      iconColor.hashCode ^
      iconSize.hashCode ^
      animationDuration.hashCode ^
      dividerStyle.hashCode;
}

@internal
class FAccordionItemData extends InheritedWidget {
  @useResult
  static FAccordionItemData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FAccordionItemData>();
    assert(data != null, 'No FAccordionItemData found in context.');
    return data!;
  }

  final int index;
  final FAccordionController controller;
  final FAccordionStyle style;

  const FAccordionItemData({
    required this.index,
    required this.controller,
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FAccordionItemData old) =>
      index != old.index || controller != old.controller || style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style));
  }
}
