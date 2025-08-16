import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_item.dart';

@internal
class CalendarLayout extends StatefulWidget {
  final FCalendarController<DateTime?>? controller;
  final FLineCalendarStyle style;
  final AlignmentDirectional alignment;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final TextScaler scale;
  final TextStyle textStyle;
  final ValueWidgetBuilder<FLineCalendarItemData> builder;
  final ValueChanged<DateTime?>? onChange;
  final bool toggleable;
  final LocalDate start;
  final LocalDate? end;
  final LocalDate? initialScroll;
  final LocalDate? initialSelection;
  final LocalDate today;
  final BoxConstraints constraints;

  const CalendarLayout({
    required this.controller,
    required this.style,
    required this.alignment,
    required this.physics,
    required this.cacheExtent,
    required this.keyboardDismissBehavior,
    required this.scale,
    required this.textStyle,
    required this.builder,
    required this.onChange,
    required this.toggleable,
    required this.start,
    required this.end,
    required this.initialScroll,
    required this.initialSelection,
    required this.today,
    required this.constraints,
    super.key,
  });

  @override
  State<CalendarLayout> createState() => _CalendarLayoutState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DiagnosticsProperty('keyboardDismissBehavior', keyboardDismissBehavior))
      ..add(DiagnosticsProperty('scaler', scale))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable'))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('initialScroll', initialScroll))
      ..add(DiagnosticsProperty('initialSelection', initialSelection))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}

class _CalendarLayoutState extends State<CalendarLayout> {
  late FCalendarController<DateTime?> _controller;
  late ScrollController _scrollController;
  late double _width;

  @override
  void initState() {
    super.initState();
    _width = _estimateWidth();

    _controller =
        widget.controller ??
        FCalendarController.date(initialSelection: widget.initialSelection?.toNative(), toggleable: widget.toggleable);
    _controller.addValueListener(_onChange);

    final start = ((widget.initialScroll ?? widget.today).difference(widget.start).inDays) * _width;
    _scrollController = ScrollController(
      initialScrollOffset: switch (widget.alignment.start) {
        -1 => start,
        1 => start - widget.constraints.maxWidth + _width,
        _ => start - (widget.constraints.maxWidth - _width) / 2,
      },
    );
  }

  @override
  void didUpdateWidget(covariant CalendarLayout old) {
    super.didUpdateWidget(old);
    if (widget.style != old.style || widget.scale != old.scale || widget.textStyle != old.textStyle) {
      _width = _estimateWidth();
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        _controller.removeValueListener(_onChange);
      }

      _controller =
          widget.controller ??
          FCalendarController.date(initialSelection: _controller.value, toggleable: widget.toggleable);
      _controller.addValueListener(_onChange);
    }
  }

  double _estimateWidth() {
    final scale = widget.scale;
    final textStyle = widget.textStyle;

    double height(FLineCalendarStyle style, Set<WidgetState> states) {
      final dateHeight = scale.scale(style.dateTextStyle.resolve(states).fontSize ?? textStyle.fontSize ?? 0);
      final weekdayHeight = scale.scale(style.weekdayTextStyle.resolve(states).fontSize ?? textStyle.fontSize ?? 0);
      final otherHeight = widget.style.contentSpacing + (widget.style.contentEdgeSpacing * 2);

      return dateHeight + weekdayHeight + otherHeight;
    }

    // We use the height to estimate the width.
    return [
      height(widget.style, const {WidgetState.selected}),
      height(widget.style, const {WidgetState.selected, WidgetState.hovered}),
      height(widget.style, const {WidgetState.hovered}),
      height(widget.style, const {}),
    ].max!;
  }

  void _onChange(DateTime? date) => widget.onChange?.call(date);

  @override
  Widget build(BuildContext _) {
    final placeholder = widget.today.toNative();
    return SpeculativeLayout(
      children: [
        ItemContent(style: widget.style, states: const {WidgetState.selected}, date: placeholder),
        ItemContent(style: widget.style, states: const {WidgetState.selected, WidgetState.hovered}, date: placeholder),
        ItemContent(style: widget.style, states: const {}, date: placeholder),
        ItemContent(style: widget.style, states: const {WidgetState.hovered}, date: placeholder),
        ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          physics: widget.physics,
          cacheExtent: widget.cacheExtent,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          itemExtent: _width,
          itemCount: widget.end == null ? null : widget.end!.difference(widget.start).inDays + 1,
          itemBuilder: (_, index) {
            final date = widget.start.plus(days: index);
            return Padding(
              padding: widget.style.padding,
              child: Item(
                controller: _controller,
                style: widget.style,
                date: date.toNative(),
                today: widget.today == date,
                builder: widget.builder,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeValueListener(_onChange);
    }
    super.dispose();
  }
}

@internal
class SpeculativeLayout extends MultiChildRenderObjectWidget {
  const SpeculativeLayout({required super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext _) => _SpeculativeBox();
}

class _SpeculativeBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  @override
  void setupParentData(RenderObject child) => child.parentData = DefaultData();

  @override
  void performLayout() {
    final selected = firstChild!;
    final selectedHovered = childAfter(selected)!;
    final unselected = childAfter(selectedHovered)!;
    final unselectedHovered = childAfter(unselected)!;

    final maxHeight = [
      selected.getDryLayout(constraints).height,
      selectedHovered.getDryLayout(constraints).height,
      unselected.getDryLayout(constraints).height,
      unselectedHovered.getDryLayout(constraints).height,
    ].max!;

    final heightConstraints = constraints.copyWith(maxHeight: maxHeight);
    final viewport = childAfter(unselectedHovered)!..layout(heightConstraints, parentUsesSize: true);
    size = constraints.constrain(viewport.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) => context.paintChild(lastChild!, offset);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final viewport = lastChild!;
    return result.addWithPaintOffset(
      offset: viewport.data.offset,
      position: position,
      hitTest: (result, transformed) => viewport.hitTest(result, position: transformed),
    );
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) => visitor(lastChild!);
}
