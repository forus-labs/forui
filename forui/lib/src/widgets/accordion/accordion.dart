import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A vertically stacked set of interactive headings that each reveal a section of content.
///
/// See:
/// * https://forui.dev/docs/data/accordion for working examples.
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

  /// The items.
  final List<FAccordionItem> items;

  /// Creates a [FAccordion].
  const FAccordion({
    required this.items,
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
      ..add(IterableProperty('items', items));
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
        for (final (index, child) in widget.items.indexed)
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

  /// The padding around the title. Defaults to `EdgeInsets.symmetric(vertical: 15)`.
  final EdgeInsets titlePadding;

  /// The padding around the content. Defaults to `EdgeInsets.only(bottom: 15)`.
  final EdgeInsets childPadding;

  /// The icon's color.
  final Color iconColor;

  /// The icon's size. Defaults to 20.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [iconSize] is not positive.
  final double iconSize;

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The divider's color.
  final FDividerStyle dividerStyle;

  /// The expanding/collapsing animation duration. Defaults to 200ms.
  final Duration animationDuration;

  /// Creates a [FAccordionStyle].
  FAccordionStyle({
    required this.titleTextStyle,
    required this.childTextStyle,
    required this.iconColor,
    required this.focusedOutlineStyle,
    required this.dividerStyle,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 15),
    this.childPadding = const EdgeInsets.only(bottom: 15),
    this.iconSize = 20,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : assert(0 < iconSize, 'iconSize should be positive.');

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme].
  FAccordionStyle.inherit({required FColorScheme colorScheme, required FStyle style, required FTypography typography})
      : this(
          titleTextStyle: typography.base.copyWith(fontWeight: FontWeight.w500, color: colorScheme.foreground),
          childTextStyle: typography.sm.copyWith(color: colorScheme.foreground),
          iconColor: colorScheme.primary,
          iconSize: 20,
          focusedOutlineStyle: style.focusedOutlineStyle,
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
    FFocusedOutlineStyle? focusedOutlineStyle,
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
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
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
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
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
          focusedOutlineStyle == other.focusedOutlineStyle &&
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
      focusedOutlineStyle.hashCode ^
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

// T self<T>(T t) => t;
//
// // Simulates a parent style/FThemeData.
// void OtherStyle({
//   required AStyle style,
// }) {}
//
// class AStyle {
//   final int foo;
//   final int bar;
//   final BStyle b;
//
//   AStyle({required this.foo, required this.bar, required this.b});
//
//   factory AStyle.inherit({
//     required FStyle style,
//     required FTypography typography,
//     required FColorScheme colorScheme,
//     AStyle Function(AStyle) inherit = self,
//   }) =>
//       AStyle(foo: 1, bar: 2, b: BStyle(foo: 3, bar: 4));
//
//   AStyle copyWith({
//     int? foo,
//     int? bar,
//     BStyle? b,
//   }) =>
//       AStyle(
//         foo: foo ?? this.foo,
//         bar: bar ?? this.bar,
//         b: b ?? this.b,
//       );
// }
//
// class BStyle {
//   final int foo;
//   final int bar;
//
//   BStyle({required this.foo, required this.bar});
//
//   factory BStyle.inherit({
//     required FStyle style,
//     required FTypography typography,
//     required FColorScheme colorScheme,
//     BStyle Function(BStyle) inherit = self,
//   }) =>
//       map(BStyle(foo: 1, bar: 2));
//
//   BStyle copyWith({
//     int? foo,
//     int? bar,
//     BStyle Function(BStyle) inherit = self,
//   }) =>
//       inherit(BStyle(
//         foo: foo ?? this.foo,
//         bar: bar ?? this.bar,
//       ));
// }
//
// void current(FStyle style, FTypography typography, FColorScheme colorScheme) {
//   // Requires a block.
//   final a = AStyle.inherit(
//     style: style,
//     typography: typography,
//     colorScheme: colorScheme,
//   );
//
//   OtherStyle(
//     style: AStyle(
//       foo: 5,
//       bar: a.bar,
//       b: a.b.copyWith(foo: 6),
//     ),
//   );
// }
//
// void proposed(FStyle style, FTypography typography, FColorScheme colorScheme) {
//   // Does not require a block (usable in arrow functions & expressions)
//   OtherStyle(
//     style: AStyle.inherit(
//       style: style,
//       typography: typography,
//       colorScheme: colorScheme,
//     ).copyWith(
//       map: (style) => style.copyWith(
//         foo: 5,
//         b: style.b.copyWith(foo: 6),
//       ),
//     ),
//   );
// }
