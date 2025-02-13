import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'accordion.style.dart';

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
  const FAccordion({required this.items, this.controller, this.style, super.key});

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

    if (old.controller == null) {
      _controller.dispose();
    }
    _controller = widget.controller ?? FAccordionController();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.accordionStyle;
    return Column(
      children: [
        for (final (index, child) in widget.items.indexed)
          FAccordionItemData(index: index, controller: _controller, style: style, child: child),
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
final class FAccordionStyle with Diagnosticable, _$FAccordionStyleFunctions {
  /// The title's default text style.
  @override
  final TextStyle titleTextStyle;

  /// The child's default text style.
  @override
  final TextStyle childTextStyle;

  /// The padding around the title. Defaults to `EdgeInsets.symmetric(vertical: 15)`.
  @override
  final EdgeInsets titlePadding;

  /// The padding around the content. Defaults to `EdgeInsets.only(bottom: 15)`.
  @override
  final EdgeInsets childPadding;

  /// The icon's color.
  @override
  final Color iconColor;

  /// The icon's size. Defaults to 20.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [iconSize] is not positive.
  @override
  final double iconSize;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The divider's color.
  @override
  final FDividerStyle dividerStyle;

  /// The expanding/collapsing animation duration. Defaults to 200ms.
  @override
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
