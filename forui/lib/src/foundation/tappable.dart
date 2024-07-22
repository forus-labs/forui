import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

// TODO: Remove redundant comment when flutter fixes its lint issue.
///
@internal
typedef FTappableState = ({bool focused, bool hovered});

@internal
class FTappable extends StatefulWidget {
  final bool enabled;
  final String? semanticLabel;
  final bool selected;
  final bool excludeSemantics;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
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
    this.onPress,
    this.onLongPress,
    ValueWidgetBuilder<FTappableState>? builder,
    this.child,
    super.key,
  })  : assert(builder != null || child != null, 'Either builder or child must be provided.'),
        builder = builder ?? ((_, __, child) => child!),
        enabled = onPress != null || onLongPress != null;

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
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('builder', builder, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('child', child, level: DiagnosticLevel.debug));
  }
}

class _FTappableState extends State<FTappable> with SingleTickerProviderStateMixin {
  bool _focused = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => Semantics(
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
            child: _child,
          ),
        ),
      );

  Widget get _child => GestureDetector(
        onTap: widget.onPress,
        onLongPress: widget.onLongPress,
        child: widget.builder(context, (focused: _focused, hovered: _hovered), widget.child),
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
    super.onPress,
    super.onLongPress,
    super.builder,
    super.child,
    super.key,
  });

  @override
  State<FTappable> createState() => _AnimatedTappableState();
}

class _AnimatedTappableState extends _FTappableState {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween(begin: 1.0, end: 0.95).animate(_controller)
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
          onTap: widget.onPress == null
              ? null
              : () {
                  widget.onPress!();
                  _controller.forward();
                },
          onLongPress: widget.onLongPress,
          child: widget.builder(context, (focused: _focused, hovered: _hovered), widget.child),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
