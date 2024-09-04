import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// An item that represents a selection in a [FSelectGroup].
class FSelectGroupItem<T> with Diagnosticable {
  /// The value of the item.
  T value;

  /// The builder that creates the item's widget.
  // ignore: avoid_positional_boolean_parameters
  Widget Function(BuildContext context, void Function(T value, bool selected) onChange, bool selected) builder;

  /// Creates a [FSelectGroupItem].
  FSelectGroupItem({
    required this.value,
    required this.builder,
  });

  /// Creates a [FSelectGroupItem] with a [FCheckbox] as the builder.
  factory FSelectGroupItem.checkbox({
    required T value,
    FCheckboxSelectGroupStyle? style,
    Widget? label,
    Widget? description,
    String? semanticLabel,
    Widget? error,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) =>
      FSelectGroupItem<T>(
        value: value,
        builder: (context, onChange, selected) {
          final computedStyle = style ?? context.theme.selectGroupStyle.checkboxStyle;

          return Padding(
            padding: computedStyle.padding,
            child: FCheckbox(
              style: computedStyle,
              label: label,
              description: description,
              semanticLabel: semanticLabel,
              error: error,
              value: selected,
              onChange: (state) => onChange(value, state),
              enabled: enabled,
              autofocus: autofocus,
              focusNode: focusNode,
              onFocusChange: onFocusChange,
              key: key,
            ),
          );
        },
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(ObjectFlagProperty.has('builder', builder));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupItem && runtimeType == other.runtimeType && value == other.value && builder == other.builder;

  @override
  int get hashCode => value.hashCode ^ builder.hashCode;
}

/// A [FSelectGroupItem.checkbox]'s style.
class FCheckboxSelectGroupStyle extends FCheckboxStyle {
  /// The padding around the checkbox.
  final EdgeInsets padding;

  /// Creates a [FCheckboxSelectGroupStyle].
  FCheckboxSelectGroupStyle({
    required this.padding,
    required super.labelLayoutStyle,
    required super.enabledStyle,
    required super.disabledStyle,
    required super.errorStyle,
  });

  /// Creates a [FCheckboxSelectGroupStyle] that inherits its properties from the given parameters.
  FCheckboxSelectGroupStyle.inherit({required FCheckboxStyle style})
      : padding = const EdgeInsets.symmetric(vertical: 2),
        super(
          labelLayoutStyle: style.labelLayoutStyle,
          enabledStyle: style.enabledStyle,
          disabledStyle: style.disabledStyle,
          errorStyle: style.errorStyle,
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FCheckboxSelectGroupStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding;

  @override
  int get hashCode => super.hashCode ^ padding.hashCode;
}
