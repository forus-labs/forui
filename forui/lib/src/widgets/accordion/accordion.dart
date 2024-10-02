import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/svg.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A vertically stacked set of interactive headings that each reveal a section of content.
///
///
/// See:
/// * https://forui.dev/docs/accordion for working examples.
/// * [FAccordionController] for customizing the accordion's selection behavior.
/// * [FAccordionItem] for adding items to an accordion.
/// * [FAccordionStyle] for customizing an accordion's appearance.
class FAccordion extends StatefulWidget {
  /// The controller.
  ///
  /// See:
  /// * [FAccordionController] for default multiple selections.
  /// * [FAccordionController.radio] for a radio-like selection.
  final FAccordionController? controller;

  /// The style. Defaults to [FThemeData.accordionStyle].
  final FAccordionStyle? style;

  /// The items.
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

    if (!_controller.validate(widget.children.where((child) => child.initiallyExpanded).length)) {
      throw StateError('number of expanded items must be within the allowed range.');
    }
  }

  @override
  void didUpdateWidget(covariant FAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? FAccordionController();

      if (!_controller.validate(widget.children.where((child) => child.initiallyExpanded).length)) {
        throw StateError('number of expanded items must be within the min and max.');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          for (final (index, child) in widget.children.indexed)
            FAccordionItemData(
              index: index,
              controller: _controller,
              child: child,
            ),
        ],
      );
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

  /// The icon.
  final Widget icon;

  /// The divider's color.
  final FDividerStyle divider;

  /// Creates a [FAccordionStyle].
  FAccordionStyle({
    required this.titleTextStyle,
    required this.childTextStyle,
    required this.titlePadding,
    required this.childPadding,
    required this.icon,
    required this.divider,
  });

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme].
  FAccordionStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : titleTextStyle = typography.base.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.foreground,
        ),
        childTextStyle = typography.sm.copyWith(
          color: colorScheme.foreground,
        ),
        titlePadding = const EdgeInsets.symmetric(vertical: 15),
        childPadding = const EdgeInsets.only(bottom: 15),
        icon = FAssets.icons.chevronRight(
          height: 20,
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),
        divider = FDividerStyle(color: colorScheme.border, padding: EdgeInsets.zero);

  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  @useResult
  FAccordionStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? childTextStyle,
    EdgeInsets? titlePadding,
    EdgeInsets? childPadding,
    SvgPicture? icon,
    FDividerStyle? divider,
  }) =>
      FAccordionStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        childTextStyle: childTextStyle ?? this.childTextStyle,
        titlePadding: titlePadding ?? this.titlePadding,
        childPadding: childPadding ?? this.childPadding,
        icon: icon ?? this.icon,
        divider: divider ?? this.divider,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', titleTextStyle))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle))
      ..add(DiagnosticsProperty('padding', titlePadding))
      ..add(DiagnosticsProperty('contentPadding', childPadding))
      ..add(DiagnosticsProperty('divider', divider));
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
          icon == other.icon &&
          divider == other.divider;

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      childTextStyle.hashCode ^
      titlePadding.hashCode ^
      childPadding.hashCode ^
      icon.hashCode ^
      divider.hashCode;
}

@internal
class FAccordionItemData extends InheritedWidget {
  @useResult
  static FAccordionItemData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FAccordionItemData>();
    assert(data != null, 'No FAccordionItemData found in context');
    return data!;
  }

  final int index;

  final FAccordionController controller;

  const FAccordionItemData({
    required this.index,
    required this.controller,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FAccordionItemData old) => index != old.index || controller != old.controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty('controller', controller));
  }
}
