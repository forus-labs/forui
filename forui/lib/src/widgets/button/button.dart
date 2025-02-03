import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button_content.dart';
import 'package:meta/meta.dart';

/// A button.
///
/// [FButton]s typically contain icons and/or a label. If the [onPress] and [onLongPress] callbacks are null, then this
/// button will be disabled, it will not react to touch.
///
/// The constants in [FButtonStyle] provide a convenient way to style a badge.
///
/// See:
/// * https://forui.dev/docs/form/button for working examples.
/// * [FButtonCustomStyle] for customizing a button's appearance.
class FButton extends StatelessWidget {
  /// The style. Defaults to [FButtonStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FButtonStyle], it can also be a [FButtonCustomStyle].
  final FButtonStyle style;

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

  /// The child.
  final Widget child;

  /// Creates a [FButton] that contains a [prefix], [label], and [suffix].
  ///
  /// [prefix] and [suffix] are wrapped in [FIconStyle], and therefore works with [FIcon]s.
  ///
  /// The button layout is as follows, assuming the locale is LTR:
  /// ```diagram
  /// |---------------------------------------|
  /// |  [prefixIcon]  [label]  [suffixIcon]  |
  /// |---------------------------------------|
  /// ```
  ///
  /// The layout is reversed for RTL locales.
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
  }) : child = Content(prefix: prefix, suffix: suffix, label: label);

  /// Creates a [FButton] that contains only an icon.
  ///
  /// [child] is wrapped in [FIconStyle], and therefore works with [FIcon]s.
  FButton.icon({
    required this.onPress,
    required Widget child,
    this.style = Variant.outline,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FButtonCustomStyle style => style,
      Variant.primary => context.theme.buttonStyles.primary,
      Variant.secondary => context.theme.buttonStyles.secondary,
      Variant.destructive => context.theme.buttonStyles.destructive,
      Variant.outline => context.theme.buttonStyles.outline,
      Variant.ghost => context.theme.buttonStyles.ghost,
    };

    final enabled = onPress != null || onLongPress != null;

    return FTappable.animated(
      focusedOutlineStyle: style.focusedOutlineStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onPress: onPress,
      onLongPress: onLongPress,
      builder: (context, data, child) => DecoratedBox(
        decoration: switch ((enabled, data.hovered)) {
          (true, false) => style.enabledBoxDecoration,
          (true, true) => style.enabledHoverBoxDecoration,
          (false, _) => style.disabledBoxDecoration,
        },
        child: child,
      ),
      child: FButtonData(
        style: style,
        enabled: enabled,
        child: child,
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
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
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

  /// The button's destructive style.
  ///
  /// Shorthand for the current context's [FButtonStyles.destructive] style.
  static const FButtonStyle destructive = Variant.destructive;

  /// The button's outline style.
  ///
  /// Shorthand for the current context's [FButtonStyles.outline] style.
  static const FButtonStyle outline = Variant.outline;

  /// The button's ghost style.
  ///
  /// Shorthand for the current context's [FButtonStyles.ghost] style.
  static const FButtonStyle ghost = Variant.ghost;
}

@internal
enum Variant implements FButtonStyle {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
}

/// A custom [FButton] style.
class FButtonCustomStyle extends FButtonStyle with Diagnosticable {
  /// The box decoration for an enabled button.
  final BoxDecoration enabledBoxDecoration;

  /// The box decoration for an enabled button when it is hovered over.
  final BoxDecoration enabledHoverBoxDecoration;

  /// The box decoration for a disabled button.
  final BoxDecoration disabledBoxDecoration;

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The content's style.
  final FButtonContentStyle contentStyle;

  /// The icon content's style.
  final FButtonIconContentStyle iconContentStyle;

  /// The spinner's style.
  final FButtonSpinnerStyle spinnerStyle;

  /// Creates a [FButtonCustomStyle].
  FButtonCustomStyle({
    required this.enabledBoxDecoration,
    required this.enabledHoverBoxDecoration,
    required this.disabledBoxDecoration,
    required this.focusedOutlineStyle,
    required this.contentStyle,
    required this.iconContentStyle,
    required this.spinnerStyle,
  });

  /// Creates a [FButtonCustomStyle] that inherits its properties from the given arguments.
  FButtonCustomStyle.inherit({
    required FTypography typography,
    required FStyle style,
    required Color enabledBoxColor,
    required Color enabledHoveredBoxColor,
    required Color disabledBoxColor,
    required Color enabledContentColor,
    required Color disabledContentColor,
  }) : this(
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: enabledBoxColor,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: enabledHoveredBoxColor,
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: disabledBoxColor,
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: enabledContentColor,
            disabled: disabledContentColor,
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledColor: enabledContentColor,
            disabledColor: disabledContentColor,
          ),
          spinnerStyle: FButtonSpinnerStyle.inherit(
            enabled: enabledContentColor,
            disabled: disabledContentColor,
          ),
        );

  /// Returns a copy of this [FButtonCustomStyle] with the given properties replaced.
  @useResult
  FButtonCustomStyle copyWith({
    BoxDecoration? enabledBoxDecoration,
    BoxDecoration? enabledHoverBoxDecoration,
    BoxDecoration? disabledBoxDecoration,
    FFocusedOutlineStyle? focusedOutlineStyle,
    FButtonContentStyle? contentStyle,
    FButtonIconContentStyle? iconContentStyle,
    FButtonSpinnerStyle? spinnerStyle,
  }) =>
      FButtonCustomStyle(
        enabledBoxDecoration: enabledBoxDecoration ?? this.enabledBoxDecoration,
        enabledHoverBoxDecoration: enabledHoverBoxDecoration ?? this.enabledHoverBoxDecoration,
        disabledBoxDecoration: disabledBoxDecoration ?? this.disabledBoxDecoration,
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
        contentStyle: contentStyle ?? this.contentStyle,
        iconContentStyle: iconContentStyle ?? this.iconContentStyle,
        spinnerStyle: spinnerStyle ?? this.spinnerStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledBoxDecoration', enabledBoxDecoration))
      ..add(DiagnosticsProperty('enabledHoverBoxDecoration', enabledHoverBoxDecoration))
      ..add(DiagnosticsProperty('disabledBoxDecoration', disabledBoxDecoration))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('iconContentStyle', iconContentStyle))
      ..add(DiagnosticsProperty('spinnerStyle', spinnerStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonCustomStyle &&
          runtimeType == other.runtimeType &&
          enabledBoxDecoration == other.enabledBoxDecoration &&
          enabledHoverBoxDecoration == other.enabledHoverBoxDecoration &&
          disabledBoxDecoration == other.disabledBoxDecoration &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          contentStyle == other.contentStyle &&
          iconContentStyle == other.iconContentStyle &&
          spinnerStyle == other.spinnerStyle;

  @override
  int get hashCode =>
      enabledBoxDecoration.hashCode ^
      enabledHoverBoxDecoration.hashCode ^
      disabledBoxDecoration.hashCode ^
      focusedOutlineStyle.hashCode ^
      contentStyle.hashCode ^
      iconContentStyle.hashCode ^
      spinnerStyle.hashCode;
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
  final FButtonCustomStyle style;

  /// True if the button is enabled.
  final bool enabled;

  /// Creates a [FButtonData].
  const FButtonData({
    required this.style,
    required super.child,
    this.enabled = true,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant FButtonData old) => style != old.style || enabled != old.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'));
  }
}
