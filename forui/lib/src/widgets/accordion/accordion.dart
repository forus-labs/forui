import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'accordion.style.dart';

/// A vertically stacked set of interactive headings, each revealing a section of content.
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

  /// The children.
  final List<FAccordionItem> children;

  /// Creates a [FAccordion].
  const FAccordion({required this.children, this.controller, this.style, super.key});

  @override
  State<FAccordion> createState() => _FAccordionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style));
  }
}

class _FAccordionState extends State<FAccordion> {
  late FAccordionController _controller = widget.controller ?? FAccordionController();

  @override
  void didUpdateWidget(covariant FAccordion old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? FAccordionController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.accordionStyle;
    return Column(
      children: [
        for (final (index, child) in widget.children.indexed)
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
  /// The title's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<TextStyle> titleTextStyle;

  /// The child's default text style.
  @override
  final TextStyle childTextStyle;

  /// The padding around the title. Defaults to `EdgeInsets.symmetric(vertical: 15)`.
  @override
  final EdgeInsetsGeometry titlePadding;

  /// The padding around the content. Defaults to `EdgeInsets.only(bottom: 15)`.
  @override
  final EdgeInsetsGeometry childPadding;

  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The divider's color.
  @override
  final FDividerStyle dividerStyle;

  /// The expanding/collapsing animation duration. Defaults to 200ms.
  @override
  final Duration animationDuration;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FAccordionStyle].
  const FAccordionStyle({
    required this.titleTextStyle,
    required this.childTextStyle,
    required this.iconStyle,
    required this.focusedOutlineStyle,
    required this.dividerStyle,
    required this.tappableStyle,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 15),
    this.childPadding = const EdgeInsets.only(bottom: 15),
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FDividerStyles] that inherits its properties.
  FAccordionStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        titleTextStyle: FWidgetStateMap({
          WidgetState.hovered | WidgetState.pressed: typography.base.copyWith(
            fontWeight: FontWeight.w500,
            color: colors.foreground,
            decoration: TextDecoration.underline,
          ),
          WidgetState.any: typography.base.copyWith(fontWeight: FontWeight.w500, color: colors.foreground),
        }),
        childTextStyle: typography.sm.copyWith(color: colors.foreground),
        iconStyle: FWidgetStateMap.all(IconThemeData(color: colors.primary, size: 20)),
        focusedOutlineStyle: style.focusedOutlineStyle,
        dividerStyle: FDividerStyle(color: colors.border, padding: EdgeInsets.zero),
        tappableStyle: style.tappableStyle.copyWith(animationTween: FTappableAnimations.none),
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
