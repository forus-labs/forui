import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_tile.dart';

const _textSpacing = 2.0;

/// A calendar that can be scrolled horizontally.
class FLineCalendar extends StatefulWidget {
  /// The style. Defaults to [FThemeData.lineCalendarStyle].
  final FLineCalendarStyle? style;

  /// The controller.
  final FCalendarController<DateTime?> controller;

  /// Whether the calendar should focus itself if nothing else is already focused. Defaults to false.
  final bool autofocus;

  /// Defines the [FocusNode] for this line calendar.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// The start date. It is truncated to the nearest date.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [end] <= [start].
  final DateTime start;

  /// The end date. It is truncated to the nearest date.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [end] <= [start].
  final DateTime? end;

  /// The current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  final DateTime today;

  /// Creates a [FLineCalendar].
  FLineCalendar({
    required this.controller,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.end,
    DateTime? start,
    DateTime? today,
    super.key,
  })  : start = start ?? DateTime(1900).toUtc(),
        today = today ?? DateTime.now().toUtc(),
        assert(
          start == null || end == null || start.toLocalDate() < end.toLocalDate(),
          'end date must be greater than start date',
        );

  @override
  State<FLineCalendar> createState() => _FLineCalendarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus));
    properties.add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode));
    properties.add(ObjectFlagProperty<ValueChanged<bool>?>.has('onFocusChange', onFocusChange));
  }
}

class _FLineCalendarState extends State<FLineCalendar> {
  late ScrollController _controller;
  late final FocusNode _focusNode;
  late double _size;
  late FLineCalendarStyle _style;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = widget.style ?? context.theme.lineCalendarStyle;
    _size = _calculateSize(context, _style);

    final value = (widget.controller.value ?? widget.today).toLocalDate();
    final offset = (value.difference(widget.start.toLocalDate()).inDays - 2) * _size + _style.itemPadding.horizontal;

    _controller = ScrollController(initialScrollOffset: offset);
  }

  // TODO: calculate width of items based on the text font size.
  double _calculateSize(BuildContext context, FLineCalendarStyle style) {
    final textScalor = MediaQuery.textScalerOf(context);
    final dateTextSize = textScalor.scale(style.content.unselectedDateTextStyle.fontSize!);
    final dayTextSize = textScalor.scale(style.content.unselectedDayTextStyle.fontSize!);
    return dateTextSize + dayTextSize + _textSpacing + (style.content.verticalPadding * 2);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _size,
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.arrowRight): () {
              widget.controller.value = widget.controller.value?.add(const Duration(days: 1));
              _controller.animateTo(
                _controller.offset + _size,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            },
            const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
              widget.controller.value = widget.controller.value?.subtract(const Duration(days: 1));
              _controller.animateTo(
                _controller.offset - _size,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            },
          },
          child: Focus(
            autofocus: widget.autofocus,
            focusNode: _focusNode,
            onFocusChange: (focused) => widget.onFocusChange?.call(focused),
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemExtent: _size,
              itemBuilder: (context, index) {
                final date = widget.start.add(Duration(days: index));
                return Padding(
                  padding: _style.itemPadding,
                  child: FLineCalendarTile(
                    focusNode: _focusNode,
                    style: _style,
                    controller: widget.controller,
                    date: date,
                    isToday: widget.today.toLocalDate() == date.toLocalDate(),
                  ),
                );
              },
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

/// [FLineCalendar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if itemPadding is negative.
  final EdgeInsets itemPadding;

  /// The box decoration for a selected date.
  final BoxDecoration selectedDecoration;

  /// The box decoration for an unselected date.
  final BoxDecoration unselectedDecoration;

  /// The color of the indicator for the selected current date.
  final Color selectedCurrentDateIndicatorColor;

  /// The color of the indicator for the unselected current date.
  final Color unselectedCurrentDateIndicatorColor;

  /// The content's style.
  final FLineCalendarContentStyle content;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.selectedCurrentDateIndicatorColor,
    required this.unselectedCurrentDateIndicatorColor,
    required this.selectedDecoration,
    required this.unselectedDecoration,
    required this.content,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 6.5),
  }) : assert(itemPadding.isNonNegative, 'itemPadding must be non-negative');

  /// Creates a [FLineCalendarStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          selectedCurrentDateIndicatorColor: colorScheme.primaryForeground,
          unselectedCurrentDateIndicatorColor: colorScheme.primary,
          selectedDecoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: style.borderRadius,
          ),
          unselectedDecoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
            border: Border.all(color: colorScheme.border),
          ),
          content: FLineCalendarContentStyle.inherit(colorScheme: colorScheme, typography: typography),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(ColorProperty('selectedCurrentDateIndicatorColor', selectedCurrentDateIndicatorColor))
      ..add(ColorProperty('unselectedCurrentDateIndicatorColor', unselectedCurrentDateIndicatorColor))
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('content', content));
  }

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsets? itemPadding,
    Color? selectedCurrentDateIndicatorColor,
    Color? unselectedCurrentDateIndicatorColor,
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    FLineCalendarContentStyle? content,
  }) =>
      FLineCalendarStyle(
        itemPadding: itemPadding ?? this.itemPadding,
        selectedCurrentDateIndicatorColor: selectedCurrentDateIndicatorColor ?? this.selectedCurrentDateIndicatorColor,
        unselectedCurrentDateIndicatorColor:
            unselectedCurrentDateIndicatorColor ?? this.unselectedCurrentDateIndicatorColor,
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
        content: content ?? this.content,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FLineCalendarStyle &&
          runtimeType == other.runtimeType &&
          itemPadding == other.itemPadding &&
          selectedCurrentDateIndicatorColor == other.selectedCurrentDateIndicatorColor &&
          unselectedCurrentDateIndicatorColor == other.unselectedCurrentDateIndicatorColor &&
          selectedDecoration == other.selectedDecoration &&
          unselectedDecoration == other.unselectedDecoration &&
          content == other.content;

  @override
  int get hashCode =>
      itemPadding.hashCode ^
      selectedCurrentDateIndicatorColor.hashCode ^
      unselectedCurrentDateIndicatorColor.hashCode ^
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      content.hashCode;
}
