import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A control that allows the user to toggle between checked and unchecked.
///
/// Typically used to toggle the on/off state of a single setting. A [FSwitch] is internally a [FormField], therefore
/// it can be used in a form.
///
/// See:
/// * https://forui.dev/docs/switch for working examples.
/// * [FSwitchStyle] for customizing a switch's appearance.
class FSwitch extends StatelessWidget {
  /// The style. Defaults to [FThemeData.switchStyle].
  final FSwitchStyle? style;

  /// The semantic label of the switch used by accessibility frameworks.
  final String? semanticLabel;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually change state until the parent widget
  /// rebuilds the switch with the new value.
  final ValueChanged<bool>? onChange;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Defaults to false.
  ///
  /// Ideally, there is only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  ///
  /// If one is not supplied, then one will be automatically allocated, owned, and managed by this widget. The widget
  /// will be focusable even if a [focusNode] is not supplied. If supplied, the given `focusNode` will be hosted by this
  /// widget, but not owned. See [FocusNode] for more information on what being hosted and/or owned implies.
  ///
  /// Supplying a focus node is sometimes useful if an ancestor to this widget wants to control when this widget has the
  /// focus. The owner will be responsible for calling [FocusNode.dispose] on the focus node when it is done with it,
  /// but this widget will attach/detach and reparent the node when needed.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin at the position where the drag gesture won
  /// the arena. If set to [DragStartBehavior.down] it will begin at the position
  /// where a down event was first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  final DragStartBehavior dragStartBehavior;

  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final FormFieldSetter<bool>? onSave;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null
  /// otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property.
  final FormFieldValidator<bool>? validator;

  /// An optional value to initialize the checkbox. Defaults to false.
  final bool initialValue;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled], the checkbox will be auto validated.
  /// Likewise, if this field is false, the widget will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// Used to enable/disable this switch auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  ///
  /// If [AutovalidateMode.onUserInteraction], this switch will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode? autovalidateMode;

  /// Restoration ID to save and restore the state of the switch.
  ///
  /// Setting the restoration ID to a non-null value results in whether or not the switch validation persists.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed from the surrounding [RestorationScope]
  /// using the provided restoration ID.
  ///
  /// See also:
  ///  * [RestorationManager], which explains how state restoration works in Flutter.
  final String? restorationId;

  /// Creates a [FSwitch].
  const FSwitch({
    this.style,
    this.semanticLabel,
    this.onChange,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onSave,
    this.validator,
    this.initialValue = false,
    this.enabled = true,
    this.autovalidateMode,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.switchStyle;
    return FormField<bool>(
      builder: (state) {
        final value = state.value ?? initialValue;
        return Semantics(
          label: semanticLabel,
          enabled: enabled,
          toggled: value,
          child: CupertinoSwitch(
            value: value,
            onChanged: enabled
                ? (value) {
                    state.didChange(value);
                    onChange?.call(!value);
                  }
                : null,
            activeColor: style.checkedColor,
            trackColor: style.uncheckedColor,
            thumbColor: style.thumbColor,
            focusColor: style.focusColor,
            autofocus: autofocus,
            focusNode: focusNode,
            onFocusChange: onFocusChange,
            dragStartBehavior: dragStartBehavior,
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior, defaultValue: DragStartBehavior.start))
      ..add(DiagnosticsProperty('onChange', onChange))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onSave', onSave))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(DiagnosticsProperty('initialValue', initialValue))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('restorationId', restorationId));
  }
}

/// [FSwitch]'s style.
final class FSwitchStyle with Diagnosticable {
  /// The track's color when checked.
  final Color checkedColor;

  /// The track's color when unchecked.
  final Color uncheckedColor;

  /// The thumb's color.
  final Color thumbColor;

  /// This switch's color when focused.
  final Color focusColor;

  /// Creates a [FSwitchStyle].
  const FSwitchStyle({
    required this.checkedColor,
    required this.uncheckedColor,
    required this.thumbColor,
    required this.focusColor,
  });

  /// Creates a [FSwitchStyle] that inherits its properties from [colorScheme].
  FSwitchStyle.inherit({required FColorScheme colorScheme})
      : checkedColor = colorScheme.primary,
        uncheckedColor = colorScheme.border,
        thumbColor = colorScheme.background,
        focusColor = colorScheme.primary;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('checkedColor', checkedColor))
      ..add(ColorProperty('uncheckedColor', uncheckedColor))
      ..add(ColorProperty('thumbColor', thumbColor))
      ..add(ColorProperty('focusColor', focusColor));
  }

  /// Returns a copy of this [FSwitchStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FSwitchStyle(
  ///   checkedColor: Colors.black,
  ///   uncheckedColor: Colors.white,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(uncheckedColor: Colors.blue);
  ///
  /// print(copy.checkedColor); // black
  /// print(copy.uncheckedColor); // blue
  /// ```
  @useResult
  FSwitchStyle copyWith({
    Color? checkedColor,
    Color? uncheckedColor,
    Color? thumbColor,
    Color? focusColor,
  }) =>
      FSwitchStyle(
        checkedColor: checkedColor ?? this.checkedColor,
        uncheckedColor: uncheckedColor ?? this.uncheckedColor,
        thumbColor: thumbColor ?? this.thumbColor,
        focusColor: focusColor ?? this.focusColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSwitchStyle &&
          runtimeType == other.runtimeType &&
          checkedColor == other.checkedColor &&
          uncheckedColor == other.uncheckedColor &&
          thumbColor == other.thumbColor &&
          focusColor == other.focusColor;

  @override
  int get hashCode => checkedColor.hashCode ^ uncheckedColor.hashCode ^ thumbColor.hashCode ^ focusColor.hashCode;
}
