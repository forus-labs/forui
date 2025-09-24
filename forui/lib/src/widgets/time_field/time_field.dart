import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' hide TextDirection;

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_field/input/time_input.dart';
import 'package:forui/src/widgets/time_field/picker/picker_form_field.dart';
import 'package:forui/src/widgets/time_field/picker/properties.dart';

part 'input/input_time_field.dart';

part 'picker/picker_time_field.dart';

/// The time field's controller.
class FTimeFieldController extends FValueNotifier<FTime?> {
  static String? _defaultValidator(FTime? _) => null;

  /// The controller for the popover. Does nothing if the time field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FTimeFieldController] instead.
  final FPopoverController popover;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a time in a picker is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<FTime> validator;

  final FTimePickerController _picker;
  bool _mutating = false;

  /// Creates a [FTimeFieldController].
  FTimeFieldController({
    required TickerProvider vsync,
    this.validator = _defaultValidator,
    FTime? initialTime,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : popover = FPopoverController(vsync: vsync, motion: popoverMotion),
       _picker = FTimePickerController(initial: initialTime ?? const FTime()),
       super(initialTime) {
    _picker.addValueListener((time) {
      try {
        _mutating = true;
        value = time;
      } finally {
        _mutating = false;
      }
    });

    addValueListener(update);
  }

  @override
  void dispose() {
    _picker.dispose();
    popover.dispose();
    super.dispose();
  }
}

@internal
extension FTimeFieldControllers on FTimeFieldController {
  void update(FTime? time) {
    if (!_mutating && time != null) {
      _picker.value = time;
    }
  }
}

/// A time field allows a time to be selected from a picker or input field.
///
/// A [FTimeField] is internally a [FormField], therefore it can be used in a [Form].
///
/// It is recommended to use [FTimeField.picker] on touch devices and [FTimeField.new] on non-touch devices.
///
/// The input field supports both arrow key navigation:
/// * Up/Down arrows: Increment/decrement values
/// * Left/Right arrows: Move between time segments
///
/// The input field does not support the following locales that use non-western numerals & scripts that require
/// composing, it will default to English:
/// {@macro forui.localizations.scriptNumerals}
/// {@macro forui.localization.scriptPeriods}
///
/// The following locales will default to `zh`:
///   * Chinese (Hong Kong) (繁體中文)
///   * Chinese (Taiwan) (繁體中文)
///
/// Consider providing a [FTimeFieldController.validator] to perform custom time validation logic. By default, all
/// times are valid.
///
/// See:
/// * https://forui.dev/docs/form/time-field for working examples.
/// * [FTimeFieldController] for controlling a time field.
/// * [FTimeFieldStyle] for customizing a time field's appearance.
abstract class FTimeField extends StatefulWidget {
  /// The default prefix builder that shows a clock icon.
  static Widget defaultIconBuilder(BuildContext _, FTimeFieldStyle style, Set<WidgetState> states) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 14.0, end: 8.0),
    child: IconTheme(data: style.iconStyle, child: const Icon(FIcons.clock4)),
  );

  static Widget _fieldBuilder(BuildContext _, FTimeFieldStyle _, Set<WidgetState> _, Widget child) => child;

  /// The controller.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * Both [controller] and [initialTime] are provided.
  final FTimeFieldController? controller;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create time-field
  /// ```
  final FTimeFieldStyle Function(FTimeFieldStyle style)? style;

  /// The initial time.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * Both [controller] and [initialTime] are provided.
  final FTime? initialTime;

  /// True if the time field should use the 24-hour format.
  ///
  /// Setting this to false will use the locale's default format, which may be 24-hours. Defaults to false.
  final bool hour24;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// The builder used to decorate the time-field. It should use the given child.
  ///
  /// Defaults to returning the given child.
  final FFieldBuilder<FTimeFieldStyle> builder;

  /// Builds a widget at the start of the input field that can be pressed to toggle the popover. Defaults to
  /// [defaultIconBuilder].
  final FFieldIconBuilder<FTimeFieldStyle>? prefixBuilder;

  /// Builds a widget at the end of the input field that can be pressed to toggle the popover. Defaults to
  /// no suffix.
  final FFieldIconBuilder<FTimeFieldStyle>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// Handler called when the time changes.
  final ValueChanged<FTime?>? onChange;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final FormFieldSetter<FTime>? onSaved;

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
  /// When [FTimeFieldController.validator] is provided, [forceErrorText] will override any error that it returns.
  /// [FTimeFieldController.validator] will not be called unless [forceErrorText] is null.
  final String? forceErrorText;

  const FTimeField._({
    this.controller,
    this.style,
    this.initialTime,
    this.hour24 = false,
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
    super.key,
  }) : assert(
         controller == null || initialTime == null,
         'Cannot provide both a controller and initialTime. To fix, set the initial time directly in the controller.',
       );

  /// Creates a time field that wraps a text input field.
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
  /// The [onSubmit] callback is called when the user submits a valid time value.
  ///
  /// The [mouseCursor] can be used to specify the cursor shown when hovering over the input field.
  ///
  /// If [canRequestFocus] is false, the input field cannot obtain focus but can still be selected.
  ///
  /// See also:
  /// * [FTimeField.picker] - Creates a time field with only a picker.
  const factory FTimeField({
    FTimeFieldController? controller,
    FTimeFieldStyle Function(FTimeFieldStyle style)? style,
    FTime? initialTime,
    bool hour24,
    bool autofocus,
    FocusNode? focusNode,
    FFieldBuilder<FTimeFieldStyle> builder,
    FFieldIconBuilder<FTimeFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FTimeFieldStyle>? suffixBuilder,
    TextInputAction? textInputAction,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    VoidCallback? onEditingComplete,
    ValueChanged<FTime>? onSubmit,
    MouseCursor? mouseCursor,
    bool canRequestFocus,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<FTime?>? onChange,
    FormFieldSetter<FTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? key,
  }) = _InputTimeField;

  /// Creates a [FTimeField] that allows a time to be selected using only a picker.
  ///
  /// The [format] customizes the appearance of the time in the input field. Defaults to the [DateFormat.Hm] if
  /// [hour24] is true or [DateFormat.jm] if false.
  ///
  /// The [hint] is displayed when the input field is empty. Defaults to the current locale's
  /// [FLocalizations.timeFieldHint].
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
  /// The [anchor] and [inputAnchor] control the alignment points for the picker popover positioning.
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
  /// [FPopoverHideRegion.anywhere].
  ///
  /// [hourInterval] and [minuteInterval] control the increment/decrement interval of the hour and minute respectively.
  /// Default to 1.
  ///
  /// See also:
  /// * [FTimeField.new] - Creates a time field with only an input field.
  const factory FTimeField.picker({
    FTimeFieldController? controller,
    FTimeFieldStyle Function(FTimeFieldStyle style)? style,
    FTime? initialTime,
    bool hour24,
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
    Alignment anchor,
    Alignment inputAnchor,
    FPortalSpacing spacing,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    Offset offset,
    FPopoverHideRegion hideRegion,
    VoidCallback? onTapHide,
    int hourInterval,
    int minuteInterval,
    FFieldBuilder<FTimeFieldStyle> builder,
    FFieldIconBuilder<FTimeFieldStyle>? prefixBuilder,
    FFieldIconBuilder<FTimeFieldStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<FTime?>? onChange,
    FormFieldSetter<FTime>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder,
    Key? key,
  }) = _PickerTimeField;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('initialTime', initialTime))
      ..add(FlagProperty('hour24', value: hour24, ifTrue: 'hour24'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('builder', builder))
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

abstract class _FTimeFieldState<T extends FTimeField> extends State<T> with SingleTickerProviderStateMixin {
  late FTimeFieldController _controller =
      widget.controller ?? FTimeFieldController(vsync: this, initialTime: widget.initialTime);
}
