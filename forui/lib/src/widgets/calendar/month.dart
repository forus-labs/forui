part of 'calendar.dart';

@internal
class Month extends StatelessWidget {
  final DateTime month;
  final DateTime today;

  const Month({
    required this.month,
    required this.today,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final first = month.firstDayOfMonth;

    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 5,
    );
  }
}


/// A month's style.
final class FMonthStyle with Diagnosticable {
  /// The enabled and disabled styles for the current month on display.
  final ({FDayStyle enabled, FDayStyle disabled}) current;

  /// The enabled and disabled styles for the months enclosing the current month on display.
  final ({FDayStyle enabled, FDayStyle disabled}) enclosing;

  /// Creates a [FMonthStyle].
  const FMonthStyle({
    required this.current,
    required this.enclosing,
  });

  /// Creates a [FMonthStyle] that inherits from the given [colorScheme] and [typography].
  factory FMonthStyle.inherit({required FColorScheme colorScheme, required FTypography typography}) {
    final textStyle = typography.sm.copyWith(color: colorScheme.foreground);
    final mutedTextStyle = typography.sm.copyWith(color: colorScheme.mutedForeground);

    final disabled = FDayStyle(
      todayStyle: FDayStateStyle.inherit(
        color: colorScheme.primaryForeground,
        textStyle: mutedTextStyle,
      ),
      unselectedStyle: FDayStateStyle.inherit(
        textStyle: mutedTextStyle,
      ),
      selectedStyle: FDayStateStyle.inherit(
        color: colorScheme.primaryForeground,
        textStyle: mutedTextStyle,
      ),
    );

    return FMonthStyle(
      current: (
      enabled: FDayStyle(
        todayStyle: FDayStateStyle.inherit(
          color: colorScheme.secondary,
          textStyle: textStyle,
        ),
        unselectedStyle: FDayStateStyle.inherit(
          textStyle: textStyle,
          focusedColor: colorScheme.secondary,
        ),
        selectedStyle: FDayStateStyle.inherit(
          color: colorScheme.foreground,
          textStyle: typography.sm.copyWith(color: colorScheme.background),
        ),
      ),
      disabled: disabled,
      ),
      enclosing: (
      enabled: FDayStyle(
        todayStyle: FDayStateStyle.inherit(
          color: colorScheme.primaryForeground,
          textStyle: mutedTextStyle,
          focusedTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
        ),
        unselectedStyle: FDayStateStyle.inherit(
          textStyle: mutedTextStyle,
        ),
        selectedStyle: FDayStateStyle.inherit(
          color: colorScheme.primaryForeground,
          textStyle: mutedTextStyle,
          focusedTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
        ),
      ),
      disabled: disabled,
      ),
    );
  }

  /// Returns a copy of this [FMonthStyle] but with the given fields replaced with the new values.
  FMonthStyle copyWith({
    FDayStyle? currentEnabled,
    FDayStyle? currentDisabled,
    FDayStyle? enclosingEnabled,
    FDayStyle? enclosingDisabled,
  }) =>
      FMonthStyle(
        current: (
        enabled: currentEnabled ?? current.enabled,
        disabled: currentDisabled ?? current.disabled,
        ),
        enclosing: (
        enabled: enclosingEnabled ?? enclosing.enabled,
        disabled: enclosingDisabled ?? enclosing.disabled,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('current.enabled', current.enabled))
      ..add(DiagnosticsProperty('current.disabled', current.disabled))
      ..add(DiagnosticsProperty('enclosing.enabled', enclosing.enabled))
      ..add(DiagnosticsProperty('enclosing.disabled', enclosing.disabled));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FMonthStyle &&
              runtimeType == other.runtimeType &&
              current == other.current &&
              enclosing == other.enclosing;

  @override
  int get hashCode => current.hashCode ^ enclosing.hashCode;
}
