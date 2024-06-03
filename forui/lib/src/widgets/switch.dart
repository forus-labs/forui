import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:forui/forui.dart';

/// A control that allows the user to toggle between checked and unchecked.
class FSwitch extends StatelessWidget {

  /// The style. Defaults to the appropriate style in [FThemeData.switchStyle] if null.
  final FSwitchStyle? style;

  /// True if this switch is checked, and false if unchecked.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled, which has a reduced opacity.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// FSwitch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Ideally, there is only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  ///
  /// Defaults to false.
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

  /// Creates a [FSwitch].
  const FSwitch({
    required this.value,
    required this.onChanged,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.dragStartBehavior = DragStartBehavior.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.switchStyle;
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: style.checked,
      trackColor: style.unchecked,
      thumbColor: style.thumb,
      focusColor: style.focus,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      dragStartBehavior: dragStartBehavior,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('value', value: value))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior, defaultValue: DragStartBehavior.start))
      ..add(DiagnosticsProperty('onChanged', onChanged, defaultValue: null))
      ..add(DiagnosticsProperty('focusNode', focusNode, defaultValue: null))
      ..add(DiagnosticsProperty('onFocusChange', onFocusChange, defaultValue: null));
  }

}

/// The style of a [FSwitch].
final class FSwitchStyle with Diagnosticable {

  /// The track's color when checked. Defaults to [FColorScheme.primary].
  final Color checked;

  /// The track's color when unchecked. Defaults to [FColorScheme.border].
  final Color unchecked;

  /// The thumb's color. Defaults to [FColorScheme.background].
  final Color thumb;

  /// This switch's color when focused. Defaults to a slightly transparent [checked] color.
  final Color focus;

  /// Creates a [FSwitchStyle].
  const FSwitchStyle({
    required this.checked,
    required this.unchecked,
    required this.thumb,
    required this.focus,
  });

  /// Creates a [FSwitchStyle] that inherits its properties from [colorScheme].
  FSwitchStyle.inherit({required FColorScheme colorScheme})
      : checked = colorScheme.primary,
        unchecked = colorScheme.border,
        thumb = colorScheme.background,
        focus = HSLColor.fromColor(colorScheme.primary.withOpacity(0.80))
            .withLightness(0.69)
            .withSaturation(0.835)
            .toColor();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('checked', checked))
      ..add(ColorProperty('unchecked', unchecked))
      ..add(ColorProperty('thumb', thumb))
      ..add(ColorProperty('focus', focus));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSwitchStyle &&
          runtimeType == other.runtimeType &&
          checked == other.checked &&
          unchecked == other.unchecked &&
          thumb == other.thumb &&
          focus == other.focus;

  @override
  int get hashCode => checked.hashCode ^ unchecked.hashCode ^ thumb.hashCode ^ focus.hashCode;

}
