import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' hide TextDirection;
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form_field.dart';
import 'package:forui/src/widgets/date_field/input/date_input.dart';

part 'calendar/calendar_date_field.dart';

part 'input/input_date_field.dart';

/// The date field's controller.
class FDateFieldController implements FValueNotifier<DateTime?> {
  static String? _defaultValidator(DateTime? _) => null;

  /// The controller for the calendar popover. Does nothing if the date field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FDateFieldController] instead.
  final FPopoverController calendar;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a date in a calendar is selectable.
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

  /// Creates a [FDateFieldController].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initialDate] is not in UTC timezone and [truncateAndStripTimezone] is false.
  FDateFieldController({
    required TickerProvider vsync,
    this.validator = _defaultValidator,
    this.truncateAndStripTimezone = true,
    DateTime? initialDate,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : calendar = FPopoverController(vsync: vsync, motion: popoverMotion),
       _calendar = FCalendarController.date(
         initialSelection: initialDate,
         selectable: (date) => validator(date) == null,
       );

  @override
  void addListener(VoidCallback listener) => _calendar.addListener(listener);

  @override
  void addValueListener(ValueChanged<DateTime?>? listener) => _calendar.addValueListener(listener);

  @override
  void notifyListeners() => _calendar.notifyListeners();

  @override
  void removeListener(VoidCallback listener) => _calendar.removeListener(listener);

  @override
  void removeValueListener(ValueChanged<DateTime?>? listener) => _calendar.removeValueListener(listener);

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

/// A date field allows a date to be selected from a calendar, input field, or both.
///
/// A [FDateField] is internally a [FormField], therefore it can be used in a [Form].
///
/// It is recommended to use [FDateField.calendar] on touch devices and [FDateField.new]/[FDateField.input] on
/// non-touch devices.
///
/// The input field supports both arrow key navigation:
/// * Up/Down arrows: Increment/decrement values
/// * Left/Right arrows: Move between date segments
///
/// The input field does not support the following locales that use non-western numerals, it will default to English:
/// {@macro forui.localizations.scriptNumerals}
///
/// Consider providing a [FDateFieldController.validator] to perform custom date validation logic. By default, all
/// dates are valid.
///
/// See:
/// * https://forui.dev/docs/form/date-field for working examples.
/// * [FDateFieldController] for controlling a date field.
/// * [FDateFieldCalendarProperties] for customizing a date field calendar's behavior.
/// * [FDateFieldStyle] for customizing a date field's appearance.
abstract class FDateField extends StatefulWidget {
  /// The default prefix builder that shows a calendar icon.
  static Widget defaultIconBuilder(BuildContext _, FDateFieldStyle style, Set<WidgetState> _) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 14.0, end: 8.0),
    child: IconTheme(data: style.iconStyle, child: const Icon(FIcons.calendar)),
  );

  static Widget _fieldBuilder(BuildContext _, FDateFieldStyle _, Set<WidgetState> _, Widget child) => child;

  /// The controller.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * Both [controller] and [initialDate] are provided.
  final FDateFieldController? controller;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create date-field
  /// ```
  final FDateFieldStyle Function(FDateFieldStyle style)? style;

  /// The initial date.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * Both [controller] and [initialDate] are provided.
  final DateTime? initialDate;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// The builder used to decorate the date-field. It should use the given child.
  ///
  /// Defaults to returning the given child.
  final FFieldBuilder<FDateFieldStyle> builder;

  /// Builds a widget at the start of the input field that can be pressed to toggle the calendar popover. Defaults to
  /// [defaultIconBuilder].
  final FFieldIconBuilder<FDateFieldStyle>? prefixBuilder;

  /// Builds a widget at the end of the input field that can be pressed to toggle the calendar popover. Defaults to
  /// no prefix.
  final FFieldIconBuilder<FDateFieldStyle>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// Handler called when the date changes.
  ///
  /// The given [DateTime] is always in UTC timezone.
  final ValueChanged<DateTime?>? onChange;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final FormFieldSetter<DateTime>? onSaved;

  /// {@macro forui.foundation.form_field_properties.onReset}
  final VoidCallback? onReset;

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
  /// When [FDateFieldController.validator] is provided, [forceErrorText] will override any error that it returns.
  /// [FDateFieldController.validator] will not be called unless [forceErrorText] is null.
  final String? forceErrorText;

  FDateField._({
    this.controller,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.builder = _fieldBuilder,
    this.prefixBuilder = defaultIconBuilder,
    this.suffixBuilder,
    this.label,
    this.description,
    this.enabled = true,
    this.onChange,
    this.onSaved,
    this.onReset,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    DateTime? initialDate,
    super.key,
  }) : assert(
         controller == null || initialDate == null,
         'Cannot provide both a controller and an initialDate. To fix, set the date directly in the controller.',
       ),
       initialDate = initialDate?.toLocalDate().toNative();

  /// Creates a [FDateField] that allows date selection through both an input field and a calendar popover.
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
  /// If [clearable] is true, the input field will show a clear button when a date is selected. Defaults to false.
  ///
  /// The [baselineInputYear] is used as a reference point for two-digit year input. Years will be interpreted as
  /// being within 80 years before or 20 years after this year.
  ///
  /// The [calendar] property can be used to customize the appearance and behavior of the calendar popover.
  ///
  /// See also:
  /// * [FDateField.calendar] - Creates a date field with only a calendar.
  /// * [FDateField.input] - Creates a date field with only an input field.
  factory FDateField({
    FDateFieldController? controller,
    FDateFieldStyle Function(FDateFieldStyle style)? style,
    DateTime? initialDate,
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
    bool clearable,
    int baselineInputYear,
    FFieldBuilder<FDateFieldStyle> builder,
    FFieldIconBuilder<FDateFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FDateFieldStyle>? suffixBuilder,
    FDateFieldCalendarProperties calendar,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<DateTime?>? onChange,
    FormFieldSetter<DateTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? key,
  }) = _InputDateField;

  /// Creates a [FDateField] that allows a date to be selected using only a calendar.
  ///
  /// The [format] customizes the appearance of the date in the input field. Defaults to the `d MMM y` in the current
  /// locale.
  ///
  /// The [hint] is displayed when the input field is empty. Defaults to the current locale's
  /// [FLocalizations.dateFieldHint].
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
  /// If [clearable] is true, the input field will show a clear button when a date is selected. Defaults to false.
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
  /// The [spacing] property controls the spacing between the input field and the picker popover. Defaults to
  /// `FPortalSpacing(4)`.
  ///
  /// The [shift] function controls how the picker repositions when space is constrained. Defaults to
  /// [FPortalShift.flip].
  ///
  /// The [offset] property controls the offset of the picker popover. Defaults to [Offset.zero].
  ///
  /// [hideRegion] controls the region that can be tapped to hide the popover. Defaults to
  /// [FPopoverHideRegion.excludeChild].
  ///
  /// See also:
  /// * [FDateField] - Creates a date field with both input field and calendar.
  /// * [FDateField.input] - Creates a date field with only an input field.
  factory FDateField.calendar({
    FDateFieldController? controller,
    FDateFieldStyle Function(FDateFieldStyle style)? style,
    DateTime? initialDate,
    DateFormat? format,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    MouseCursor mouseCursor,
    bool canRequestFocus,
    bool clearable,
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
    FPortalSpacing spacing,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    Offset offset,
    FPopoverHideRegion hideRegion,
    VoidCallback? onTapHide,
    FFieldBuilder<FDateFieldStyle> builder,
    FFieldIconBuilder<FDateFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FDateFieldStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<DateTime?>? onChange,
    FormFieldSetter<DateTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? key,
  }) = _CalendarDateField;

  /// Creates a date field that wraps a text input field.
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
  /// If [clearable] is true, the input field will show a clear button when a date is selected. Defaults to false.
  ///
  /// The [baselineInputYear] is used as a reference point for two-digit year input. Years will be interpreted as
  /// being within 80 years before or 20 years after this year.
  ///
  /// See also:
  /// * [FDateField] - Creates a date field with both input field and calendar.
  /// * [FDateField.calendar] - Creates a date field with only a calendar.
  factory FDateField.input({
    FDateFieldController? controller,
    FDateFieldStyle Function(FDateFieldStyle style)? style,
    DateTime? initialDate,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldBuilder<FDateFieldStyle> builder = _fieldBuilder,
    FFieldIconBuilder<FDateFieldStyle>? prefixBuilder = defaultIconBuilder,
    FFieldIconBuilder<FDateFieldStyle>? suffixBuilder,
    TextInputAction? textInputAction,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands = false,
    VoidCallback? onEditingComplete,
    ValueChanged<DateTime>? onSubmit,
    MouseCursor? mouseCursor,
    bool canRequestFocus = true,
    bool clearable = false,
    int baselineInputYear = 2000,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<DateTime?>? onChange,
    FormFieldSetter<DateTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Key? key,
  }) => _InputDateField(
    controller: controller,
    style: style,
    initialDate: initialDate,
    autofocus: autofocus,
    focusNode: focusNode,
    builder: builder,
    prefixBuilder: prefixBuilder,
    suffixBuilder: suffixBuilder,
    clearable: clearable,
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
    onChange: onChange,
    onSaved: onSaved,
    onReset: onReset,
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
      ..add(DiagnosticsProperty('initialDate', initialDate))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText));
  }
}

abstract class _FDateFieldState<T extends FDateField> extends State<T> with SingleTickerProviderStateMixin {
  late FDateFieldController _controller =
      widget.controller ?? FDateFieldController(vsync: this, initialDate: widget.initialDate);
}
