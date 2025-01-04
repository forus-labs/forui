import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


/// Properties for a form field.
interface class FFormFieldProperties<T> with Diagnosticable {
  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final FormFieldSetter<T>? onSaved;

  /// An optional property that forces the [FormFieldState] into an error state by directly setting the
  /// [FormFieldState.errorText] property without running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText] will be set to the provided value,
  /// causing the form field to be considered invalid and to display the error message specified.
  ///
  /// When [validator] is provided, [forceErrorText] will override any error that it returns. [validator] will not be
  /// called unless [forceErrorText] is null.
  final String? forceErrorText;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null
  /// otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property. It transforms the text using
  /// [errorBuilder].
  ///
  /// Alternating between error and normal state can cause the height of the form field to change if no other
  /// subtext decoration is set on the field. To create a field whose height is fixed regardless of whether or not an
  /// error is displayed, wrap the field in a fixed height parent like [SizedBox].
  final FormFieldValidator<T>? validator;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled], the checkbox will be auto validated.
  /// Likewise, if this field is false, the widget will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// Used to enable/disable this checkbox auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  ///
  /// If [AutovalidateMode.onUserInteraction], this checkbox will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode autovalidateMode;

  /// Creates a [FFormFieldProperties].
  const FFormFieldProperties({
    this.onSaved,
    this.forceErrorText,
    this.validator,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('onSave', onSaved))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode));
  }
}
