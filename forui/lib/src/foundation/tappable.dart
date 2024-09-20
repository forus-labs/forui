import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

// TODO: Remove redundant comment when flutter fixes its lint issue.
///
@internal
typedef FTappableState = ({bool focused, bool hovered, bool longPressed});

@internal
class FTappable extends StatefulWidget {
  final String? semanticLabel;
  final bool selected;
  final bool excludeSemantics;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final HitTestBehavior? behavior;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
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
    this.onPress,
    this.onLongPress,
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
  bool _longPressed = false;

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
              await Future.delayed(const Duration(milliseconds: 200));
              if (count == _monotonic) {
                setState(() => _longPressed = true);
              }
            },
            onPointerUp: (_) {
              _monotonic++;
              if (_longPressed) {
                setState(() => _longPressed = false);
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
        child: widget.builder(context, (focused: _focused, hovered: _hovered, longPressed: _longPressed), widget.child),
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
          child:
              widget.builder(context, (focused: _focused, hovered: _hovered, longPressed: _longPressed), widget.child),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
