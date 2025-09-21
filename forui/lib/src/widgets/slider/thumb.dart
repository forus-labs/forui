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
  late FSliderController _controller;
  late UniqueKey _key;
  FSliderStyle? _style;
  FTooltipController? _tooltip;
  MouseCursor _cursor = SystemMouseCursors.grab;
  ({double min, double max})? _origin;
  bool _gesture = false;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _key = widget.min ? FSliderTooltipsController.min : FSliderTooltipsController.max;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final style = InheritedData.of(context).style;
    if (_style != style) {
      _tooltip?.dispose();
      _tooltip = FTooltipController(vsync: this, motion: style.tooltipMotion);
      _style = style;
    }

    _controller = InheritedController.of(context);
    _controller.tooltips.add(_key, _tooltip!);
  }

  @override
  Widget build(BuildContext context) {
    final states = InheritedStates.of(context).states;
    final InheritedData(
      style: FSliderStyle(:thumbSize, :thumbStyle, :tooltipTipAnchor, :tooltipThumbAnchor),
      :layout,
      :tooltipBuilder,
      :semanticValueFormatterCallback,
      :enabled,
    ) = InheritedData.of(
      context,
    );

    String? increasedValue;
    if (_controller.selection.step(min: widget.min, extend: !widget.min) case final selection
        when _controller.selection != selection) {
      increasedValue = semanticValueFormatterCallback(_offset(selection));
    }

    String? decreasedValue;
    if (_controller.selection.step(min: widget.min, extend: widget.min) case final selection
        when _controller.selection != selection) {
      decreasedValue = semanticValueFormatterCallback(_offset(selection));
    }

    Widget thumb = Semantics(
      enabled: enabled,
      value: semanticValueFormatterCallback(_offset(_controller.selection)),
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      child: FocusableActionDetector(
        shortcuts: _shortcuts(layout),
        actions: {
          _ExtendIntent: CallbackAction(onInvoke: (_) => _controller.step(min: widget.min, extend: true)),
          _ShrinkIntent: CallbackAction(onInvoke: (_) => _controller.step(min: widget.min, extend: false)),
        },
        enabled: enabled,
        mouseCursor: enabled ? _cursor : MouseCursor.defer,
        includeFocusSemantics: false,
        onFocusChange: (focused) => setState(() => _focused = focused),
        child: FFocusedOutline(
          style: thumbStyle.focusedOutlineStyle,
          focused: _focused,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: thumbStyle.color.resolve(states),
              border: Border.all(color: thumbStyle.borderColor.resolve(states), width: thumbStyle.borderWidth),
            ),
            child: SizedBox.square(dimension: thumbSize),
          ),
        ),
      ),
    );

    if (!enabled) {
      return thumb;
    }

    if (_controller.tooltips.enabled) {
      thumb = MouseRegion(
        onEnter: (_) => _controller.tooltips.show(_key),
        onExit: (_) {
          if (!_gesture) {
            _controller.tooltips.hide(_key);
          }
        },
        child: FTooltip(
          controller: _tooltip,
          tipAnchor: tooltipTipAnchor,
          childAnchor: tooltipThumbAnchor,
          tipBuilder: (_, controller) => tooltipBuilder(controller, _offset(_controller.selection)),
          longPress: false,
          hover: false,
          child: thumb,
        ),
      );
    }

    void down(TapDownDetails _) {
      setState(() => _cursor = SystemMouseCursors.grabbing);
      _gesture = true;
      _controller.tooltips.show(_key);
    }

    void up(TapUpDetails _) {
      setState(() => _cursor = SystemMouseCursors.grab);
      _gesture = false;
      _controller.tooltips.hide(_key);
    }

    void start(DragStartDetails _) {
      setState(() => _cursor = SystemMouseCursors.grabbing);
      _origin = null;
      _origin = _controller.selection.rawOffset;
      _gesture = true;
      _controller.tooltips.show(_key);
    }

    void end(DragEndDetails _) {
      setState(() => _cursor = SystemMouseCursors.grab);
      _origin = null;
      _gesture = false;
      _controller.tooltips.hide(_key);
    }

    if (layout.vertical) {
      return GestureDetector(
        onTapDown: down,
        onTapUp: up,
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(_controller, thumbSize, layout),
        onVerticalDragEnd: end,
        child: thumb,
      );
    } else {
      return GestureDetector(
        onTapDown: down,
        onTapUp: up,
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(_controller, thumbSize, layout),
        onHorizontalDragEnd: end,
        child: thumb,
      );
    }
  }

  double _offset(FSliderSelection selection) => widget.min ? selection.offset.min : selection.offset.max;

  Map<ShortcutActivator, Intent> _shortcuts(FLayout layout) => switch ((layout, widget.min)) {
    (FLayout.ltr, true) || (FLayout.rtl, false) => const {
      SingleActivator(LogicalKeyboardKey.arrowLeft): _ExtendIntent(),
      SingleActivator(LogicalKeyboardKey.arrowRight): _ShrinkIntent(),
    },
    (FLayout.ltr, false) || (FLayout.rtl, true) => const {
      SingleActivator(LogicalKeyboardKey.arrowLeft): _ShrinkIntent(),
      SingleActivator(LogicalKeyboardKey.arrowRight): _ExtendIntent(),
    },
    (FLayout.ttb, true) || (FLayout.btt, false) => const {
      SingleActivator(LogicalKeyboardKey.arrowUp): _ExtendIntent(),
      SingleActivator(LogicalKeyboardKey.arrowDown): _ShrinkIntent(),
    },
    (FLayout.ttb, false) || (FLayout.btt, true) => const {
      SingleActivator(LogicalKeyboardKey.arrowUp): _ShrinkIntent(),
      SingleActivator(LogicalKeyboardKey.arrowDown): _ExtendIntent(),
    },
  };

  GestureDragUpdateCallback? _drag(FSliderController controller, double thumbSize, FLayout layout) {
    if (controller.allowedInteraction == FSliderInteraction.tap) {
      return null;
    }

    final translate = layout.translateThumbDrag(thumbSize);

    void drag(DragUpdateDetails details) {
      final origin = widget.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition), min: widget.min);
    }

    return drag;
  }

  @override
  void dispose() {
    _controller.tooltips.remove(_key);
    _tooltip?.dispose();
    super.dispose();
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
    FLayout.ltr => (delta) => delta.dx - thumbSize / 2,
    FLayout.rtl => (delta) => -delta.dx + thumbSize / 2,
    FLayout.ttb => (delta) => delta.dy - thumbSize / 2,
    FLayout.btt => (delta) => -delta.dy + thumbSize / 2,
  };
}
