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
class FButton extends StatelessWidget {
  @useResult
  static _Data _of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedData>();
    return theme?.data ?? (style: context.theme.buttonStyles.primary, enabled: true);
  }

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

  /// The child.
  final Widget child;

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
    String? label,
    Widget? rawLabel,
    super.key,
  })  : assert((label != null) ^ (rawLabel != null), 'Either label or rawLabel must be provided, but not both.'),
    child = FButtonContent(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      rawLabel: rawLabel,
      label: label,
    );

  /// Creates a [FButton].
  const FButton.raw({
    required this.design,
    required this.onPress,
    required this.child,
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
      FButtonVariant.outline => context.theme.buttonStyles.outlined,
      FButtonVariant.destructive => context.theme.buttonStyles.destructive,
    };

    final enabled = onPress != null || onLongPress != null;

    return _InheritedData(
      data: (style: style, enabled: enabled),
      child: Semantics(
        container: true,
        button: true,
        enabled: enabled,
        child: FocusableActionDetector(
          autofocus: autofocus,
          focusNode: focusNode,
          onFocusChange: onFocusChange,
          child: MouseRegion(
            cursor: onPress == null && onLongPress == null ? MouseCursor.defer : SystemMouseCursors.click,
            child: FTappable(
              onTap: onPress,
              onLongPress: onLongPress,
              child: DecoratedBox(
                decoration: onPress == null && onLongPress == null ? style.disabledBoxDecoration : style.enabledBoxDecoration,
                child: child,
              ),
            ),
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
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('onFocusChange', onFocusChange))
      ..add(DiagnosticsProperty('builder', child));
  }
}

/// The button design. Either a pre-defined [FButtonVariant], or a custom [FButtonStyle].
sealed class FButtonDesign {}

/// A pre-defined button variant.
enum FButtonVariant implements FButtonDesign {
  /// A primary-styled button.
  primary,

  /// A secondary-styled button.
  secondary,

  /// An outlined button.
  outline,

  /// A destructive button.
  destructive,
}

/// Represents the theme data that is inherited by [FButtonStyle] and used by child [FButton].
class FButtonStyle extends FButtonDesign with Diagnosticable {
  /// The box decoration for an enabled button.
  final BoxDecoration enabledBoxDecoration;

  /// The box decoration for a disabled button.
  final BoxDecoration disabledBoxDecoration;

  /// The content.
  final FButtonContentStyle content;

  /// The icon.
  final FButtonIconStyle icon;

  /// Creates a [FButtonStyle].
  FButtonStyle({
    required this.enabledBoxDecoration,
    required this.disabledBoxDecoration,
    required this.content,
    required this.icon,
  });

  /// Creates a copy of this [FButtonStyle] with the given properties replaced.
  FButtonStyle copyWith({
    BoxDecoration? enabledBoxDecoration,
    BoxDecoration? disabledBoxDecoration,
    FButtonContentStyle? content,
    FButtonIconStyle? icon,
  }) =>
      FButtonStyle(
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
      other is FButtonStyle &&
          runtimeType == other.runtimeType &&
          enabledBoxDecoration == other.enabledBoxDecoration &&
          disabledBoxDecoration == other.disabledBoxDecoration &&
          content == other.content &&
          icon == other.icon;

  @override
  int get hashCode => enabledBoxDecoration.hashCode ^ disabledBoxDecoration.hashCode ^ content.hashCode ^ icon.hashCode;
}

typedef _Data = ({FButtonStyle style, bool enabled});

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
