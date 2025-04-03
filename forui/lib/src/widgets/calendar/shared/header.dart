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
    style: widget.style.tappableStyle,
    focusedOutlineStyle: widget.style.focusedOutlineStyle,
    onPress:
        () =>
            widget.type.value = switch (widget.type.value) {
              FCalendarPickerType.day => FCalendarPickerType.yearMonth,
              FCalendarPickerType.yearMonth => FCalendarPickerType.day,
            },
    excludeSemantics: true,
    child: SizedBox(
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
                child: Icon(
                  FIcons.chevronRight,
                  size: 15,
                  color:
                      widget.style.headerTextStyle.color ??
                      widget.style.buttonStyle.iconContentStyle.enabledStyle.color,
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

  /// The style used in the previous and next buttons.
  @override
  final FButtonStyle buttonStyle;

  /// The header's text style.
  @override
  final TextStyle headerTextStyle;

  /// The arrow turn animation's duration. Defaults to 200ms.
  @override
  final Duration animationDuration;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FCalendarHeaderStyle].
  FCalendarHeaderStyle({
    required this.focusedOutlineStyle,
    required this.buttonStyle,
    required this.headerTextStyle,
    required this.tappableStyle,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// Creates a [FCalendarHeaderStyle] that inherits its values from the given [colorScheme] and [typography].
  FCalendarHeaderStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
         focusedOutlineStyle: style.focusedOutlineStyle,
         buttonStyle: FButtonStyles.inherit(color: colorScheme, text: typography, style: style).outline.transform(
           (style) => style.copyWith(
             iconContentStyle: style.iconContentStyle.copyWith(
               enabledStyle: IconThemeData(color: colorScheme.mutedForeground, size: 17),
               disabledStyle: IconThemeData(color: colorScheme.disable(colorScheme.mutedForeground), size: 17),
             ),
           ),
         ),
         headerTextStyle: typography.base.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
         tappableStyle: style.tappableStyle.copyWith(animationTween: FTappableAnimations.none),
       );
}
