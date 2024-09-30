import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
extension Touch on Never {
  /// The platforms that uses touch as the primary input. It isn't 100% accurate as there are hybrid devices that uses
  /// both touch and keyboard/mouse input, i.e. Windows Surface laptops.
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

/// The [FTappableState]'s current state.
///
/// Short pressed is fired 200 ms after a tap is first detected. This is faster than long press's [kLongPressTimeout].
@internal
typedef FTappableState = ({bool focused, bool hovered});

@internal
class FTappable extends StatefulWidget {
  final String? semanticLabel;
  final bool selected;
  final bool excludeSemantics;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final HitTestBehavior? behavior;
  final Duration touchHoverEnterDuration;
  final Duration touchHoverExitDuration;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
  final Duration shortPressDelay;
  final ValueWidgetBuilder<FTappableState> builder;
  final Widget? child;

  factory FTappable.animated({
    String? semanticLabel,
    bool selected,
    bool excludeSemantics,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    HitTestBehavior behavior,
    Duration touchHoverEnterDuration,
    Duration touchHoverExitDuration,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    ValueWidgetBuilder<FTappableState>? builder,
    Widget? child,
    Key? key,
  }) = _AnimatedTappable;

  FTappable({
    this.semanticLabel,
    this.selected = false,
    this.excludeSemantics = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.behavior,
    this.touchHoverEnterDuration = const Duration(milliseconds: 200),
    this.touchHoverExitDuration = Duration.zero,
    this.onPress,
    this.onLongPress,
    this.shortPressDelay = const Duration(milliseconds: 200),
    ValueWidgetBuilder<FTappableState>? builder,
    this.child,
    super.key,
  })  : assert(builder != null || child != null, 'Either builder or child must be provided.'),
        builder = builder ?? ((_, __, child) => child!);

  bool get enabled => onPress != null || onLongPress != null;

  @override
  State<FTappable> createState() => _FTappableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('semanticLabel', semanticLabel, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusNode', focusNode, level: DiagnosticLevel.debug))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', level: DiagnosticLevel.debug))
      ..add(
        FlagProperty(
          'excludeSemantics',
          value: excludeSemantics,
          ifTrue: 'excludeSemantics',
          level: DiagnosticLevel.debug,
        ),
      )
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus', level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onFocusChange', onFocusChange, level: DiagnosticLevel.debug))
      ..add(EnumProperty('behavior', behavior, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('touchHoverEnterDuration', touchHoverEnterDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('touchHoverExitDuration', touchHoverExitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('builder', builder, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('child', child, level: DiagnosticLevel.debug));
  }
}

class _FTappableState extends State<FTappable> {
  int _monotonic = 0;
  bool _focused = false;
  bool _hovered = false;
  bool _touchHovered = false;

  @override
  Widget build(BuildContext context) {
    final tappable = Semantics(
      enabled: widget.enabled,
      label: widget.semanticLabel,
      container: true,
      button: true,
      selected: widget.selected,
      excludeSemantics: widget.excludeSemantics,
      child: Focus(
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onFocusChange: (focused) {
          setState(() => _focused = focused);
          widget.onFocusChange?.call(focused);
        },
        child: MouseRegion(
          cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          // We use a separate Listener instead of the GestureDetector in _child as GestureDetectors fight in
          // "GestureArena" and only 1 GestureDetector will win. This is problematic if this tappable is wrapped in
          // another GestureDetector as onTapDown and onTapUp might absorb EVERY gesture, including drags and pans.
          child: Listener(
            onPointerDown: (_) async {
              final count = ++_monotonic;
              await Future.delayed(widget.touchHoverEnterDuration);
              if (mounted && count == _monotonic && !_touchHovered) {
                setState(() => _touchHovered = true);
              }
            },
            onPointerUp: (_) async {
              final count = ++_monotonic;
              await Future.delayed(widget.touchHoverExitDuration);
              if (mounted && count == _monotonic && _touchHovered) {
                setState(() => _touchHovered = false);
              }
            },
            child: _child,
          ),
        ),
      ),
    );

    if (widget.onPress == null) {
      return tappable;
    }

    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onPress!()),
        },
        child: tappable,
      ),
    );
  }

  Widget get _child => GestureDetector(
        behavior: widget.behavior,
        onTap: widget.onPress,
        onLongPress: widget.onLongPress,
        child: widget.builder(context, (focused: _focused, hovered: _hovered || _touchHovered), widget.child),
      );
}

class _AnimatedTappable extends FTappable {
  _AnimatedTappable({
    super.semanticLabel,
    super.selected = false,
    super.excludeSemantics = false,
    super.autofocus = false,
    super.focusNode,
    super.onFocusChange,
    super.behavior,
    super.touchHoverEnterDuration,
    super.touchHoverExitDuration,
    super.onPress,
    super.onLongPress,
    super.builder,
    super.child,
    super.key,
  });

  @override
  State<FTappable> createState() => _AnimatedTappableState();
}

class _AnimatedTappableState extends _FTappableState with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween(begin: 1.0, end: 0.97).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  Widget get _child => ScaleTransition(
        scale: _animation,
        child: GestureDetector(
          behavior: widget.behavior,
          onTap: widget.onPress == null
              ? null
              : () {
                  widget.onPress!();
                  _controller.forward();
                },
          onLongPress: widget.onLongPress,
          child: widget.builder(context, (focused: _focused, hovered: _hovered || _touchHovered), widget.child),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
