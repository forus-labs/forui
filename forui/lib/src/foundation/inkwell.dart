import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
class FInkWell extends StatefulWidget {
  final FocusNode? focusNode;
  final String? semanticLabel;
  final bool selected;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
  final ValueWidgetBuilder<bool> builder;
  final Widget? child;

  const FInkWell({
    required this.builder,
    this.focusNode,
    this.semanticLabel,
    this.selected = false,
    this.onPress,
    this.onLongPress,
    this.child,
    super.key,
  });

  @override
  State<FInkWell> createState() => _FInkWellState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('semanticLabel', semanticLabel, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusNode', focusNode, level: DiagnosticLevel.debug))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('builder', builder, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('child', child, level: DiagnosticLevel.debug));
  }
}

class _FInkWellState extends State<FInkWell> {
  bool _focused = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_updateFocused);
  }

  @override
  void didUpdateWidget(FInkWell old) {
    super.didUpdateWidget(old);
    widget.focusNode?.addListener(_updateFocused);
    old.focusNode?.removeListener(_updateFocused);
  }

  @override
  Widget build(BuildContext context) => Focus(
        focusNode: widget.focusNode,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: Semantics(
            label: widget.semanticLabel,
            button: true,
            selected: widget.selected,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: widget.onPress,
              onLongPress: widget.onLongPress,
              child: widget.builder(context, _focused || _hovered, widget.child),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    widget.focusNode?.removeListener(_updateFocused);
    super.dispose();
  }

  void _updateFocused() => setState(() => _focused = widget.focusNode?.hasFocus ?? false);
}
