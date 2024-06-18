import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:sugar/collection.dart';

part 'button_content.dart';
part 'button_content_icon.dart';
part 'button_styles.dart';

/// A button.
class FButton extends StatelessWidget {
  /// The design. Defaults to [FBadgeVariant.primary].
  final FButtonDesign design;

  /// A callback for when the button is pressed.
  final VoidCallback? onPress;

  /// A callback for when the button is long pressed.
  final VoidCallback? onLongPress;

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

  /// The builder.
  final Widget Function(BuildContext, FButtonStyle) builder;

  /// Creates a [FButton].
  FButton({
    required this.onPress,
    this.design = FButtonVariant.primary,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? label,
    String? labelText,
    super.key,
  }) :
    assert((label != null) ^ (labelText != null), 'Either label or labelText must be provided, but not both.'),
    builder = ((context, style) => FButtonContent(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      label: label,
      labelText: labelText,
      style: style,
      enabled: onPress != null,
    ));

  /// Creates a [FButton].
  const FButton.raw({
    required this.design,
    required this.onPress,
    required this.builder,
    this.onLongPress,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (design) {
      final FButtonStyle style => style,
      FButtonVariant.primary => context.theme.buttonStyles.primary,
      FButtonVariant.secondary => context.theme.buttonStyles.secondary,
      FButtonVariant.outlined => context.theme.buttonStyles.outlined,
      FButtonVariant.destructive => context.theme.buttonStyles.destructive,
    };

    return Semantics(
      container: true,
      button: true,
      enabled: onPress != null || onLongPress != null,
      child: FocusableActionDetector(
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        child: FTappable(
          onTap: onPress,
          onLongPress: onLongPress,
          child: DecoratedBox(
            decoration: onPress == null ? style.disabledBoxDecoration : style.enabledBoxDecoration,
            child: builder(context, style),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('design', design))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('onFocusChange', onFocusChange))
      ..add(DiagnosticsProperty('builder', builder));
  }
}

/// The button design. Either a pre-defined [FButtonVariant], or a custom [FButtonStyle].
sealed class FButtonDesign {}

/// A pre-defined button variant.
enum FButtonVariant implements FButtonDesign  {
  /// A primary-styled button.
  primary,

  /// A secondary-styled button.
  secondary,

  /// An outlined button.
  outlined,

  /// A destructive button.
  destructive,
}

/// Represents the theme data that is inherited by [FButtonStyle] and used by child [FButton].
class FButtonStyle extends FButtonDesign with Diagnosticable{
  /// The content.
  final FButtonContentStyle content;

  /// The box decoration for an enabled button.
  final BoxDecoration enabledBoxDecoration;

  /// The box decoration for a disabled button.
  final BoxDecoration disabledBoxDecoration;

  /// Creates a [FButtonStyle].
  FButtonStyle({
    required this.content,
    required this.enabledBoxDecoration,
    required this.disabledBoxDecoration,
  });

  /// Creates a copy of this [FButtonStyle] with the given properties replaced.
  FButtonStyle copyWith({
    FButtonContentStyle? content,
    BoxDecoration? enabledBoxDecoration,
    BoxDecoration? disabledBoxDecoration,
  }) =>
      FButtonStyle(
        content: content ?? this.content,
        enabledBoxDecoration: enabledBoxDecoration ?? this.enabledBoxDecoration,
        disabledBoxDecoration: disabledBoxDecoration ?? this.disabledBoxDecoration,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('enabledBoxDecoration', enabledBoxDecoration))
      ..add(DiagnosticsProperty('disabledBoxDecoration', disabledBoxDecoration));
  }
}
