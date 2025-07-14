import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/accordion/accordion.dart';
import 'package:forui/src/widgets/accordion/accordion_controller.dart';

/// A marker interface which denotes that mixed-in widgets can be used in a [FAccordion].
mixin FAccordionItemMixin on Widget {}

/// An interactive heading that reveals a section of content.
///
/// See:
/// * https://forui.dev/docs/data/accordion for working examples.
class FAccordionItem extends StatefulWidget with FAccordionItemMixin {
  /// The accordion's style. Defaults to [FThemeData.accordionStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create accordion
  /// ```
  final FAccordionStyle? style;

  /// The title.
  final Widget title;

  /// The icon, wrapped in a [IconTheme]. Defaults to `Icon(FIcons.chevronRight)`.
  final Widget icon;

  /// True if the item is initially expanded.
  final bool initiallyExpanded;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// The child.
  final Widget child;

  /// Creates an [FAccordionItem].
  const FAccordionItem({
    required this.title,
    required this.child,
    this.style,
    this.icon = const Icon(FIcons.chevronDown),
    this.initiallyExpanded = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  State<FAccordionItem> createState() => _FAccordionItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('initiallyExpanded', value: initiallyExpanded, ifTrue: 'Initially expanded'))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _FAccordionItemState extends State<FAccordionItem> with TickerProviderStateMixin {
  AnimationController? _controller;
  CurvedAnimation? _body;
  Animation<double>? _icon;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final InheritedAccordionData(:index, :controller, :style) = InheritedAccordionData.of(context);
    controller.remove(index);

    _controller?.dispose();
    _body?.dispose();

    _controller = AnimationController(
      vsync: this,
      value: widget.initiallyExpanded ? 1 : 0,
      duration: style.expandDuration,
      reverseDuration: style.collapseDuration,
    );
    _body = CurvedAnimation(curve: style.expandCurve, reverseCurve: style.collapseCurve, parent: _controller!);
    _icon = Tween<double>(begin: 0, end: 0.5).animate(_body!);

    if (!controller.add(index, _controller!)) {
      throw StateError('Number of expanded items must be within the min and max.');
    }
  }

  @override
  void dispose() {
    _body?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InheritedAccordionData(:index, :controller, style: inheritedStyle) = InheritedAccordionData.of(context);
    final style = widget.style ?? inheritedStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FTappable(
          style: style.tappableStyle,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          onFocusChange: widget.onFocusChange,
          onPress: () => controller.toggle(index),
          builder: (_, states, _) => Padding(
            padding: style.titlePadding,
            child: Row(
              children: [
                Expanded(
                  child: DefaultTextStyle.merge(
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    style: style.titleTextStyle.resolve(states),
                    child: widget.title,
                  ),
                ),
                FFocusedOutline(
                  style: style.focusedOutlineStyle,
                  focused: states.contains(WidgetState.focused),
                  child: RotationTransition(
                    turns: _icon!,
                    child: IconTheme(data: style.iconStyle.resolve(states), child: widget.icon),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _body!,
          builder: (_, _) => FCollapsible(
            value: _body!.value,
            child: Padding(
              padding: style.childPadding,
              child: DefaultTextStyle(style: style.childTextStyle, child: widget.child),
            ),
          ),
        ),
        FDivider(style: style.dividerStyle),
      ],
    );
  }
}
