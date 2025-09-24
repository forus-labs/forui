import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A form field's properties.
mixin FFormFieldProperties<T> {
  /// The default builder for errors displayed below the [description].
  static Widget defaultErrorBuilder(BuildContext _, String error) => Text(error);

  /// The label.
  Widget? get label;

  /// The description.
  Widget? get description;

  /// {@template forui.foundation.form_field_properties.errorBuilder}
  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  /// {@endtemplate}
  Widget Function(BuildContext context, String message)? get errorBuilder;

  /// {@template forui.foundation.form_field_properties.enabled}
  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled], the form field will be auto validated.
  /// Likewise, if this field is false, the widget will not be validated regardless of [autovalidateMode].
  /// {@endtemplate}
  bool get enabled;

  /// {@template forui.foundation.form_field_properties.onSaved}
  /// An optional method to call with the final value when the form is saved via [FormState.save].
  /// {@endtemplate}
  FormFieldSetter<T>? get onSaved;

  /// {@template forui.foundation.form_field_properties.onReset}
  /// An optional method to call when the form field is reset via [FormFieldState.reset].
  /// {@endtemplate}
  VoidCallback? get onReset;

  /// {@template forui.foundation.form_field_properties.validator}
  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property. It is transformed using
  /// [errorBuilder].
  ///
  /// Alternating between error and normal states can cause the height of the [FTextField] to change if no other
  /// subtext decoration is set on the field. To create a field whose height is fixed regardless of whether or not an
  /// error is displayed, wrap the [FTextField] in a fixed height parent like [SizedBox].
  /// {@endtemplate}
  FormFieldValidator<T>? get validator;

  /// {@template forui.foundation.form_field_properties.autovalidateMode}
  /// Used to enable/disable this form field's auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  ///
  /// If [AutovalidateMode.onUserInteraction], this form field will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  /// {@endtemplate}
  AutovalidateMode get autovalidateMode;

  /// {@template forui.foundation.form_field_properties.forceErrorText}
  /// An optional property that forces the [FormFieldState] into an error state by directly setting the
  /// [FormFieldState.errorText] property without running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText] will be set to the provided value,
  /// causing the form field to be considered invalid and to display the error message specified.
  ///
  /// When [validator] is provided, [forceErrorText] will override any error that it returns. [validator] will not be
  /// called unless [forceErrorText] is null.
  /// {@endtemplate}
  String? get forceErrorText;
}
