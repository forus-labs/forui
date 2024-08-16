import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// A stateless single form field.
///
/// This widget is meant to be extended by other form field widgets.
abstract class FStatelessFormField<T> extends StatelessWidget {
  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final FormFieldSetter<T>? onSave;

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
  /// The returned value is exposed by the [FormFieldState.errorText] property.
  final FormFieldValidator<T>? validator;

  /// An optional value to initialize the form field to, or null otherwise.
  final T initialValue;

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

  /// Restoration ID to save and restore the state of the form field.
  ///
  /// Setting the restoration ID to a non-null value results in whether or not the form field validation persists.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed from the surrounding [RestorationScope]
  /// using the provided restoration ID.
  ///
  /// See also:
  ///  * [RestorationManager], which explains how state restoration works in Flutter.
  final String? restorationId;

  /// Creates a [FStatelessFormField].
  const FStatelessFormField({
    required this.initialValue,
    this.onSave,
    this.forceErrorText,
    this.validator,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FormField<T>(
        onSaved: onSave,
        validator: forceErrorText == null ? validator : (_) => forceErrorText,
        initialValue: initialValue,
        enabled: enabled,
        autovalidateMode: autovalidateMode,
        restorationId: restorationId,
        builder: (state) => builder(context, state),
      );

  /// The builder for the [FormField].
  Widget builder(BuildContext context, FormFieldState<T> state);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('onSave', onSave))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(DiagnosticsProperty('initialValue', initialValue))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('restorationId', restorationId));
  }
}
