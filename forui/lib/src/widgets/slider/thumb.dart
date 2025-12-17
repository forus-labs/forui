import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/inherited_state.dart';

part 'thumb.design.dart';

class _ShrinkIntent extends Intent {
  const _ShrinkIntent();
}

class _ExtendIntent extends Intent {
  const _ExtendIntent();
}

@internal
class Thumb extends StatefulWidget {
  final bool min;

  const Thumb({required this.min, super.key});

  @override
  State<Thumb> createState() => _ThumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('min', value: min, ifTrue: 'min', ifFalse: 'max'));
  }
}

class _ThumbState extends State<Thumb> with TickerProviderStateMixin {
  MouseCursor _cursor = SystemMouseCursors.grab;
  ({double min, double max})? _origin;
  bool _gesture = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final InheritedController(:controller, minTooltipController:min, maxTooltipController:max) = .of(context);
    final tooltip = widget.min ? min : max;
    final states = InheritedStates.of(context).states;
    final InheritedData(
      style: FSliderStyle(:thumbSize, :thumbStyle, :tooltipTipAnchor, :tooltipThumbAnchor),
      :layout,
      :tooltipBuilder,
      :semanticValueFormatterCallback,
      :enabled,
    ) = .of(
      context,
    );

    String? increasedValue;
    if (controller.selection.step(min: widget.min, extend: !widget.min) case final selection
        when controller.selection != selection) {
      increasedValue = semanticValueFormatterCallback(_offset(selection));
    }

    String? decreasedValue;
    if (controller.selection.step(min: widget.min, extend: widget.min) case final selection
        when controller.selection != selection) {
      decreasedValue = semanticValueFormatterCallback(_offset(selection));
    }

    Widget thumb = Semantics(
      enabled: enabled,
      value: semanticValueFormatterCallback(_offset(controller.selection)),
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      child: FocusableActionDetector(
        shortcuts: _shortcuts(layout),
        actions: {
          _ExtendIntent: CallbackAction(onInvoke: (_) => controller.step(min: widget.min, extend: true)),
          _ShrinkIntent: CallbackAction(onInvoke: (_) => controller.step(min: widget.min, extend: false)),
        },
        enabled: enabled,
        mouseCursor: enabled ? _cursor : .defer,
        includeFocusSemantics: false,
        onFocusChange: (focused) => setState(() => _focused = focused),
        child: FFocusedOutline(
          style: thumbStyle.focusedOutlineStyle,
          focused: _focused,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: .circle,
              color: thumbStyle.color.resolve(states),
              border: .all(color: thumbStyle.borderColor.resolve(states), width: thumbStyle.borderWidth),
            ),
            child: SizedBox.square(dimension: thumbSize),
          ),
        ),
      ),
    );

    if (!enabled) {
      return thumb;
    }

    if (tooltip != null) {
      thumb = MouseRegion(
        onEnter: (_) => tooltip.show(),
        onExit: (_) {
          if (!_gesture) {
            tooltip.hide();
          }
        },
        child: FTooltip(
          control: .managed(controller: tooltip),
          tipAnchor: tooltipTipAnchor,
          childAnchor: tooltipThumbAnchor,
          tipBuilder: (_, tooltipController) => tooltipBuilder(tooltipController, _offset(controller.selection)),
          longPress: false,
          hover: false,
          child: thumb,
        ),
      );
    }

    void down(TapDownDetails _) {
      setState(() => _cursor = SystemMouseCursors.grabbing);
      _gesture = true;
      tooltip?.show();
    }

    void up(TapUpDetails _) {
      setState(() => _cursor = SystemMouseCursors.grab);
      _gesture = false;
      tooltip?.hide();
    }

    void start(DragStartDetails _) {
      setState(() => _cursor = SystemMouseCursors.grabbing);
      _origin = null;
      _origin = controller.selection.pixels;
      _gesture = true;
      tooltip?.show();
    }

    void end(DragEndDetails _) {
      setState(() => _cursor = SystemMouseCursors.grab);
      _origin = null;
      _gesture = false;
      tooltip?.hide();
    }

    if (layout.vertical) {
      return GestureDetector(
        onTapDown: down,
        onTapUp: up,
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(controller, thumbSize, layout),
        onVerticalDragEnd: end,
        child: thumb,
      );
    } else {
      return GestureDetector(
        onTapDown: down,
        onTapUp: up,
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(controller, thumbSize, layout),
        onHorizontalDragEnd: end,
        child: thumb,
      );
    }
  }

  double _offset(FSliderSelection selection) => widget.min ? selection.min : selection.max;

  Map<ShortcutActivator, Intent> _shortcuts(FLayout layout) => switch ((layout, widget.min)) {
    (.ltr, true) || (.rtl, false) => const {
      SingleActivator(.arrowLeft): _ExtendIntent(),
      SingleActivator(.arrowRight): _ShrinkIntent(),
    },
    (.ltr, false) ||
    (.rtl, true) => const {SingleActivator(.arrowLeft): _ShrinkIntent(), SingleActivator(.arrowRight): _ExtendIntent()},
    (.ttb, true) ||
    (.btt, false) => const {SingleActivator(.arrowUp): _ExtendIntent(), SingleActivator(.arrowDown): _ShrinkIntent()},
    (.ttb, false) ||
    (.btt, true) => const {SingleActivator(.arrowUp): _ShrinkIntent(), SingleActivator(.arrowDown): _ExtendIntent()},
  };

  GestureDragUpdateCallback? _drag(FSliderController controller, double thumbSize, FLayout layout) {
    if (controller.interaction == FSliderInteraction.tap) {
      return null;
    }

    final translate = layout.translateThumbDrag(thumbSize);

    void drag(DragUpdateDetails details) {
      final origin = widget.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition), min: widget.min);
    }

    return drag;
  }
}

/// A slider thumb's style.
///
/// **Note**:
/// The thumb size can be configured inside [FSliderStyle] instead. This is due to an unfortunate limitation of the
/// implementation.
class FSliderThumbStyle with Diagnosticable, _$FSliderThumbStyleFunctions {
  /// The thumb's color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<Color> color;

  /// The border's color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<Color> borderColor;

  /// The border's width. Defaults to `2`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [borderWidth] is not positive.
  @override
  final double borderWidth;

  /// The thumb's focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FSliderThumbStyle].
  FSliderThumbStyle({
    required this.color,
    required this.borderColor,
    required this.focusedOutlineStyle,
    this.borderWidth = 2,
  }) : assert(0 < borderWidth, 'borderWidth ($borderWidth) must be > 0');
}

@internal
extension Layouts on FLayout {
  double Function(Offset) translateThumbDrag(double thumbSize) => switch (this) {
    .ltr => (delta) => delta.dx - thumbSize / 2,
    .rtl => (delta) => -delta.dx + thumbSize / 2,
    .ttb => (delta) => delta.dy - thumbSize / 2,
    .btt => (delta) => -delta.dy + thumbSize / 2,
  };
}
