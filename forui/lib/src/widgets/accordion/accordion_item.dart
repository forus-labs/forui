import 'package:flutter/foundation.dart';
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

  /// True if the parent accordion is managed and the item is initially expanded.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the parent accordion has lifted state and [initiallyExpanded] is non-null.
  final bool? initiallyExpanded;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onHoverChange}
  final ValueChanged<bool>? onHoverChange;

  /// {@macro forui.foundation.FTappable.onStateChange}
  final ValueChanged<FWidgetStatesDelta>? onStateChange;

  /// The child.
  final Widget child;

  /// Creates an [FAccordionItem].
  const FAccordionItem({
    required this.title,
    required this.child,
    this.style,
    this.icon = const Icon(FIcons.chevronDown),
    this.initiallyExpanded,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
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
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange));
  }
}

class _FAccordionItemState extends State<FAccordionItem> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation _curvedReveal = CurvedAnimation(curve: Curves.linear, parent: _controller);
  late final CurvedAnimation _curvedIconRotation = CurvedAnimation(curve: Curves.linear, parent: _controller);
  late FAccordionController _accordionController;
  late int _index;
  Animation<double>? _reveal;
  Animation<double>? _iconRotation;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final InheritedAccordionData(:index, :controller, :style) = .of(context);
    assert(
      controller is! LiftedController || widget.initiallyExpanded == null,
      'Cannot provide initiallyExpanded when the parent accordion has lifted state.',
    );

    _accordionController = controller;
    _index = index;
    _accordionController.remove(_index, _controller);

    _controller
      ..duration = style.motion.expandDuration
      ..reverseDuration = style.motion.collapseDuration;

    switch ((_accordionController, _initialized)) {
      case (LiftedController(:final items), true):
        items.contains(index) ? _controller.forward() : _controller.reverse();

      case (LiftedController(:final items), false):
        _controller.value = items.contains(index) ? 1.0 : 0.0;

      case _:
        _controller.value = (widget.initiallyExpanded ?? false) ? 1.0 : 0.0;
    }

    _curvedReveal
      ..curve = style.motion.expandCurve
      ..reverseCurve = style.motion.collapseCurve;

    _curvedIconRotation
      ..curve = style.motion.iconExpandCurve
      ..reverseCurve = style.motion.iconCollapseCurve;

    _reveal = style.motion.revealTween.animate(_curvedReveal);
    _iconRotation = style.motion.iconTween.animate(_curvedIconRotation);
    _initialized = true;

    if (!controller.add(index, _controller)) {
      throw StateError('Number of expanded items must be within the min and max.');
    }
  }

  @override
  void dispose() {
    _accordionController.remove(_index, _controller);
    _curvedIconRotation.dispose();
    _curvedReveal.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InheritedAccordionData(:index, :controller, style: inheritedStyle) = .of(context);
    final style = widget.style ?? inheritedStyle;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        FTappable(
          style: style.tappableStyle,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          onFocusChange: widget.onFocusChange,
          onHoverChange: widget.onHoverChange,
          onStateChange: widget.onStateChange,
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
                    turns: _iconRotation!,
                    child: IconTheme(data: style.iconStyle.resolve(states), child: widget.icon),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _reveal!,
          builder: (_, _) => FCollapsible(
            value: _reveal!.value,
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
