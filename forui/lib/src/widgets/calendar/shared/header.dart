import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

part 'header.style.dart';

/// The current picker type.
enum FCalendarPickerType {
  /// The day picker.
  day,

  /// The year-month picker.
  yearMonth,
}

@internal
class Header extends StatefulWidget {
  static const height = 31.0;

  final FCalendarHeaderStyle style;
  final ValueNotifier<FCalendarPickerType> type;
  final LocalDate month;

  const Header({required this.style, required this.type, required this.month, super.key});

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
  Widget build(BuildContext context) => FTappable(
    focusedOutlineStyle: widget.style.focusedOutlineStyle,
    onPress:
        () =>
            widget.type.value = switch (widget.type.value) {
              FCalendarPickerType.day => FCalendarPickerType.yearMonth,
              FCalendarPickerType.yearMonth => FCalendarPickerType.day,
            },
    excludeSemantics: true,
    builder:
        (_, states, _) => SizedBox(
          height: Header.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (FLocalizations.of(context) ?? FDefaultLocalizations()).yearMonth(widget.month.toNative()),
                  style: widget.style.headerTextStyle,
                ),
                RotationTransition(
                  turns: Tween(
                    begin: 0.0,
                    end: Directionality.maybeOf(context) == TextDirection.rtl ? -0.25 : 0.25,
                  ).animate(_controller),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconTheme(
                      data: widget.style.buttonStyle.iconContentStyle.iconStyle
                          .resolve(states)
                          .copyWith(color: widget.style.headerTextStyle.color),
                      child: const Icon(FIcons.chevronRight, size: 15),
                    ),
                  ),
                ),
              ],
            ),
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

  const Navigation({required this.style, required this.onPrevious, required this.onNext, super.key});

  @override
  Widget build(BuildContext _) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: SizedBox(
      height: Header.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 7),
            child: FButton.icon(style: style.buttonStyle, onPress: onPrevious, child: const Icon(FIcons.chevronLeft)),
          ),

          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 7),
            child: FButton.icon(style: style.buttonStyle, onPress: onNext, child: const Icon(FIcons.chevronRight)),
          ),
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPrevious', onPrevious))
      ..add(ObjectFlagProperty.has('onNext', onNext));
  }
}

/// The calendar header's style.
final class FCalendarHeaderStyle with Diagnosticable, _$FCalendarHeaderStyleFunctions {
  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The button style.
  @override
  final FButtonStyle buttonStyle;

  /// The header's text style.
  @override
  final TextStyle headerTextStyle;

  /// The arrow turn animation's duration. Defaults to 200ms.
  @override
  final Duration animationDuration;

  /// Creates a [FCalendarHeaderStyle].
  FCalendarHeaderStyle({
    required this.focusedOutlineStyle,
    required this.buttonStyle,
    required this.headerTextStyle,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FCalendarHeaderStyle] that inherits its properties.
  factory FCalendarHeaderStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final outline = FButtonStyles.inherit(colors: colors, typography: typography, style: style).outline;
    return FCalendarHeaderStyle(
      focusedOutlineStyle: style.focusedOutlineStyle,
      buttonStyle: outline.copyWith(
        decoration: outline.decoration.map((d) => d.copyWith(borderRadius: BorderRadius.circular(4))),
        iconContentStyle: FButtonIconContentStyle(
          iconStyle: FWidgetStateMap({
            WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 17),
            WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 17),
          }),
        ),
      ),
      headerTextStyle: typography.base.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
    );
  }
}
