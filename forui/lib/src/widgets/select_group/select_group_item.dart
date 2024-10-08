import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class FSelectGroupItemData<T> extends InheritedWidget {
  static FSelectGroupItemData<T> of<T>(BuildContext context) {
    final FSelectGroupItemData<T>? result = context.dependOnInheritedWidgetOfExactType<FSelectGroupItemData<T>>();
    assert(
      result != null,
      "No FSelectGroupItemData found in context. This likely because FSelectGroup's type parameter could not be inferred. "
      'It is currently inferred as $T. To fix this, provide the type parameter explicitly, i.e. FSelectGroup<MyType>.',
    );
    return result!;
  }

  final FSelectGroupController<T> controller;
  final FSelectGroupStyle style;
  final bool selected;

  const FSelectGroupItemData({
    required this.controller,
    required this.style,
    required this.selected,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FSelectGroupItemData old) =>
      controller != old.controller || style != old.style || selected != old.selected;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'));
  }
}

/// A [FSelectGroupItem]'s state.
typedef FSelectGroupItemState<T> = ({
  FSelectGroupController<T> controller,
  FSelectGroupStyle style,
  T value,
  bool selected
});

/// Represents a selection in a [FSelectGroup].
abstract class FSelectGroupItem<T> extends StatelessWidget {
  /// The item's value.
  final T value;

  /// Creates a [FSelectGroupItem].
  const factory FSelectGroupItem({
    required T value,
    required ValueWidgetBuilder<FSelectGroupItemState<T>> builder,
    Widget? child,
    Key? key,
  }) = _Builder;

  /// Creates a checkbox wrapped in a [FSelectGroupItem].
  // TODO: Making this const causes a false positive in the list_element_type_not_assignable lint when declared
  //       in a const list inside FSelectGroup. I still can't replicate this issue in other cases.
  // ignore: prefer_const_constructors_in_immutables
  factory FSelectGroupItem.checkbox({
    required T value,
    FCheckboxSelectGroupStyle? style,
    Widget? label,
    Widget? description,
    Widget? error,
    String? semanticLabel,
    bool enabled,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) = _Checkbox;

  /// Creates a radio button wrapped in a [FSelectGroupItem].
  // TODO: Making this const causes a false positive in the list_element_type_not_assignable lint when declared
  //       in a const list inside FSelectGroup. I still can't replicate this issue in other cases.
  // ignore: prefer_const_constructors_in_immutables
  factory FSelectGroupItem.radio({
    required T value,
    FRadioSelectGroupStyle? style,
    Widget? label,
    Widget? description,
    Widget? error,
    String? semanticLabel,
    bool enabled,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) = _Radio;

  const FSelectGroupItem._({required this.value, super.key});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('value', value));
  }
}

class _Builder<T> extends FSelectGroupItem<T> {
  final ValueWidgetBuilder<FSelectGroupItemState<T>> builder;
  final Widget? child;

  const _Builder({
    required this.builder,
    required super.value,
    this.child,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final FSelectGroupItemData(:controller, :style, :selected) = FSelectGroupItemData.of<T>(context);
    return builder(context, (controller: controller, style: style, value: value, selected: selected), child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('builder', builder));
  }
}

class _Checkbox<T> extends FSelectGroupItem<T> {
  final FCheckboxSelectGroupStyle? style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final String? semanticLabel;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const _Checkbox({
    required super.value,
    this.style,
    this.label,
    this.description,
    this.error,
    this.semanticLabel,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final FSelectGroupItemData(:controller, :style) = FSelectGroupItemData.of<T>(context);
    final checkboxStyle = this.style ?? style.checkboxStyle;

    return Padding(
      padding: checkboxStyle.padding,
      child: FCheckbox(
        style: checkboxStyle,
        label: label,
        description: description,
        semanticLabel: semanticLabel,
        error: error,
        value: controller.contains(value),
        onChange: (state) => controller.select(value, state),
        enabled: enabled,
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        key: key,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifFalse: 'not autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _Radio<T> extends FSelectGroupItem<T> {
  final FRadioSelectGroupStyle? style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final String? semanticLabel;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const _Radio({
    required super.value,
    this.style,
    this.label,
    this.description,
    this.error,
    this.semanticLabel,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final FSelectGroupItemData(:controller, :style) = FSelectGroupItemData.of<T>(context);
    final radioStyle = this.style ?? style.radioStyle;

    return Padding(
      padding: radioStyle.padding,
      child: FRadio(
        style: radioStyle,
        label: label,
        description: description,
        semanticLabel: semanticLabel,
        error: error,
        value: controller.contains(value),
        onChange: (state) => controller.select(value, state),
        enabled: enabled,
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        key: key,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifFalse: 'not autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

/// A [FSelectGroupItem.checkbox]'s style.
class FCheckboxSelectGroupStyle extends FCheckboxStyle {
  /// The padding around the checkbox. Defaults to `EdgeInsets.symmetric(vertical: 2)`.
  final EdgeInsets padding;

  /// Creates a [FCheckboxSelectGroupStyle].
  FCheckboxSelectGroupStyle({
    required super.labelLayoutStyle,
    required super.enabledStyle,
    required super.disabledStyle,
    required super.errorStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 2),
  });

  /// Creates a [FCheckboxSelectGroupStyle] that inherits its properties from the given parameters.
  FCheckboxSelectGroupStyle.inherit({required FCheckboxStyle style})
      : this(
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

/// A [FSelectGroupItem.radio]'s style.
class FRadioSelectGroupStyle extends FRadioStyle {
  /// The padding around the radio. Defaults to `EdgeInsets.symmetric(vertical: 2)`.
  final EdgeInsets padding;

  /// Creates a [FRadioSelectGroupStyle].
  FRadioSelectGroupStyle({
    required super.animationDuration,
    required super.curve,
    required super.labelLayoutStyle,
    required super.enabledStyle,
    required super.disabledStyle,
    required super.errorStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 2),
  });

  /// Creates a [FRadioSelectGroupStyle] that inherits its properties from the given parameters.
  FRadioSelectGroupStyle.inherit({required FRadioStyle style})
      : this(
          animationDuration: style.animationDuration,
          curve: style.curve,
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
      super == other && other is FRadioSelectGroupStyle && runtimeType == other.runtimeType && padding == other.padding;

  @override
  int get hashCode => super.hashCode ^ padding.hashCode;
}
