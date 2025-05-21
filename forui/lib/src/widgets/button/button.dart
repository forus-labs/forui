import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button_content.dart';

part 'button.style.dart';

/// A button.
///
/// [FButton] typically contains icons and/or a label. If the [onPress] and [onLongPress] callbacks are null, then this
/// button will be disabled, and it will not react to touch.
///
/// The constants in [FBaseButtonStyle] provide a convenient way to style a button.
///
/// See:
/// * https://forui.dev/docs/form/button for working examples.
/// * [FButtonStyle] for customizing a button's appearance.
class FButton extends StatelessWidget {
  /// The style. Defaults to [FButtonStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FBaseButtonStyle], it can also be a [FButtonStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create buttons
  /// ```
  final FBaseButtonStyle style;

  /// {@macro forui.foundation.FTappable.onPress}
  final VoidCallback? onPress;

  /// {@macro forui.foundation.FTappable.onLongPress}
  final VoidCallback? onLongPress;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onHoverChange}
  final ValueChanged<bool>? onHoverChange;

  /// {@macro forui.foundation.FTappable.onStateChange}
  final ValueChanged<Set<WidgetState>>? onStateChange;

  /// True if this tappable is currently selected. Defaults to false.
  final bool selected;

  /// The child.
  final Widget child;

  /// Creates a [FButton] that contains a [prefix], [child], and [suffix].
  ///
  /// [intrinsicWidth] is used to determine if the button should take up the minimum width required to fit its content.
  /// Defaults to false.
  ///
  /// [prefix] and [suffix] are wrapped in [IconThemeData].
  ///
  /// The button layout is as follows, assuming the locale is LTR:
  /// ```diagram
  /// |---------------------------------------|
  /// |  [prefixIcon]  [child]  [suffixIcon]  |
  /// |---------------------------------------|
  /// ```
  ///
  /// The layout is reversed for RTL locales.
  FButton({
    required this.onPress,
    required Widget child,
    this.style = Variant.primary,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.selected = false,
    Widget? prefix,
    Widget? suffix,
    bool intrinsicWidth = false,
    super.key,
  }) : child = Content(
         prefix: prefix,
         suffix: suffix,
         intrinsicWidth: intrinsicWidth,
         child: child,
       );

  /// Creates a [FButton] that contains only an icon.
  ///
  /// [child] is wrapped in [IconThemeData].
  FButton.icon({
    required this.onPress,
    required Widget child,
    this.style = Variant.outline,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.selected = false,
    super.key,
  }) : child = IconContent(child: child);

  /// Creates a [FButton] with custom content.
  const FButton.raw({
    required this.onPress,
    required this.child,
    this.style = Variant.primary,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.selected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FButtonStyle style => style,
      Variant.primary => context.theme.buttonStyles.primary,
      Variant.secondary => context.theme.buttonStyles.secondary,
      Variant.destructive => context.theme.buttonStyles.destructive,
      Variant.outline => context.theme.buttonStyles.outline,
      Variant.ghost => context.theme.buttonStyles.ghost,
    };

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onStateChange: onStateChange,
      onPress: onPress,
      onLongPress: onLongPress,
      selected: selected,
      builder:
          (_, states, _) => DecoratedBox(
            decoration: style.decoration.resolve(states),
            child: FButtonData(style: style, states: states, child: child),
          ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(
        FlagProperty(
          'autofocus',
          value: autofocus,
          defaultValue: false,
          ifTrue: 'autofocus',
        ),
      )
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(
        FlagProperty(
          'selected',
          value: selected,
          defaultValue: false,
          ifTrue: 'selected',
        ),
      );
  }
}

/// A [FButton]'s style.
///
/// A style can be either one of the pre-defined styles in [FButtonStyle] or a [FButtonStyle] itself.
sealed class FBaseButtonStyle {}

@internal
enum Variant implements FBaseButtonStyle {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
}

/// A [FButton]'s style.
///
/// The pre-defined styles are a convenient shorthand for the various [FButtonStyle]s in the current context's
/// [FButtonStyles].
class FButtonStyle extends FBaseButtonStyle
    with Diagnosticable, _$FButtonStyleFunctions {
  /// The button's primary style.
  ///
  /// Shorthand for the current context's [FButtonStyles.primary] style.
  static const FBaseButtonStyle primary = Variant.primary;

  /// The button's secondary style.
  ///
  /// Shorthand for the current context's [FButtonStyles.secondary] style.
  static const FBaseButtonStyle secondary = Variant.secondary;

  /// The button's destructive style.
  ///
  /// Shorthand for the current context's [FButtonStyles.destructive] style.
  static const FBaseButtonStyle destructive = Variant.destructive;

  /// The button's outline style.
  ///
  /// Shorthand for the current context's [FButtonStyles.outline] style.
  static const FBaseButtonStyle outline = Variant.outline;

  /// The button's ghost style.
  ///
  /// Shorthand for the current context's [FButtonStyles.ghost] style.
  static const FBaseButtonStyle ghost = Variant.ghost;

  /// The box decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The content's style.
  @override
  final FButtonContentStyle contentStyle;

  /// The icon content's style.
  @override
  final FButtonIconContentStyle iconContentStyle;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FButtonStyle].
  FButtonStyle({
    required this.decoration,
    required this.contentStyle,
    required this.iconContentStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
  });

  /// Creates a [FButtonStyle] that inherits its properties.
  FButtonStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required Color color,
    required Color foregroundColor,
  }) : this(
         decoration: FWidgetStateMap({
           WidgetState.disabled: BoxDecoration(
             borderRadius: style.borderRadius,
             color: colors.disable(color),
           ),
           WidgetState.hovered | WidgetState.pressed: BoxDecoration(
             borderRadius: style.borderRadius,
             color: colors.hover(color),
           ),
           WidgetState.any: BoxDecoration(
             borderRadius: style.borderRadius,
             color: color,
           ),
         }),
         focusedOutlineStyle: style.focusedOutlineStyle,
         contentStyle: FButtonContentStyle.inherit(
           typography: typography,
           enabled: foregroundColor,
           disabled: colors.disable(foregroundColor, colors.disable(color)),
         ),
         iconContentStyle: FButtonIconContentStyle(
           iconStyle: FWidgetStateMap({
             WidgetState.disabled: IconThemeData(
               color: colors.disable(foregroundColor, colors.disable(color)),
               size: 20,
             ),
             WidgetState.any: IconThemeData(color: foregroundColor, size: 20),
           }),
         ),
         tappableStyle: style.tappableStyle,
       );
}

/// A button's data.
class FButtonData extends InheritedWidget {
  /// Returns the [FButtonData] of the [FButton] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FButton] in the given [context].
  @useResult
  static FButtonData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FButtonData>();
    assert(data != null, 'No FButtonData found in context');
    return data!;
  }

  /// The button's style.
  final FButtonStyle style;

  /// The current states.
  final Set<WidgetState> states;

  /// Creates a [FButtonData].
  const FButtonData({
    required this.style,
    required this.states,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FButtonData old) =>
      style != old.style || !setEquals(states, old.states);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(IterableProperty('states', states));
  }
}
