import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sidebar_group.style.dart';

/// A group of [FSidebarItem]s.
///
/// The [FSidebarGroup] widget is useful for organizing sidebar items into logical sections
/// with an optional label and action. The label is typically used to describe the group,
/// while the action can be used for group-level operations.
///
/// See:
/// * https://forui.dev/docs/layout/sidebar for working examples.
/// * [FSidebarGroupStyle] for customizing a sidebar group's appearance.
class FSidebarGroup extends StatelessWidget {
  /// The sidebar group's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  final FSidebarGroupStyle? style;

  /// The label of the group.
  final Widget? label;

  /// An optional action widget to display after the label.
  final Widget? action;

  /// Called when the action's hover state changes.
  final ValueChanged<bool>? onActionHoverChange;

  /// Called when the action's state changes.
  final ValueChanged<Set<WidgetState>>? onActionStateChange;

  /// Called when the action is pressed.
  final VoidCallback? onActionPress;

  /// The children of the group.
  final List<Widget> children;

  /// Creates a [FSidebarGroup].
  const FSidebarGroup({
    required this.children,
    this.style,
    this.label,
    this.action,
    this.onActionHoverChange,
    this.onActionStateChange,
    this.onActionPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.sidebarStyle.groupStyle;

    return Column(
      spacing: style.childrenSpacing,
      children: [
        if (label != null || action != null)
          Padding(
            padding: style.headerPadding,
            child: Row(
              spacing: style.headerSpacing,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Expanded(child: DefaultTextStyle.merge(style: style.labelStyle, child: label!))
                else
                  const SizedBox(),
                if (action != null)
                  FTappable(
                    style: style.tappableStyle,
                    focusedOutlineStyle: style.focusedOutlineStyle,
                    onHoverChange: onActionHoverChange,
                    onStateChange: onActionStateChange,
                    onPress: onActionPress,
                    builder: (_, states, child) => IconTheme(data: style.actionStyle.resolve(states), child: child!),
                    child: action!,
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
        Padding(padding: style.childrenPadding, child: Column(spacing: style.childrenSpacing, children: children)),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('onActionHoverChange', onActionHoverChange))
      ..add(ObjectFlagProperty.has('onActionStateChange', onActionStateChange))
      ..add(ObjectFlagProperty.has('onActionPress', onActionPress))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// The style for a [FSidebarGroup].
class FSidebarGroupStyle with Diagnosticable, _$FSidebarGroupStyleFunctions {
  /// The spacing between the label and action in the header.
  @override
  final double headerSpacing;

  /// The padding around the header.
  @override
  final EdgeInsetsGeometry headerPadding;

  /// The text style for the label.
  @override
  final TextStyle labelStyle;

  /// The style for the action widget.
  @override
  final FWidgetStateMap<IconThemeData> actionStyle;

  /// The spacing between children.
  @override
  final double childrenSpacing;

  /// The padding around the children.
  @override
  final EdgeInsetsGeometry childrenPadding;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FSidebarGroupStyle].
  const FSidebarGroupStyle({
    required this.headerSpacing,
    required this.headerPadding,
    required this.labelStyle,
    required this.actionStyle,
    required this.childrenSpacing,
    required this.childrenPadding,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
  });

  /// Creates a [FSidebarGroupStyle] that inherits its properties.
  FSidebarGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        headerSpacing: 8,
        headerPadding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
        labelStyle: typography.sm.copyWith(color: colors.mutedForeground, overflow: TextOverflow.ellipsis),
        actionStyle: FWidgetStateMap({
          WidgetState.hovered | WidgetState.pressed: IconThemeData(color: colors.primary, size: 16),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 16),
        }),
        childrenSpacing: 5,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
        tappableStyle: style.tappableStyle,
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}
