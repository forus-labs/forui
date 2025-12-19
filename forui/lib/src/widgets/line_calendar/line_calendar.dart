import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar/calendar_layout.dart';

part 'line_calendar.design.dart';

/// A line calendar displays dates in a single horizontal, scrollable line.
///
/// ## Desktop and web note
/// As the dates scroll on the horizontal axis (left to right or right to left), hold Shift while using the mouse
/// scroll wheel to scroll the list.
///
/// See:
/// * https://forui.dev/docs/data/line-calendar for working examples.
/// * [FLineCalendarStyle] for customizing a line calendar's style.
class FLineCalendar extends StatelessWidget {
  static Widget _builder(BuildContext _, FLineCalendarItemData _, Widget? child) => child!;

  /// Defines how this line calendar's value is controlled.
  final FLineCalendarControl control;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create line-calendar
  /// ```
  final FLineCalendarStyle Function(FLineCalendarStyle style)? style;

  /// The alignment to which the initially scrolled date will be aligned. Defaults to [Alignment.center].
  final AlignmentDirectional initialScrollAlignment;

  /// How the scroll view should respond to user input.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro forui.foundation.doc_templates.cacheExtent}
  final double? cacheExtent;

  /// [ScrollViewKeyboardDismissBehavior] the defines how this [FLineCalendar] will dismiss the keyboard automatically.
  ///
  /// Defaults to [ScrollViewKeyboardDismissBehavior.manual].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// The builder used to build a line calendar item. Defaults to returning the given child.
  ///
  /// The `child` is the default content with no alterations. Consider wrapping the `child` and other custom decoration
  /// in a [Stack] to avoid re-creating the custom content from scratch.
  final ValueWidgetBuilder<FLineCalendarItemData> builder;

  final LocalDate _start;
  final LocalDate? _end;
  final LocalDate? _initialScroll;
  final LocalDate _today;

  /// Creates a [FLineCalendar].
  ///
  /// [start] represents the start date, inclusive. It is truncated to the nearest date. Defaults to the
  /// [DateTime.utc(1900)].
  ///
  /// [end] represents the end date, exclusive. It is truncated to the nearest date.
  ///
  /// [initialScroll] represents the initial date to which the line calendar is scrolled. It is aligned based on
  /// [initialScrollAlignment]. It is truncated to the nearest date. Defaults to [today] if not provided.
  ///
  /// [today] represents the current date. It is truncated to the nearest date. Defaults to the [DateTime.now].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [end] <= [start].
  /// * [initialScroll] < [start] or [end] <= [initialScroll].
  /// * [today] < [start] or [end] <= [today].
  FLineCalendar({
    this.control = const .managed(),
    this.style,
    this.initialScrollAlignment = .center,
    this.physics,
    this.cacheExtent,
    this.keyboardDismissBehavior = .manual,
    this.builder = _builder,
    DateTime? start,
    DateTime? end,
    DateTime? initialScroll,
    DateTime? today,
    super.key,
  }) : _start = (start ?? .utc(1900)).toLocalDate(),
       _end = end?.toLocalDate(),
       _initialScroll = initialScroll?.toLocalDate(),
       _today = (today ?? .now()).toLocalDate(),
       assert(
         start == null || end == null || start.toLocalDate() < end.toLocalDate(),
         'start ($start) must be < end ($end)',
       ),
       assert(
         initialScroll == null ||
             start == null ||
             (initialScroll.toLocalDate() >= start.toLocalDate() && initialScroll.toLocalDate() < end!.toLocalDate()),
         'initialScroll ($initialScroll) must be >= start ($start)',
       ),
       assert(
         today == null ||
             start == null ||
             (today.toLocalDate() >= start.toLocalDate() && today.toLocalDate() < end!.toLocalDate()),
         'today ($today) must be >= start ($start) and < end ($end)',
       );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => CalendarLayout(
      control: control,
      style: style?.call(context.theme.lineCalendarStyle) ?? context.theme.lineCalendarStyle,
      physics: physics,
      cacheExtent: cacheExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      scale: MediaQuery.textScalerOf(context),
      textStyle: DefaultTextStyle.of(context).style,
      builder: builder,
      start: _start,
      end: _end,
      initialScroll: _initialScroll,
      today: _today,
      constraints: constraints,
      alignment: initialScrollAlignment,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('initialScrollAlignment', initialScrollAlignment))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DiagnosticsProperty('keyboardDismissBehavior', keyboardDismissBehavior))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// [FLineCalendar]'s style.
class FLineCalendarStyle with Diagnosticable, _$FLineCalendarStyleFunctions {
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The vertical height between the content and the edges. Defaults to 15.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if negative.
  @override
  final double contentEdgeSpacing;

  /// The vertical height between the date and weekday. Defaults to 2.
  ///
  /// ## Contract
  /// Throws [AssertionError] if negative.
  @override
  final double contentSpacing;

  /// The decoration.
  ///
  /// @macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The color of the today indicator.
  ///
  /// @macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Color> todayIndicatorColor;

  /// The text style for the date.
  ///
  /// @macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> dateTextStyle;

  /// The text style for the day of the week.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> weekdayTextStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.decoration,
    required this.todayIndicatorColor,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
    required this.tappableStyle,
    this.padding = const .symmetric(horizontal: 6.5),
    this.contentEdgeSpacing = 15.5,
    this.contentSpacing = 2,
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties.
  factory FLineCalendarStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final focusedBorder = Border.all(color: colors.primary, width: style.borderWidth);
    return .new(
      decoration: FWidgetStateMap({
        WidgetState.disabled & WidgetState.selected & WidgetState.focused: BoxDecoration(
          color: colors.disable(colors.primary),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled & WidgetState.selected: BoxDecoration(
          color: colors.disable(colors.primary),
          border: .all(color: colors.border),
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled & WidgetState.focused: BoxDecoration(
          color: colors.background,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled: BoxDecoration(
          color: colors.background,
          border: .all(color: colors.border),
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected & (WidgetState.hovered | WidgetState.pressed) & WidgetState.focused: BoxDecoration(
          color: colors.hover(colors.primary),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): BoxDecoration(
          color: colors.hover(colors.primary),
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected & WidgetState.focused: BoxDecoration(
          color: colors.primary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected: BoxDecoration(color: colors.primary, borderRadius: style.borderRadius),
        (WidgetState.hovered | WidgetState.pressed) & WidgetState.focused: BoxDecoration(
          color: colors.secondary,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        (WidgetState.hovered | WidgetState.pressed): BoxDecoration(
          color: colors.secondary,
          border: Border.all(color: colors.border),
          borderRadius: style.borderRadius,
        ),
        WidgetState.focused: BoxDecoration(
          color: colors.background,
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.any: BoxDecoration(
          color: colors.background,
          border: .all(color: colors.border),
          borderRadius: style.borderRadius,
        ),
      }),
      todayIndicatorColor: FWidgetStateMap({
        WidgetState.disabled & WidgetState.selected: colors.disable(colors.primaryForeground),
        WidgetState.disabled: colors.disable(colors.mutedForeground),
        WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): colors.hover(colors.primaryForeground),
        WidgetState.selected: colors.primaryForeground,
        (WidgetState.hovered | WidgetState.pressed): colors.hover(colors.primary),
        WidgetState.any: colors.primary,
      }),
      dateTextStyle: FWidgetStateMap({
        WidgetState.disabled & WidgetState.selected: typography.xl.copyWith(
          color: colors.disable(colors.primaryForeground),
          fontWeight: .w500,
          height: 0,
        ),
        WidgetState.disabled: typography.xl.copyWith(
          color: colors.disable(colors.mutedForeground),
          fontWeight: .w500,
          height: 0,
        ),
        WidgetState.selected: typography.xl.copyWith(color: colors.primaryForeground, fontWeight: .w500, height: 0),
        WidgetState.any: typography.xl.copyWith(color: colors.primary, fontWeight: .w500, height: 0),
      }),
      weekdayTextStyle: FWidgetStateMap({
        WidgetState.disabled & WidgetState.selected: typography.xs.copyWith(
          color: colors.disable(colors.primaryForeground),
          fontWeight: .w500,
          height: 0,
        ),
        WidgetState.disabled: typography.xs.copyWith(
          color: colors.disable(colors.mutedForeground),
          fontWeight: .w500,
          height: 0,
        ),
        WidgetState.selected: typography.xs.copyWith(color: colors.primaryForeground, fontWeight: .w500, height: 0),
        WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground, fontWeight: .w500, height: 0),
      }),
      tappableStyle: style.tappableStyle,
    );
  }
}
