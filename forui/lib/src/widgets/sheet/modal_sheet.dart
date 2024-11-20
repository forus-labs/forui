import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';
import 'package:forui/src/widgets/sheet/shifted_sheet.dart';

const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

class _ModalSheet<T> extends StatefulWidget {
  final PopupRoute<T> route; // TODO: Change route to more specific.
  final Layout side;
  final FSheetStyle style;
  final double? mainAxisMaxRatio;
  final BoxConstraints constraints;
  final bool draggable;

  const _ModalSheet({
    required this.route,
    required this.side,
    required this.style,
    required this.mainAxisMaxRatio,
    required this.constraints,
    required this.draggable,
    super.key,
  });

  @override
  _ModalSheetState<T> createState() => _ModalSheetState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('route', route))
      ..add(EnumProperty('side', side))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('mainAxisMaxRatio', mainAxisMaxRatio))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(FlagProperty('draggable', value: draggable, ifTrue: 'draggable'));
  }
}

class _ModalSheetState<T> extends State<_ModalSheet<T>> {
  static const _cubic = Cubic(0.0, 0.0, 0.2, 1.0);

  ParametricCurve<double> _curve = _cubic;

  EdgeInsets _getNewClipDetails(Size topLayerSize) => EdgeInsets.fromLTRB(0, 0, 0, topLayerSize.height);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context), '');

    return AnimatedBuilder(
      animation: widget.route.animation!,
      builder: (context, child) => Semantics(
        scopesRoute: true,
        namesRoute: true,
        label: switch (defaultTargetPlatform) {
          TargetPlatform.iOS || TargetPlatform.macOS => null,
          _ => FLocalizations.of(context).dialogLabel,
        },
        explicitChildNodes: true,
        child: ClipRect(
          child: ShiftedSheet(
            side: widget.side,
            onChange: (size) => widget.route._didChangeBarrierSemanticsClip(_getNewClipDetails(size)),
            value: _curve.transform(widget.route.animation!.value),
            mainAxisMaxRatio: widget.mainAxisMaxRatio,
            child: child,
          ),
        ),
      ),
      child: Sheet(
        controller: widget.route._animationController,
        layout: widget.side,
        style: widget.style,
        constraints: widget.constraints,
        draggable: widget.draggable,
        builder: widget.route.builder,
        // Allow the bottom sheet to track the user's finger accurately.
        onDragStart: (details) => _curve = Curves.linear,
        // Allow the sheet to animate smoothly from its current position.
        onDragEnd: (details, {required closing}) => _curve = Split(widget.route.animation!.value, endCurve: _cubic),
        onClosing: () {
          if (widget.route.isCurrent) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
