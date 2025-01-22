import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_picker/field/field.dart';
import 'package:intl/intl.dart' hide TextDirection;

part 'calendar/calendar_date_picker.dart';

part 'field/field_date_picker.dart';

/// The date picker's controller.
class FDatePickerController implements FValueNotifier<DateTime?> {
  static String? _defaultValidator(DateTime? _) => null;

  /// The controller for the calendar popover. Does nothing if the date picker is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FDatePickerController] instead.
  final FPopoverController calendar;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a date iin a calendar is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<DateTime> validator;

  /// True if the controller should truncate and convert all given [DateTime]s to dates in UTC timezone. Defaults to
  /// true.
  ///
  /// ```dart
  /// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
  /// ```
  ///
  /// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
  /// the help of a 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
  /// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
  final bool truncateAndStripTimezone;

  /// We use the calendar controller as the source of truth.
  final FCalendarController<DateTime?> _calendar;

  /// Creates a [FDatePickerController].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initialDate] is not in UTC timezone and [truncateAndStripTimezone] is false.
  FDatePickerController({
    required TickerProvider vsync,
    this.validator = _defaultValidator,
    this.truncateAndStripTimezone = true,
    DateTime? initialDate,
    Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  })  : calendar = FPopoverController(vsync: vsync, animationDuration: popoverAnimationDuration),
        _calendar = FCalendarController.date(
          initialSelection: initialDate,
          selectable: (date) => validator(date) == null,
        );

  @override
  void addListener(VoidCallback listener) => _calendar.addListener(listener);

  @override
  void addValueListener(ValueChanged<DateTime?> listener) => _calendar.addValueListener(listener);

  @override
  void notifyListeners() => _calendar.notifyListeners();

  @override
  void removeListener(VoidCallback listener) => _calendar.removeListener(listener);

  @override
  void removeValueListener(ValueChanged<DateTime?> listener) => _calendar.removeValueListener(listener);

  @override
  bool get hasListeners => _calendar.hasListeners;

  @override
  DateTime? get value => _calendar.value;

  @override
  set value(DateTime? value) => _calendar.value = value;

  @override
  bool get disposed => _calendar.disposed;

  @override
  void dispose() {
    _calendar.dispose();
    calendar.dispose();
  }
}

/// A date picker allows a date to be selected from a calendar, input field, or both.
///
/// A [FDatePicker] is internally a [FormField], therefore it can be used in a [Form].
///
/// It is recommended to use [FDatePicker.calendar] on touch devices and [FDatePicker.new]/[FDatePicker.input] on
/// non-primarily touch devices.
///
/// The input field supports both arrow key navigation:
/// * Up/Down arrows: Increment/decrement values
/// * Left/Right arrows: Move between date segments
///
/// The input field does not support the following locales that use non-western numerals:
/// * Arabic (العربية)
/// * Bengali (বাংলা)
/// * Persian/Farsi (فارسی)
/// * Burmese (မြန်မာ)
/// * Nepali (नेपाली)
/// * Pashto (پښتو)
///
/// Consider providing a [FDatePickerController.validator] to perform custom date validation logic. By default, all
/// dates are valid.
///
/// See:
/// * https://forui.dev/docs/form/date-picker for working examples.
/// * [FDatePickerController] for controlling a date picker.
/// * [FDatePickerCalendarProperties] for customizing a date picker calendar's behavior.
/// * [FDatePickerStyle] for customizing a date picker's appearance.
abstract class FDatePicker extends StatefulWidget {
  /// The default prefix builder that shows a calendar icon.
  static Widget defaultIconBuilder(BuildContext context, (FDatePickerStyle, FTextFieldStateStyle) styles, Widget? _) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: FIconStyleData(
          style: styles.$1.iconStyle,
          child: FIcon(FAssets.icons.calendar),
        ),
      );

  /// The controller.
  final FDatePickerController? controller;

  /// The style.
  final FDatePickerStyle? style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// Builds a widget at the start of the input field that can be pressed to toggle the calendar popover. Defaults to
  /// [defaultIconBuilder].
  final ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? prefixBuilder;

  /// Builds a widget at the end of the input field that can be pressed to toggle the calendar popover. Defaults to
  /// no prefix.
  final ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final FormFieldSetter<DateTime>? onSaved;

  /// Used to enable/disable this checkbox auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.onUnfocus].
  ///
  /// If [AutovalidateMode.onUserInteraction], this checkbox will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode autovalidateMode;

  /// An optional property that forces the [FormFieldState] into an error state by directly setting the
  /// [FormFieldState.errorText] property without running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText] will be set to the provided value,
  /// causing the form field to be considered invalid and to display the error message specified.
  ///
  /// When [FDatePickerController.validator] is provided, [forceErrorText] will override any error that it returns.
  /// [FDatePickerController.validator] will not be called unless [forceErrorText] is null.
  final String? forceErrorText;

  const FDatePicker._({
    this.controller,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.prefixBuilder = defaultIconBuilder,
    this.suffixBuilder,
    this.label,
    this.description,
    this.enabled = true,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    super.key,
  });

  /// Creates a [FDatePicker] that allows date selection through both an input field and a calendar popover.
  ///
  /// The input field supports arrow key navigation:
  /// * Up/Down arrows: Increment/decrement values
  /// * Left/Right arrows: Move between date segments
  ///
  /// The [textInputAction] property can be used to specify the action button on the soft keyboard. The [textAlign]
  /// property is used to specify the alignment of the text within the input field.
  ///
  /// The [textAlignVertical] property is used to specify the vertical alignment of the text and can be useful when
  /// used with a prefix or suffix.
  ///
  /// The [textDirection] property can be used to specify the directionality of the text input.
  ///
  /// If [expands] is true, the input field will expand to fill its parent's height.
  ///
  /// The [onEditingComplete] callback is called when the user submits the input field, such as by pressing the done
  /// button on the keyboard.
  ///
  /// The [onSubmit] callback is called when the user submits a valid date value.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// The [baselineInputYear] is used as a reference point for two-digit year input. Years will be interpreted as
  /// being within 80 years before or 20 years after this year.
  ///
  /// The [calendar] property can be used to customize the appearance and behavior of the calendar popover.
  ///
  /// See also:
  /// * [FDatePicker.calendar] - Creates a date picker with only a calendar.
  /// * [FDatePicker.input] - Creates a date picker with only an input field.
  const factory FDatePicker({
    FDatePickerController? controller,
    FDatePickerStyle? style,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool autofocus,
    bool expands,
    VoidCallback? onEditingComplete,
    ValueChanged<DateTime>? onSubmit,
    MouseCursor? mouseCursor,
    bool canRequestFocus,
    int baselineInputYear,
    ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? prefixBuilder,
    ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? suffixBuilder,
    FDatePickerCalendarProperties calendar,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<DateTime>? onSaved,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    Widget Function(BuildContext, String) errorBuilder,
    Key? key,
  }) = _FieldDatePicker;

  /// Creates a [FDatePicker] that allows a date to be selected using only a calendar.
  ///
  /// The [format] customizes the appearance of the date in the input field. Defaults to the `d MMM y` in the current
  /// locale.
  ///
  /// The [hint] is displayed when the input field is empty. Defaults to the current locale's
  /// [FLocalizations.datePickerHint].
  ///
  /// The [textAlign] property is used to specify the alignment of the text within the input field.
  ///
  /// The [textAlignVertical] property is used to specify the vertical alignment of the text and can be useful when
  /// used with a prefix or suffix.
  ///
  /// The [textDirection] property can be used to specify the directionality of the text input.
  ///
  /// If [expands] is true, the input field will expand to fill its parent's height.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// The [dayBuilder] customizes the appearance of calendar day cells. Defaults to [FCalendar.defaultDayBuilder].
  ///
  /// The [start] and [end] parameters define the date range of selectable dates.
  ///
  /// The [today] parameter specifies which date should be considered as "today". If not provided,
  /// uses the current date.
  ///
  /// The [initialType] determines the initial calendar view (day, month, year).
  ///
  /// When [autoHide] is true, the calendar will automatically hide after a date is selected.
  ///
  /// The [anchor] and [inputAnchor] control the alignment points for the calendar popover positioning.
  /// Defaults to [Alignment.topLeft] and [Alignment.bottomLeft] respectively.
  ///
  /// The [shift] function controls how the calendar repositions when space is constrained. Defaults to
  /// [FPortalShift.flip].
  ///
  /// [hideOnTapOutside] controls the region that can be tapped to hide the popover. Defaults to
  /// [FHidePopoverRegion.anywhere].
  ///
  /// [directionPadding] controls whether the popover should include the cross-axis padding of the anchor when aligning
  /// to it. Defaults to false.
  ///
  /// See also:
  /// * [FDatePicker] - Creates a date picker with both input field and calendar.
  /// * [FDatePicker.input] - Creates a date picker with only an input field.
  const factory FDatePicker.calendar({
    FDatePickerController? controller,
    FDatePickerStyle? style,
    DateFormat? format,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    MouseCursor mouseCursor,
    bool canRequestFocus,
    String? hint,
    bool autofocus,
    FocusNode? focusNode,
    ValueWidgetBuilder<FCalendarDayData> dayBuilder,
    DateTime? start,
    DateTime? end,
    DateTime? today,
    FCalendarPickerType initialType,
    bool autoHide,
    Alignment anchor,
    Alignment inputAnchor,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    FHidePopoverRegion hideOnTapOutside,
    bool directionPadding,
    ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? prefixBuilder,
    ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<DateTime>? onSaved,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    Widget Function(BuildContext, String) errorBuilder,
    Key? key,
  }) = _CalendarDatePicker;

  /// Creates a date picker that wraps a text input field.
  ///
  /// The [textInputAction] property can be used to specify the action button on the soft keyboard. The [textAlign]
  /// property is used to specify the alignment of the text within the input field.
  ///
  /// The [textAlignVertical] property is used to specify the vertical alignment of the text and can be useful when
  /// used with a prefix or suffix.
  ///
  /// The [textDirection] property can be used to specify the directionality of the text input.
  ///
  /// If [expands] is true, the input field will expand to fill its parent's height.
  ///
  /// The [onEditingComplete] callback is called when the user submits the input field, such as by pressing the done
  /// button on the keyboard.
  ///
  /// The [onSubmit] callback is called when the user submits a valid date value.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// The [baselineInputYear] is used as a reference point for two-digit year input. Years will be interpreted as
  /// being within 80 years before or 20 years after this year.
  ///
  /// See also:
  /// * [FDatePicker] - Creates a date picker with both input field and calendar.
  /// * [FDatePicker.calendar] - Creates a date picker with only a calendar.
  factory FDatePicker.input({
    FDatePickerController? controller,
    FDatePickerStyle? style,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? prefixBuilder = defaultIconBuilder,
    ValueWidgetBuilder<(FDatePickerStyle, FTextFieldStateStyle)>? suffixBuilder,
    TextInputAction? textInputAction,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands = false,
    VoidCallback? onEditingComplete,
    ValueChanged<DateTime>? onSubmit,
    MouseCursor? mouseCursor,
    bool canRequestFocus = true,
    int baselineInputYear = 2000,
    Widget? label,
    Widget? description,
    bool enabled = true,
    FormFieldSetter<DateTime>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    Widget Function(BuildContext, String) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Key? key,
  }) =>
      _FieldDatePicker(
        controller: controller,
        style: style,
        autofocus: autofocus,
        focusNode: focusNode,
        prefixBuilder: prefixBuilder,
        suffixBuilder: suffixBuilder,
        textInputAction: textInputAction,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textDirection: textDirection,
        expands: expands,
        onEditingComplete: onEditingComplete,
        onSubmit: onSubmit,
        mouseCursor: mouseCursor,
        canRequestFocus: canRequestFocus,
        baselineInputYear: baselineInputYear,
        calendar: null,
        label: label,
        description: description,
        enabled: enabled,
        onSaved: onSaved,
        autovalidateMode: autovalidateMode,
        forceErrorText: forceErrorText,
        errorBuilder: errorBuilder,
        key: key,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText));
  }
}

abstract class _DatePickerState<T extends FDatePicker> extends State<T> with SingleTickerProviderStateMixin {
  late FDatePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FDatePickerController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant T old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? FDatePickerController(vsync: this);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
