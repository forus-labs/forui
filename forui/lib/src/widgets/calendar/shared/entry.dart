import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

final _yMMMMd = DateFormat.yMMMMd();

@internal
abstract class Entry extends StatelessWidget {
  final FCalendarEntryStyle style;
  final ValueWidgetBuilder<FTappableData> builder;

  factory Entry.day({
    required FCalendarDayPickerStyle style,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool today,
    required Predicate<LocalDate> selectable,
    required Predicate<LocalDate> selected,
    required ValueChanged<LocalDate> onPress,
    required ValueChanged<LocalDate> onLongPress,
  }) {
    final canSelect = selectable(date);
    final isSelected = selected(date);

    final styles = canSelect ? style.selectableStyles : style.unselectableStyles;
    final dayStyle = current ? styles.current : styles.enclosing;
    final entryStyle = isSelected ? dayStyle.selectedStyle : dayStyle.unselectedStyle;

    Widget builder(BuildContext context, FTappableData data, Widget? child) => _Content(
          style: entryStyle,
          borderRadius: BorderRadius.horizontal(
            left: isSelected && selected(date.yesterday) ? Radius.zero : entryStyle.radius,
            right: isSelected && selected(date.tomorrow) ? Radius.zero : entryStyle.radius,
          ),
          text: FLocalizations.of(context).day(date.toNative()),
          data: data,
          current: today,
        );

    if (canSelect) {
      return _SelectableEntry(
        focusNode: focusNode,
        date: date,
        semanticLabel: '${_yMMMMd.format(date.toNative())}${today ? ', Today' : ''}',
        selected: isSelected,
        onPress: onPress,
        onLongPress: onLongPress,
        style: entryStyle,
        builder: builder,
      );
    } else {
      return _UnselectableEntry(style: entryStyle, builder: builder);
    }
  }

  factory Entry.yearMonth({
    required FCalendarYearMonthPickerStyle style,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool selectable,
    required ValueChanged<LocalDate> onPress,
    required String Function(LocalDate) format,
  }) {
    final entryStyle = selectable ? style.enabledStyle : style.disabledStyle;

    Widget builder(BuildContext context, FTappableData data, Widget? child) => _Content(
          style: entryStyle,
          borderRadius: BorderRadius.all(entryStyle.radius),
          text: format(date),
          data: data,
          current: current,
        );

    if (selectable) {
      return _SelectableEntry(
        focusNode: focusNode,
        date: date,
        semanticLabel: format(date),
        onPress: onPress,
        style: entryStyle,
        builder: builder,
      );
    } else {
      return _UnselectableEntry(style: entryStyle, builder: builder);
    }
  }

  const Entry._({
    required this.style,
    required this.builder,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('builder', builder));
  }
}

class _SelectableEntry extends Entry {
  final FocusNode focusNode;
  final LocalDate date;
  final String semanticLabel;
  final bool selected;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate>? onLongPress;

  const _SelectableEntry({
    required this.focusNode,
    required this.date,
    required this.semanticLabel,
    required this.onPress,
    required super.style,
    required super.builder,
    this.selected = false,
    this.onLongPress,
  }) : super._();

  @override
  Widget build(BuildContext context) => FTappable(
        semanticLabel: semanticLabel,
        semanticSelected: selected,
        focusNode: focusNode,
        excludeSemantics: true,
        onPress: () => onPress(date),
        onLongPress: () => onLongPress?.call(date),
        builder: builder,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('date', date))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

class _UnselectableEntry extends Entry {
  const _UnselectableEntry({
    required super.style,
    required super.builder,
  }) : super._();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: builder(context, (focused: false, hovered: false), null),
      );
}

class _Content extends StatelessWidget {
  final FCalendarEntryStyle style;
  final BorderRadius borderRadius;
  final String text;
  final FTappableData data;
  final bool current;

  const _Content({
    required this.style,
    required this.borderRadius,
    required this.text,
    required this.data,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final hovered = data.hovered;
    var textStyle = hovered ? style.hoveredTextStyle : style.textStyle;
    if (current) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: data.focused ? Border.all(color: style.focusedBorderColor) : null,
        borderRadius: borderRadius,
        color: hovered ? style.hoveredBackgroundColor : style.backgroundColor,
      ),
      child: Center(
        child: Text(text, style: textStyle),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty('state', data.toString()))
      ..add(FlagProperty('current', value: current, ifTrue: 'current'));
  }
}

/// A calendar entry's style.
final class FCalendarEntryStyle with Diagnosticable {
  /// The day's background color.
  final Color backgroundColor;

  /// The day's text style.
  final TextStyle textStyle;

  /// The hovered day's background color. Defaults to [backgroundColor].
  final Color hoveredBackgroundColor;

  /// The hovered day's text style. Defaults to [textStyle].
  final TextStyle hoveredTextStyle;

  /// The border color when an entry is focused.
  final Color focusedBorderColor;

  /// The entry border's radius. Defaults to `Radius.circular(4)`.
  final Radius radius;

  /// Creates a [FCalendarEntryStyle].
  FCalendarEntryStyle({
    required this.backgroundColor,
    required this.textStyle,
    required this.focusedBorderColor,
    required this.radius,
    Color? hoveredBackgroundColor,
    TextStyle? hoveredTextStyle,
  })  : hoveredBackgroundColor = hoveredBackgroundColor ?? backgroundColor,
        hoveredTextStyle = hoveredTextStyle ?? textStyle;

  /// Returns a copy of this [FCalendarEntryStyle] but with the given fields replaced with the new values.
  @useResult
  FCalendarEntryStyle copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    Color? hoveredBackgroundColor,
    TextStyle? hoveredTextStyle,
    Color? focusedBorderColor,
    Radius? radius,
  }) =>
      FCalendarEntryStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textStyle: textStyle ?? this.textStyle,
        hoveredBackgroundColor: hoveredBackgroundColor ?? this.hoveredBackgroundColor,
        hoveredTextStyle: hoveredTextStyle ?? this.hoveredTextStyle,
        focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
        radius: radius ?? this.radius,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(ColorProperty('hoveredBackgroundColor', hoveredBackgroundColor))
      ..add(DiagnosticsProperty('hoveredTextStyle', hoveredTextStyle))
      ..add(ColorProperty('focusedBorderColor', focusedBorderColor))
      ..add(DiagnosticsProperty('radius', radius));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarEntryStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          textStyle == other.textStyle &&
          hoveredBackgroundColor == other.hoveredBackgroundColor &&
          hoveredTextStyle == other.hoveredTextStyle &&
          focusedBorderColor == other.focusedBorderColor &&
          radius == other.radius;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      textStyle.hashCode ^
      hoveredBackgroundColor.hashCode ^
      hoveredTextStyle.hashCode ^
      focusedBorderColor.hashCode ^
      radius.hashCode;
}
