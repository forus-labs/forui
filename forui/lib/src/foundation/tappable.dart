import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tappable.design.dart';

/// Utilities for retrieving information about the current platform.
extension FTouch on Never {
  /// The platforms that use touch as the primary input. This isn't 100% accurate as there are hybrid devices that use
  /// both touch and keyboard/mouse input, i.e., Windows Surface laptops.
  static const platforms = {TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.fuchsia};

  static bool? _primary;

  /// True if the current platform uses touch as the primary input.
  static bool get primary => _primary ?? platforms.contains(defaultTargetPlatform);

  @visibleForTesting
  static set primary(bool? value) {
    if (!kDebugMode) {
      throw UnsupportedError('Setting Touch.primary is only available in debug mode.');
    }

    _primary = value;
  }
}

/// An area that responds to touch.
///
/// It is typically used to create other high-level widgets, i.e., [FButton]. Unless you are creating a custom widget,
/// you should use those high-level widgets instead.
class FTappable extends StatefulWidget {
  static Widget _builder(BuildContext _, Set<WidgetState> _, Widget? child) => child!;

  /// The style.
  final FTappableStyle Function(FTappableStyle style)? style;

  /// The style used when the tappable is focused. This tappable will not be outlined if null.
  final FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// Whether to replace all child semantics with this node. Defaults to false.
  final bool excludeSemantics;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@template forui.foundation.FTappable.onHoverChange}
  /// Handler called when the hover changes.
  ///
  /// Called with true if this widget's node gains hover, and false if it loses hover.
  /// {@endtemplate}
  final ValueChanged<bool>? onHoverChange;

  /// {@template forui.foundation.FTappable.onStateChange}
  /// Handler called when there are any changes to a tappable's [WidgetState]s.
  ///
  /// It is called before the more specific callbacks, i.e., [onFocusChange].
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// Consider using the more specific callbacks if you only need to listen to a specific state change:
  /// * [onFocusChange] for focus changes.
  /// * [onHoverChange] for hover changes.
  /// {@endtemplate}
  final ValueChanged<FWidgetStatesDelta>? onStateChange;

  /// True if this tappable is currently selected. Defaults to false.
  final bool selected;

  /// The tappable's hit test behavior. Defaults to [HitTestBehavior.translucent].
  final HitTestBehavior behavior;

  /// {@template forui.foundation.FTappable.onPress}
  /// A callback for when the widget is pressed.
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onPress;

  /// {@template forui.foundation.FTappable.onLongPress}
  /// A callback for when the widget is long pressed.
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onLongPress;

  /// {@template forui.foundation.FTappable.onSecondaryPress}
  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onSecondaryPress;

  /// {@template forui.foundation.FTappable.onSecondaryLongPress}
  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The widget will be disabled if the following are null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  /// {@endtemplate}
  final VoidCallback? onSecondaryLongPress;

  /// {@template forui.foundation.FTappable.shortcuts}
  /// The shortcuts. Defaults to calling [ActivateIntent] if [onPress] is not null.
  /// {@endtemplate}
  final Map<ShortcutActivator, Intent> shortcuts;

  /// {@template forui.foundation.FTappable.actions}
  /// The actions. Defaults to calling [onPress] when [ActivateIntent] is invoked and [onPress] is not null.
  /// {@endtemplate}
  final Map<Type, Action<Intent>>? actions;

  /// The builder used to create a child with the current state.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  final ValueWidgetBuilder<Set<WidgetState>> builder;

  /// An optional child.
  ///
  /// This can be null if the entire widget subtree the [builder] builds reacts to focus and
  /// hover changes.
  final Widget? child;

  /// Creates an [FTappable].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const factory FTappable({
    FTappableStyle Function(FTappableStyle style)? style,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    String? semanticsLabel,
    bool excludeSemantics,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<FWidgetStatesDelta>? onStateChange,
    bool selected,
    HitTestBehavior behavior,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryPress,
    VoidCallback? onSecondaryLongPress,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    ValueWidgetBuilder<Set<WidgetState>> builder,
    Widget? child,
    Key? key,
  }) = AnimatedTappable;

  /// Creates a [FTappable] without animation.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const FTappable.static({
    this.style,
    this.focusedOutlineStyle,
    this.semanticsLabel,
    this.excludeSemantics = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.selected = false,
    this.behavior = HitTestBehavior.translucent,
    this.onPress,
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.actions,
    this.builder = _builder,
    this.child,
    Map<ShortcutActivator, Intent>? shortcuts,
    super.key,
  }) : shortcuts =
           shortcuts ??
           (onPress == null ? const {} : const {SingleActivator(LogicalKeyboardKey.enter): ActivateIntent()}),
       assert(builder != _builder || child != null, 'Either builder or child must be provided');

  @override
  State<FTappable> createState() => _FTappableState<FTappable>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('excludeSemantics', value: excludeSemantics, ifTrue: 'excludeSemantics'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(EnumProperty('behavior', behavior))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(ObjectFlagProperty.has('builder', builder));
  }

  bool get _disabled =>
      onPress == null && onLongPress == null && onSecondaryPress == null && onSecondaryLongPress == null;
}

class _FTappableState<T extends FTappable> extends State<T> {
  late final WidgetStatesController _controller;
  late Set<WidgetState> _current;
  int _monotonic = 0;

  @override
  void initState() {
    super.initState();
    _controller = WidgetStatesController({
      if (widget.selected) WidgetState.selected,
      if (widget.autofocus) WidgetState.focused,
      if (widget._disabled) WidgetState.disabled,
    });
    _current = {..._controller.value};
    _controller.addListener(_onChange);
  }

  @override
  void didUpdateWidget(covariant T old) {
    super.didUpdateWidget(old);
    _controller
      ..update(WidgetState.selected, widget.selected)
      ..update(WidgetState.disabled, widget._disabled);
  }

  void _onChange() {
    // We need to create a new set because of https://github.com/flutter/flutter/issues/167916
    final current = {..._controller.value};
    final previous = _current;

    // We set _current before onStateChange to prevent exceptions thrown by it from corrupting the state.
    _current = current;
    if (widget.onStateChange case final onStateChange?) {
      onStateChange(FWidgetStatesDelta(previous, current));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.tappableStyle) ?? context.theme.tappableStyle;
    var tappable = _decorate(context, widget.builder(context, _current, widget.child));
    tappable = Shortcuts(
      shortcuts: widget.shortcuts,
      child: Actions(
        actions:
            widget.actions ??
            {
              if (widget.onPress != null)
                ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onPress!.call()),
            },
        child: Semantics(
          enabled: !widget._disabled,
          label: widget.semanticsLabel,
          container: true,
          button: true,
          selected: widget.selected,
          excludeSemantics: widget.excludeSemantics,
          child: Focus(
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            onFocusChange: (focused) {
              setState(() => _controller.update(WidgetState.focused, focused));
              widget.onFocusChange?.call(focused);
            },
            child: MouseRegion(
              cursor: style.cursor.resolve(_controller.value),
              onEnter: (_) {
                setState(() => _controller.update(WidgetState.hovered, true));
                widget.onHoverChange?.call(true);
              },
              onExit: (_) => setState(() {
                _controller.update(WidgetState.hovered, false);
                widget.onHoverChange?.call(false);
              }),
              // We use a separate Listener instead of the GestureDetector in _child as GestureDetectors fight in
              // GestureArena and only 1 GestureDetector will win. This is problematic if this tappable is wrapped in
              // another GestureDetector as onTapDown and onTapUp might absorb EVERY gesture, including drags and pans.
              child: Listener(
                onPointerDown: (_) async {
                  final count = ++_monotonic;
                  if (!widget._disabled) {
                    onPressedStart();
                  }

                  await Future.delayed(style.pressedEnterDuration);
                  if (mounted && count == _monotonic && !_controller.value.contains(WidgetState.pressed)) {
                    setState(() => _controller.update(WidgetState.pressed, true));
                  }
                },
                onPointerMove: (event) {
                  // The RenderObject should almost always be a [RenderBox] since it is wrapped in a Semantics which
                  // required the child to be a [RenderBox] as well. We use a pattern match anyways just to be safe.
                  if (context.findRenderObject() case final RenderBox box?
                      when !box.size.contains(event.localPosition)) {
                    ++_monotonic;
                    if (!widget._disabled) {
                      onPressedEnd();
                    }
                    setState(() => _controller.update(WidgetState.pressed, false));
                  }
                },
                onPointerUp: (_) async {
                  final count = ++_monotonic;
                  if (!widget._disabled) {
                    onPressedEnd();
                  }

                  await Future.delayed(style.pressedExitDuration);
                  if (mounted && count == _monotonic && _controller.value.contains(WidgetState.pressed)) {
                    setState(() => _controller.update(WidgetState.pressed, false));
                  }
                },
                child: GestureDetector(
                  behavior: widget.behavior,
                  onTap: widget.onPress,
                  onLongPress: widget.onLongPress,
                  onSecondaryTap: widget.onSecondaryPress,
                  onSecondaryLongPress: widget.onSecondaryLongPress,
                  child: tappable,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.focusedOutlineStyle case final style?) {
      tappable = FFocusedOutline(
        focused: _controller.value.contains(WidgetState.focused),
        style: style,
        child: tappable,
      );
    }

    return tappable;
  }

  Widget _decorate(BuildContext _, Widget child) => child;

  void onPressedStart() {}

  void onPressedEnd() {}
}

@internal
class AnimatedTappable extends FTappable {
  const AnimatedTappable({
    super.style,
    super.focusedOutlineStyle,
    super.semanticsLabel,
    super.excludeSemantics,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
    super.onHoverChange,
    super.onStateChange,
    super.selected,
    super.behavior,
    super.onPress,
    super.onLongPress,
    super.onSecondaryPress,
    super.onSecondaryLongPress,
    super.shortcuts,
    super.actions,
    super.builder,
    super.child,
    super.key,
  }) : super.static();

  @override
  State<FTappable> createState() => AnimatedTappableState();
}

@internal
class AnimatedTappableState extends _FTappableState<AnimatedTappable> with SingleTickerProviderStateMixin {
  @visibleForTesting
  Animation<double>? bounce;

  FTappableStyle? _style;
  late final AnimationController _bounceController = AnimationController(vsync: this);
  late final CurvedAnimation _curvedBounce = CurvedAnimation(parent: _bounceController, curve: Curves.linear);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupBounceAnimation();
  }

  @override
  void didUpdateWidget(covariant AnimatedTappable old) {
    super.didUpdateWidget(old);
    _setupBounceAnimation();
  }

  void _setupBounceAnimation() {
    final style = widget.style?.call(context.theme.tappableStyle) ?? context.theme.tappableStyle;
    if (_style != style) {
      _style = style;
      _bounceController
        ..duration = style.motion.bounceDownDuration
        ..reverseDuration = style.motion.bounceUpDuration;
      _curvedBounce
        ..curve = style.motion.bounceDownCurve
        ..reverseCurve = style.motion.bounceUpCurve;
      bounce = style.motion.bounceTween.animate(_curvedBounce);
    }
  }

  @override
  void dispose() {
    _curvedBounce.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget _decorate(BuildContext _, Widget child) {
    if (bounce case final bounce?) {
      return ScaleTransition(scale: bounce, child: child);
    } else {
      return child;
    }
  }

  @override
  void onPressedStart() {
    // Check if it's mounted due to a non-deterministic race condition, https://github.com/forus-labs/forui/issues/482.
    if (mounted) {
      _bounceController.forward();
    }
  }

  @override
  void onPressedEnd() {
    // Check if it's mounted due to a non-deterministic race condition, https://github.com/forus-labs/forui/issues/482.
    if (mounted) {
      _bounceController.reverse();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('bounce', bounce));
  }
}

/// A [FTappable]'s style.
class FTappableStyle with Diagnosticable, _$FTappableStyleFunctions {
  /// The mouse cursor for mouse pointers that are hovering over the region. Defaults to [MouseCursor.defer].
  @override
  final FWidgetStateMap<MouseCursor> cursor;

  /// The duration to wait before applying the pressed effect after the user presses the tile. Defaults to 200ms.
  @override
  final Duration pressedEnterDuration;

  /// The duration to wait before removing the pressed effect after the user stops pressing the tile. Defaults to 0s.
  @override
  final Duration pressedExitDuration;

  /// Motion-related properties for the tappable.
  ///
  /// Set this to [FTappableMotion.none] to disable the bounce effect.
  @override
  final FTappableMotion motion;

  /// Creates a [FTappableStyle].
  FTappableStyle({
    this.cursor = const FWidgetStateMap({WidgetState.any: MouseCursor.defer}),
    this.pressedEnterDuration = const Duration(milliseconds: 200),
    this.pressedExitDuration = Duration.zero,
    this.motion = const FTappableMotion(),
  });
}

/// Motion-related properties for [FTappable].
class FTappableMotion with Diagnosticable, _$FTappableMotionFunctions {
  /// A [FTappableMotion] with no motion effects.
  static const FTappableMotion none = FTappableMotion(bounceTween: noBounceTween);

  /// The default bounce tween used by [FTappableStyle]. It scales the widget down to 0.97 on tap down and back to 1.0
  /// on tap up.
  static const FImmutableTween<double> defaultBounceTween = FImmutableTween(begin: 1.0, end: 0.97);

  /// A tween that does not animate the scale of the tappable. It is used to disable the bounce effect.
  static const FImmutableTween<double> noBounceTween = FImmutableTween(begin: 1.0, end: 1.0);

  /// The bounce animation's duration when the tappable is pressed down. Defaults to 100ms.
  @override
  final Duration bounceDownDuration;

  /// The bounce animation's duration when the tappable is released (up). Defaults to 120ms.
  @override
  final Duration bounceUpDuration;

  /// The curve used to animate the scale of the tappable when pressed (down). Defaults to [Curves.easeOutQuart].
  @override
  final Curve bounceDownCurve;

  /// The curve used to animate the scale of the tappable when released (up). Defaults to [Curves.easeOutCubic].
  @override
  final Curve bounceUpCurve;

  /// The bounce's tween. Defaults to [defaultBounceTween].
  ///
  /// Set to [noBounceTween] to disable the bounce effect.
  @override
  final Animatable<double> bounceTween;

  /// Creates a [FTappableMotion].
  const FTappableMotion({
    this.bounceDownDuration = const Duration(milliseconds: 100),
    this.bounceUpDuration = const Duration(milliseconds: 120),
    this.bounceDownCurve = Curves.easeOutQuart,
    this.bounceUpCurve = Curves.easeOutCubic,
    this.bounceTween = defaultBounceTween,
  });
}
