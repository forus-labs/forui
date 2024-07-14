import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/src/foundation/inkwell.dart';
import 'package:forui/src/widgets/calendar/day/day_picker.dart';
import 'package:forui/src/widgets/calendar/year_month_picker.dart';

final _yMMMMd = DateFormat.yMMMMd();

@internal
abstract class Entry extends StatelessWidget {
  final FCalendarEntryStyle style;
  final ValueWidgetBuilder<bool> builder;

  factory Entry.day({
    required FCalendarDayPickerStyle style,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool today,
    required Predicate<LocalDate> enabled,
    required Predicate<LocalDate> selected,
    required ValueChanged<LocalDate> onPress,
    required ValueChanged<LocalDate> onLongPress,
  }) {
    final enable = enabled(date);
    final select = selected(date);

    final styles = enable ? style.enabledStyles : style.disabledStyles;
    final dayStyle = current ? styles.current : styles.enclosing;
    final entryStyle = select ? dayStyle.selectedStyle : dayStyle.unselectedStyle;

    // ignore: avoid_positional_boolean_parameters
    Widget builder(BuildContext context, bool focused, Widget? child) => _Content(
          style: entryStyle,
          borderRadius: BorderRadius.horizontal(
            left: selected(date.yesterday) ? Radius.zero : const Radius.circular(4),
            right: selected(date.tomorrow) ? Radius.zero : const Radius.circular(4),
          ),
          text: '${date.day}', // TODO: localization
          focused: focused,
          current: today,
        );

    if (enabled(date)) {
      return _EnabledEntry(
        focusNode: focusNode,
        date: date,
        semanticLabel: '${_yMMMMd.format(date.toNative())}${today ? ', Today' : ''}',
        selected: selected(date),
        onPress: onPress,
        onLongPress: onLongPress,
        style: entryStyle,
        builder: builder,
      );
    } else {
      return _DisabledEntry(style: entryStyle, builder: builder);
    }
  }

  factory Entry.yearMonth({
    required FCalendarYearMonthPickerStyle style,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool enabled,
    required ValueChanged<LocalDate> onPress,
    required String Function(LocalDate) format,
  }) {
    final entryStyle = enabled ? style.enabledStyle : style.disabledStyle;

    // ignore: avoid_positional_boolean_parameters
    Widget builder(BuildContext context, bool focused, Widget? child) => _Content(
          style: entryStyle,
          borderRadius: BorderRadius.circular(8),
          text: format(date),
          focused: focused,
          current: current,
        );

    if (enabled) {
      return _EnabledEntry(
        focusNode: focusNode,
        date: date,
        semanticLabel: format(date),
        onPress: onPress,
        style: entryStyle,
        builder: builder,
      );
    } else {
      return _DisabledEntry(style: entryStyle, builder: builder);
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

class _EnabledEntry extends Entry {
  final FocusNode focusNode;
  final LocalDate date;
  final String semanticLabel;
  final bool selected;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate>? onLongPress;

  const _EnabledEntry({
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
  Widget build(BuildContext context) => FInkWell(
        focusNode: focusNode,
        semanticLabel: semanticLabel,
        selected: selected,
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
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

class _DisabledEntry extends Entry {
  const _DisabledEntry({
    required super.style,
    required super.builder,
  }) : super._();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(child: builder(context, false, null));
}

class _Content extends StatelessWidget {
  final FCalendarEntryStyle style;
  final BorderRadius borderRadius;
  final String text;
  final bool focused;
  final bool current;

  const _Content({
    required this.style,
    required this.borderRadius,
    required this.text,
    required this.focused,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = focused ? style.focusedTextStyle : style.textStyle;
    if (current) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: focused ? style.focusedBackgroundColor : style.backgroundColor,
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
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'))
      ..add(FlagProperty('current', value: current, ifTrue: 'current'));
  }
}

/// A calendar entry's style.
final class FCalendarEntryStyle with Diagnosticable {
  /// The unfocused day's background color.
  final Color backgroundColor;

  /// The unfocused day's text style.
  final TextStyle textStyle;

  /// The focused day's background color. Defaults to [backgroundColor].
  final Color focusedBackgroundColor;

  /// The focused day's text style. Defaults to [textStyle].
  final TextStyle focusedTextStyle;

  /// Creates a [FCalendarEntryStyle].
  FCalendarEntryStyle({
    required this.backgroundColor,
    required this.textStyle,
    Color? focusedBackgroundColor,
    TextStyle? focusedTextStyle,
  })  : focusedBackgroundColor = focusedBackgroundColor ?? backgroundColor,
        focusedTextStyle = focusedTextStyle ?? textStyle;

  /// Returns a copy of this [FCalendarEntryStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FCalendarEntryStyle(
  ///   backgroundColor: ...,
  ///   textStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   textStyle: ...,
  /// );
  ///
  /// print(style.backgroundColor == copy.backgroundColor); // true
  /// print(style.textStyle == copy.textStyle); // false
  /// ```
  FCalendarEntryStyle copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    Color? focusedBackgroundColor,
    TextStyle? focusedTextStyle,
  }) =>
      FCalendarEntryStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textStyle: textStyle ?? this.textStyle,
        focusedBackgroundColor: focusedBackgroundColor ?? this.focusedBackgroundColor,
        focusedTextStyle: focusedTextStyle ?? this.focusedTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(ColorProperty('focusedBackgroundColor', focusedBackgroundColor))
      ..add(DiagnosticsProperty('focusedTextStyle', focusedTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarEntryStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          textStyle == other.textStyle &&
          focusedBackgroundColor == other.focusedBackgroundColor &&
          focusedTextStyle == other.focusedTextStyle;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^ textStyle.hashCode ^ focusedBackgroundColor.hashCode ^ focusedTextStyle.hashCode;
}
