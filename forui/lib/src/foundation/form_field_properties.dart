import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A form field's properties.
abstract class FFormFieldProperties<T> {
  /// The default builder for errors displayed below the [description].
  static Widget defaultErrorBuilder(BuildContext context, String error) => Text(error);

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  final Widget Function(BuildContext, String) errorBuilder;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled], the checkbox will be auto validated.
  /// Likewise, if this field is false, the widget will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final FormFieldSetter<T>? onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property. It transforms the text using
  /// [errorBuilder].
  ///
  /// Alternating between error and normal state can cause the height of the [FTextField] to change if no other
  /// subtext decoration is set on the field. To create a field whose height is fixed regardless of whether or not an
  /// error is displayed, wrap the [FTextField] in a fixed height parent like [SizedBox].
  final FormFieldValidator<T>? validator;

  /// Used to enable/disable this checkbox auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.disabled].
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
  /// When [validator] is provided, [forceErrorText] will override any error that it returns. [validator] will not be
  /// called unless [forceErrorText] is null.
  final String? forceErrorText;

  /// Creates a form field's properties.
  const FFormFieldProperties({
    this.label,
    this.description,
    this.errorBuilder = defaultErrorBuilder,
    this.enabled = true,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
  });
}
