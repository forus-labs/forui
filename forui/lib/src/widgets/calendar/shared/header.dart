import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/inkwell.dart';

/// The current picker type.
enum FCalendarPickerType {
  /// The day picker.
  day,

  /// The year-month picker.
  yearMonth,
}

final _yMMMM = DateFormat.yMMMM();

@internal
class Header extends StatefulWidget {
  static const height = 31.0;

  final FCalendarHeaderStyle style;
  final ValueNotifier<FCalendarPickerType> type;
  final LocalDate month;

  const Header({
    required this.style,
    required this.type,
    required this.month,
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('month', month));
  }
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.type.addListener(_animate);
    _controller = AnimationController(vsync: this, duration: widget.style.animationDuration);
    _controller.value = widget.type.value == FCalendarPickerType.day ? 0.0 : 1.0;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: Header.height,
        child: FInkWell(
          onPress: () => widget.type.value = switch (widget.type.value) {
            FCalendarPickerType.day => FCalendarPickerType.yearMonth,
            FCalendarPickerType.yearMonth => FCalendarPickerType.day,
          },
          builder: (context, _, child) => child!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_yMMMM.format(widget.month.toNative()), style: widget.style.headerTextStyle), // TODO: Localization
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(_controller),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FAssets.icons.chevronRight(
                    height: 15,
                    colorFilter: ColorFilter.mode(context.theme.colorScheme.primary, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void didUpdateWidget(Header old) {
    super.didUpdateWidget(old);
    old.type.removeListener(_animate);
    widget.type.addListener(_animate);
  }

  @override
  void dispose() {
    widget.type.removeListener(_animate);
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    // we check the picker type to prevent de-syncs
    switch ((widget.type.value, _controller.isCompleted)) {
      case (FCalendarPickerType.yearMonth, false):
        _controller.forward();
      case (FCalendarPickerType.day, true):
        _controller.reverse();

      case _:
    }
  }
}

@internal
class Navigation extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const Navigation({
    required this.style,
    required this.onPrevious,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = context.theme.buttonStyles.outline;
    final effectiveButtonStyle = buttonStyle.copyWith(
      enabledBoxDecoration: buttonStyle.enabledBoxDecoration.copyWith(borderRadius: BorderRadius.circular(4)),
      disabledBoxDecoration: buttonStyle.disabledBoxDecoration.copyWith(borderRadius: BorderRadius.circular(4)),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: Header.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: FButton.raw(
                // TODO: Replace with FButton.icon.
                style: effectiveButtonStyle,
                onPress: onPrevious,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: FAssets.icons.chevronLeft(
                    height: 17,
                    colorFilter: ColorFilter.mode(style.iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: FButton.raw(
                // TODO: Replace with FButton.icon.
                style: effectiveButtonStyle,
                onPress: onNext,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: FAssets.icons.chevronRight(
                    height: 17,
                    colorFilter: ColorFilter.mode(style.iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('onPrevious', onPrevious))
      ..add(DiagnosticsProperty('onNext', onNext));
  }
}

/// The calendar header's style.
final class FCalendarHeaderStyle with Diagnosticable {
  /// The header's text style.
  final TextStyle headerTextStyle;

  /// The header icons' color.
  final Color iconColor;

  /// The arrow turn animation's duration. Defaults to `Duration(milliseconds: 200)`.
  final Duration animationDuration;

  /// Creates a [FCalendarHeaderStyle].
  FCalendarHeaderStyle({
    required this.headerTextStyle,
    required this.iconColor,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FCalendarHeaderStyle] that inherits its values from the given [colorScheme] and [typography].
  FCalendarHeaderStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          headerTextStyle: typography.sm.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
          iconColor: colorScheme.mutedForeground,
        );

  /// Creates a copy of this but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FCalendarHeaderStyle(
  ///   headerTextStyle: ...,
  ///   iconColor:...,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(
  ///   iconColor: ...,
  /// );
  ///
  /// print(style.headerTextStyle == copy.headerTextStyle); // true
  /// print(style.iconColor == copy.iconColor); // false
  /// ```
  FCalendarHeaderStyle copyWith({
    TextStyle? headerTextStyle,
    Color? iconColor,
    Duration? animationDuration,
  }) =>
      FCalendarHeaderStyle(
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        iconColor: iconColor ?? this.iconColor,
        animationDuration: animationDuration ?? this.animationDuration,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(DiagnosticsProperty('animationDuration', animationDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarHeaderStyle &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          iconColor == other.iconColor &&
          animationDuration == other.animationDuration;

  @override
  int get hashCode => headerTextStyle.hashCode ^ iconColor.hashCode ^ animationDuration.hashCode;
}
