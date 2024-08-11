import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/collection.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

part 'button_content.dart';

part 'button_icon.dart';

part 'button_styles.dart';

/// A button.
///
/// [FButton]s typically contain icons and/or a label. If the [onPress] and [onLongPress] callbacks are null, then this
/// button will be disabled, it will not react to touch.
///
/// The constants in [FButtonStyle] provide a convenient way to style a badge.
///
/// See:
/// * https://forui.dev/docs/button for working examples.
/// * [FButtonCustomStyle] for customizing a button's appearance.
class FButton extends StatelessWidget {
  @useResult
  static _Data _of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedData>();
    return theme?.data ?? (style: context.theme.buttonStyles.primary, enabled: true);
  }

  /// The style. Defaults to [FButtonStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FButtonStyle], it can also be a [FButtonCustomStyle].
  final FButtonStyle style;

  /// A callback for when the button is pressed.
  ///
  /// The button will be disabled if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the button is long pressed.
  ///
  /// The button will be disabled if both [onPress] and [onLongPress] are null.
  final VoidCallback? onLongPress;

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

  /// The child.
  final Widget child;

  /// Creates a [FButton] that contains a [prefix], [label], and [suffix].
  ///
  /// The button layout is as follows, assuming the locale is read from left to right:
  /// ```
  /// |---------------------------------------------|
  /// | [prefixIcon]   [label]   [suffixIcon]       |
  /// |---------------------------------------------|
  /// ```
  ///
  /// [FButtonIcon] provides a convenient way to transform a bundled SVG icon into a [prefix] and [suffix].
  FButton({
    required this.onPress,
    required Widget label,
    this.style = Variant.primary,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Widget? prefix,
    Widget? suffix,
    super.key,
  }) : child = _FButtonContent(
          prefix: prefix,
          suffix: suffix,
          label: label,
        );

  /// Creates a [FButton] that contains only an icon.
  FButton.icon({
    required this.onPress,
    required Widget child,
    this.style = Variant.outline,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : child = _FButtonIconContent(child: child);

  /// Creates a [FButton] with custom content.
  const FButton.raw({
    required this.onPress,
    required this.child,
    this.style = Variant.primary,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FButtonCustomStyle style => style,
      Variant.primary => context.theme.buttonStyles.primary,
      Variant.secondary => context.theme.buttonStyles.secondary,
      Variant.outline => context.theme.buttonStyles.outline,
      Variant.destructive => context.theme.buttonStyles.destructive,
    };

    final enabled = onPress != null || onLongPress != null;
    return FTappable.animated(
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onPress: onPress,
      onLongPress: onLongPress,
      child: DecoratedBox(
        decoration: enabled ? style.enabledBoxDecoration : style.disabledBoxDecoration,
        child: _InheritedData(
          data: (style: style, enabled: enabled),
          child: child,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('onFocusChange', onFocusChange))
      ..add(DiagnosticsProperty('builder', child));
  }
}

/// A [FButton]'s style.
///
/// A style can be either one of the pre-defined styles in [FButtonStyle] or a [FButtonCustomStyle]. The pre-defined
/// styles are a convenient shorthand for the various [FButtonCustomStyle]s in the current context's [FButtonStyles].
sealed class FButtonStyle {
  /// The button's primary style.
  ///
  /// Shorthand for the current context's [FButtonStyles.primary] style.
  static const FButtonStyle primary = Variant.primary;

  /// The button's secondary style.
  ///
  /// Shorthand for the current context's [FButtonStyles.secondary] style.
  static const FButtonStyle secondary = Variant.secondary;

  /// The button's outline style.
  ///
  /// Shorthand for the current context's [FButtonStyles.outline] style.
  static const FButtonStyle outline = Variant.outline;

  /// The button's destructive style.
  ///
  /// Shorthand for the current context's [FButtonStyles.destructive] style.
  static const FButtonStyle destructive = Variant.destructive;
}

@internal
enum Variant implements FButtonStyle {
  primary,
  secondary,
  outline,
  destructive,
}

/// A custom [FButton] style.
class FButtonCustomStyle extends FButtonStyle with Diagnosticable {
  /// The box decoration for an enabled button.
  final BoxDecoration enabledBoxDecoration;

  /// The box decoration for a disabled button.
  final BoxDecoration disabledBoxDecoration;

  /// The content's style.
  final FButtonContentStyle content;

  /// The icon's style.
  final FButtonIconStyle icon;

  /// Creates a [FButtonCustomStyle].
  FButtonCustomStyle({
    required this.enabledBoxDecoration,
    required this.disabledBoxDecoration,
    required this.content,
    required this.icon,
  });

  /// Returns a copy of this [FButtonCustomStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FButtonCustomStyle(
  ///   enabledBoxDecoration: ...,
  ///   disabledBoxDecoration: ...,
  ///   // other properties omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   disabledBoxDecoration: ...,
  /// );
  ///
  /// print(copy.background); // Colors.blue
  /// print(copy.border); // Colors.black
  /// ```
  @useResult
  FButtonCustomStyle copyWith({
    BoxDecoration? enabledBoxDecoration,
    BoxDecoration? disabledBoxDecoration,
    FButtonContentStyle? content,
    FButtonIconStyle? icon,
  }) =>
      FButtonCustomStyle(
        enabledBoxDecoration: enabledBoxDecoration ?? this.enabledBoxDecoration,
        disabledBoxDecoration: disabledBoxDecoration ?? this.disabledBoxDecoration,
        content: content ?? this.content,
        icon: icon ?? this.icon,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledBoxDecoration', enabledBoxDecoration))
      ..add(DiagnosticsProperty('disabledBoxDecoration', disabledBoxDecoration))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('icon', icon));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonCustomStyle &&
          runtimeType == other.runtimeType &&
          enabledBoxDecoration == other.enabledBoxDecoration &&
          disabledBoxDecoration == other.disabledBoxDecoration &&
          content == other.content &&
          icon == other.icon;

  @override
  int get hashCode => enabledBoxDecoration.hashCode ^ disabledBoxDecoration.hashCode ^ content.hashCode ^ icon.hashCode;
}

typedef _Data = ({FButtonCustomStyle style, bool enabled});

class _InheritedData extends InheritedWidget {
  final _Data data;

  const _InheritedData({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _InheritedData old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', data.style))
      ..add(FlagProperty('enabled', value: data.enabled, ifTrue: 'enabled'));
  }
}
