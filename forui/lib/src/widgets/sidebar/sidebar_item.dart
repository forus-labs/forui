import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sidebar_item.style.dart';

/// A sidebar item.
///
/// The [FSidebarItem] widget is useful for creating interactive items in a sidebar.
/// It can display an icon, label, and optional action, with support for selected and
/// enabled states.
///
/// See:
/// * https://forui.dev/docs/layout/sidebar for working examples.
/// * [FSidebarItemStyle] for customizing a sidebar item's appearance.
class FSidebarItem extends StatefulWidget {
  /// The sidebar item's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  final FSidebarItemStyle? style;

  /// The icon to display before the label.
  final Widget? icon;

  /// The main content of the item.
  final Widget? label;

  /// Whether this item is currently selected.
  final bool selected;

  /// Whether this item is initially expanded.
  final bool initiallyExpanded;

  /// Called when the item is pressed.
  ///
  /// The method will run concurrently with animations if [children] is non-null.
  final VoidCallback? onPress;

  /// Called when the item is long pressed.
  final VoidCallback? onLongPress;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the state changes.
  final ValueChanged<Set<WidgetState>>? onStateChange;

  /// The children of this sidebar item.
  final List<Widget>? children;

  /// Creates a [FSidebarItem].
  const FSidebarItem({
    this.style,
    this.icon,
    this.label,
    this.selected = false,
    this.initiallyExpanded = false,
    this.onPress,
    this.onLongPress,
    this.onHoverChange,
    this.onStateChange,
    this.children,
    super.key,
  });

  @override
  State<FSidebarItem> createState() => _FSidebarItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(FlagProperty('initiallyExpanded', value: initiallyExpanded, ifTrue: 'initiallyExpanded'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(DiagnosticsProperty('children', children));
  }
}

class _FSidebarItemState extends State<FSidebarItem> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curvedAnimation;
  late bool _expanded;

  void _toggle() {
    _controller.toggle();
    setState(() {
      _expanded = !_expanded;
    });
  }

  FSidebarItemStyle _style(BuildContext context) {
    final groupData = FSidebarGroupData.maybeOf(context);
    final sidebarData = FSidebarData.maybeOf(context);

    return widget.style ??
        groupData?.style.itemStyle ??
        sidebarData?.style.groupStyle.itemStyle ??
        context.theme.sidebarStyle.groupStyle.itemStyle;
  }

  @override
  void initState() {
    super.initState();

    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(vsync: this, value: _expanded ? 1.0 : 0.0);
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = _style(context).collapsibleAnimationDuration;
  }

  @override
  Widget build(BuildContext context) {
    final style = _style(context);
    final hasChildren = widget.children != null && widget.children!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FTappable(
          style: style.tappableStyle,
          focusedOutlineStyle: style.focusedOutlineStyle,
          selected: widget.selected,
          onPress:
              hasChildren
                  ? () {
                    _toggle();
                    widget.onPress?.call();
                  }
                  : widget.onPress,
          onLongPress: widget.onLongPress,
          onHoverChange: widget.onHoverChange,
          onStateChange: widget.onStateChange,
          builder:
              (_, states, child) => Container(
                padding: style.padding,
                decoration: BoxDecoration(
                  color: style.backgroundColor.resolve(states),
                  borderRadius: style.borderRadius,
                ),
                child: Row(
                  spacing: style.collapsibleSpacing,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: style.iconSpacing,
                        children: [
                          if (widget.icon != null)
                            IconTheme(data: style.iconStyle.resolve(states), child: widget.icon!),
                          if (widget.label != null)
                            Expanded(
                              child: DefaultTextStyle.merge(
                                style: style.textStyle.resolve(states),
                                child: widget.label!,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (hasChildren)
                      IconTheme(
                        data: style.collapsibleIconStyle.resolve(states),
                        child: RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.25).animate(_curvedAnimation),
                          child: const Icon(FIcons.chevronRight),
                        ),
                      ),
                  ],
                ),
              ),
        ),
        if (hasChildren)
          AnimatedBuilder(
            animation: _curvedAnimation,
            builder:
                (context, child) => FCollapsible(
                  value: _controller.value,
                  child: Padding(
                    padding: style.childrenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: style.childrenSpacing,
                      children: widget.children!,
                    ),
                  ),
                ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _curvedAnimation.dispose();
    super.dispose();
  }
}

/// The style for a [FSidebarItem].
class FSidebarItemStyle with Diagnosticable, _$FSidebarItemStyleFunctions {
  /// The text style for the label.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The spacing between the icon and label.
  @override
  final double iconSpacing;

  /// The style for the icon.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The spacing between the label and collapsible widget.
  @override
  final double collapsibleSpacing;

  /// The style for the collapsible widget.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> collapsibleIconStyle;

  /// The duration of the expand/collapse animation.
  @override
  final Duration collapsibleAnimationDuration;

  /// The spacing between child items.
  @override
  final double childrenSpacing;

  /// The padding around the children container.
  @override
  final EdgeInsetsGeometry childrenPadding;

  /// The background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Color> backgroundColor;

  /// The padding around the content.
  @override
  final EdgeInsetsGeometry padding;

  /// The border radius of the item.
  @override
  final BorderRadius borderRadius;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FSidebarItemStyle].
  const FSidebarItemStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.collapsibleIconStyle,
    required this.backgroundColor,
    required this.borderRadius,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.iconSpacing = 8,
    this.collapsibleSpacing = 8,
    this.childrenSpacing = 2,
    this.childrenPadding = const EdgeInsets.only(left: 10, top: 4),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.collapsibleAnimationDuration = const Duration(milliseconds: 100),
  });

  /// Creates a [FSidebarItemStyle] that inherits its properties.
  FSidebarItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        textStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(
            color: colors.mutedForeground,
            height: 1,
            overflow: TextOverflow.ellipsis,
          ),
          WidgetState.any: typography.base.copyWith(
            color: colors.foreground,
            height: 1,
            overflow: TextOverflow.ellipsis,
          ),
        }),
        iconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.mutedForeground, size: 16),
          WidgetState.any: IconThemeData(color: colors.foreground, size: 16),
        }),
        collapsibleIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.mutedForeground, size: 16),
          WidgetState.any: IconThemeData(color: colors.foreground, size: 16),
        }),
        backgroundColor: FWidgetStateMap({
          WidgetState.disabled: Colors.transparent,
          WidgetState.selected | WidgetState.hovered | WidgetState.pressed: colors.primary.withValues(alpha: 0.03),
          WidgetState.any: Colors.transparent,
        }),
        borderRadius: style.borderRadius,
        tappableStyle: style.tappableStyle,
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}
