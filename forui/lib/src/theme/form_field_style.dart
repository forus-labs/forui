import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A form field state's style.
class FFormFieldStyle with Diagnosticable {
  /// The label's text style.
  final TextStyle labelTextStyle;

  /// The description's text style.
  final TextStyle descriptionTextStyle;

  /// Creates a [FFormFieldStyle].
  const FFormFieldStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
  });

  /// Creates a [FFormFieldStyle] that inherits its properties from the given [FTypography].
  FFormFieldStyle.inherit({
    required Color labelColor,
    required Color descriptionColor,
    required FTypography typography,
  })  : labelTextStyle = typography.sm.copyWith(
          color: labelColor,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle = typography.sm.copyWith(color: descriptionColor);

  /// Returns a copy of this [FFormFieldStyle] with the given properties replaced.
  @useResult
  FFormFieldStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
  }) =>
      FFormFieldStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FFormFieldStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode;
}

/// A form field's error style.
class FFormFieldErrorStyle extends FFormFieldStyle {
  /// The error's text style.
  final TextStyle errorTextStyle;

  /// Creates a [FFormFieldErrorStyle].
  FFormFieldErrorStyle({
    required this.errorTextStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
  });

  /// Creates a [FFormFieldErrorStyle] that inherits its properties from the given arguments.
  FFormFieldErrorStyle.inherit({
    required Color errorColor,
    required super.labelColor,
    required super.descriptionColor,
    required super.typography,
  })  : errorTextStyle = typography.sm.copyWith(
          color: errorColor,
          fontWeight: FontWeight.w600,
        ),
        super.inherit();

  /// Returns a copy of this [FFormFieldErrorStyle] with the given properties replaced.
  @override
  @useResult
  FFormFieldErrorStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) =>
      FFormFieldErrorStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FFormFieldErrorStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}
