import 'dart:ui' show lerpDouble, Color;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tree/tree_painter.dart';

part 'tree_item.design.dart';

/// A tree item that can be expanded or collapsed to show/hide children.
///
/// The [FTreeItem] widget is useful for creating hierarchical structures with visual connecting lines.
///
/// See:
/// * https://forui.dev/docs/data/tree for working examples.
/// * [FTreeItemStyle] for customizing a tree item's appearance.
class FTreeItem extends StatefulWidget {
  /// The tree item's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tree
  /// ```
  final FTreeItemStyle Function(FTreeItemStyle style)? style;

  /// The icon to display before the label.
  final Widget? icon;

  /// The main content of the item.
  final Widget? label;

  /// Whether this item is currently selected.
  final bool selected;

  /// Whether this item is initially expanded. Defaults to false.
  final bool initiallyExpanded;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// Called when the item is pressed.
  ///
  /// The method will run concurrently with animations if [children] is non-null.
  final VoidCallback? onPress;

  /// Called when the item is long pressed.
  final VoidCallback? onLongPress;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the state changes.
  final ValueChanged<FWidgetStatesDelta>? onStateChange;

  /// Called when the expansion state changes.
  final ValueChanged<bool>? onExpandChange;

  /// Called when the visible row count changes (including this item and all visible descendants).
  final ValueChanged<int>? onRowCountChange;

  /// The tree item's children.
  final List<FTreeItem> children;

  /// Creates a [FTreeItem].
  const FTreeItem({
    this.style,
    this.icon,
    this.label,
    this.selected = false,
    this.initiallyExpanded = false,
    this.autofocus = false,
    this.focusNode,
    this.onPress,
    this.onLongPress,
    this.onHoverChange,
    this.onStateChange,
    this.onExpandChange,
    this.onRowCountChange,
    this.children = const [],
    super.key,
  });

  @override
  State<FTreeItem> createState() => _FTreeItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(FlagProperty('initiallyExpanded', value: initiallyExpanded, ifTrue: 'initiallyExpanded'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(ObjectFlagProperty.has('onExpandChange', onExpandChange))
      ..add(ObjectFlagProperty.has('onRowCountChange', onRowCountChange))
      ..add(DiagnosticsProperty('children', children));
  }
}

class _FTreeItemState extends State<FTreeItem> with TickerProviderStateMixin {
  FTreeItemStyle? _style;
  AnimationController? _controller;
  CurvedAnimation? _curvedReveal;
  CurvedAnimation? _curvedFade;
  CurvedAnimation? _curvedIconRotation;
  Animation<double>? _reveal;
  Animation<double>? _fade;
  Animation<double>? _iconRotation;
  late bool _expanded;
  late Map<int, bool> _childExpansionStates;
  late Map<int, int> _childRowCounts;
  bool _hasNotifiedInitialRowCount = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _childExpansionStates = {
      for (var i = 0; i < widget.children.length; i++) i: widget.children[i].initiallyExpanded,
    };
    // Initialize with 1 row per child (will be updated when children report their actual counts)
    _childRowCounts = {
      for (var i = 0; i < widget.children.length; i++) i: 1,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();

    // Notify parent of initial row count after first build
    if (!_hasNotifiedInitialRowCount) {
      _hasNotifiedInitialRowCount = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _notifyRowCountChange();
        }
      });
    }
  }

  @override
  void didUpdateWidget(FTreeItem old) {
    super.didUpdateWidget(old);
    _update();
  }

  void _update() {
    final treeData = FTreeData.maybeOf(context);
    final inheritedStyle = treeData?.style.itemStyle ?? context.theme.treeStyle.itemStyle;
    final style = widget.style?.call(inheritedStyle) ?? inheritedStyle;

    if (_style != style) {
      _style = style;
      _curvedIconRotation?.dispose();
      _curvedFade?.dispose();
      _curvedReveal?.dispose();
      _controller?.dispose();

      _controller = AnimationController(
        vsync: this,
        value: _expanded ? 1.0 : 0.0,
        duration: style.motion.expandDuration,
        reverseDuration: style.motion.collapseDuration,
      );
      _curvedReveal = CurvedAnimation(
        curve: style.motion.expandCurve,
        reverseCurve: style.motion.collapseCurve,
        parent: _controller!,
      );
      _curvedFade = CurvedAnimation(curve: Curves.easeIn, reverseCurve: Curves.easeOut, parent: _controller!);
      _curvedIconRotation = CurvedAnimation(
        curve: style.motion.iconExpandCurve,
        reverseCurve: style.motion.iconCollapseCurve,
        parent: _controller!,
      );
      _reveal = style.motion.revealTween.animate(_curvedReveal!);
      _fade = style.motion.fadeTween.animate(_curvedFade!);
      _iconRotation = style.motion.iconTween.animate(_curvedIconRotation!);

      if (_expanded) {
        _controller!.value = 1.0;
      }
    }
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      widget.onExpandChange?.call(_expanded);
      _notifyRowCountChange();
      if (_expanded) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });
  }

  /// Calculates and notifies parent of this item's total visible row count.
  void _notifyRowCountChange() {
    final rowCount = _calculateRowCount();
    widget.onRowCountChange?.call(rowCount);
  }

  /// Calculates the total number of visible rows for this item including descendants.
  int _calculateRowCount() {
    if (!_expanded || widget.children.isEmpty) {
      return 1; // Just this item
    }
    // This item plus all visible children
    var count = 1;
    for (var i = 0; i < widget.children.length; i++) {
      count += _childRowCounts[i] ?? 1;
    }
    return count;
  }

  @override
  void dispose() {
    _curvedIconRotation?.dispose();
    _curvedFade?.dispose();
    _curvedReveal?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final treeData = FTreeData.maybeOf(context);
    final indentWidth = treeData?.style.indentWidth ?? context.theme.treeStyle.indentWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main item content
        FTappable(
          style: _style!.tappableStyle,
          focusedOutlineStyle: _style!.focusedOutlineStyle,
          selected: widget.selected,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          onPress: widget.children.isNotEmpty
              ? () {
                  _toggle();
                  widget.onPress?.call();
                }
              : widget.onPress,
          onLongPress: widget.onLongPress,
          onHoverChange: widget.onHoverChange,
          onStateChange: widget.onStateChange,
          builder: (_, states, child) => Container(
            padding: _style!.padding,
            decoration: BoxDecoration(
              color: _style!.backgroundColor.resolve(states),
              borderRadius: _style!.borderRadius,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: _style!.iconSpacing,
              children: [
                if (widget.children.isNotEmpty)
                  IconTheme(
                    data: _style!.expandIconStyle.resolve(states),
                    child: RotationTransition(turns: _iconRotation!, child: const Icon(FIcons.chevronRight)),
                  )
                else if (widget.icon != null)
                  IconTheme(data: _style!.iconStyle.resolve(states), child: widget.icon!),
                if (widget.label != null)
                  Flexible(
                    child: DefaultTextStyle.merge(style: _style!.textStyle.resolve(states), child: widget.label!),
                  ),
              ],
            ),
          ),
        ),
        // Expandable children
        if (widget.children.isNotEmpty)
          AnimatedBuilder(
            animation: _reveal!,
            builder: (_, _) => FCollapsible(
              value: _reveal!.value,
              child: AnimatedBuilder(
                animation: _fade!,
                builder: (context, child) {
                  // Use tracked row counts from children
                  final childRowCounts = [
                    for (var i = 0; i < widget.children.length; i++) _childRowCounts[i] ?? 1,
                  ];

                  return FadeTransition(
                    opacity: _fade!,
                    child: Padding(
                      padding: EdgeInsets.only(left: indentWidth),
                      child: CustomPaint(
                        painter: FTreeChildrenLinePainter(
                          lineStyle: _style!.lineStyle,
                          childCount: widget.children.length,
                          childrenSpacing: _style!.childrenSpacing,
                          childRowCounts: childRowCounts,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          spacing: _style!.childrenSpacing,
                          children: [
                            for (var i = 0; i < widget.children.length; i++)
                              FTreeItem(
                                key: widget.children[i].key,
                                style: widget.children[i].style,
                                icon: widget.children[i].icon,
                                label: widget.children[i].label,
                                selected: widget.children[i].selected,
                                initiallyExpanded: widget.children[i].initiallyExpanded,
                                autofocus: widget.children[i].autofocus,
                                focusNode: widget.children[i].focusNode,
                                onPress: widget.children[i].onPress,
                                onLongPress: widget.children[i].onLongPress,
                                onHoverChange: widget.children[i].onHoverChange,
                                onStateChange: widget.children[i].onStateChange,
                                onExpandChange: (expanded) {
                                  setState(() {
                                    _childExpansionStates[i] = expanded;
                                  });
                                },
                                onRowCountChange: (rowCount) {
                                  setState(() {
                                    _childRowCounts[i] = rowCount;
                                  });
                                  // Propagate the change up to our parent
                                  _notifyRowCountChange();
                                },
                                children: widget.children[i].children,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

/// The [FTreeItemStyle] for a [FTreeItem].
class FTreeItemStyle with Diagnosticable, _$FTreeItemStyleFunctions {
  /// The background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<Color> backgroundColor;

  /// The border radius. Defaults to `BorderRadius.circular(6)`.
  @override
  final BorderRadius borderRadius;

  /// The text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The icon style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The expand/collapse icon style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<IconThemeData> expandIconStyle;

  /// The padding around the item content. Defaults to `EdgeInsets.symmetric(horizontal: 8, vertical: 4)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between the icon and label. Defaults to 6.
  @override
  final double iconSpacing;

  /// The spacing between child items. Defaults to 2.
  @override
  final double childrenSpacing;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The line style for tree connectors.
  @override
  final FTreeLineStyle lineStyle;

  /// The animation style for expand/collapse.
  @override
  final FTreeItemMotion motion;

  /// Creates a [FTreeItemStyle].
  const FTreeItemStyle({
    required this.backgroundColor,
    required this.textStyle,
    required this.iconStyle,
    required this.expandIconStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    required this.lineStyle,
    required this.motion,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.iconSpacing = 6,
    this.childrenSpacing = 2,
  });

  /// Creates a [FTreeItemStyle] that inherits its properties.
  FTreeItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        backgroundColor: FWidgetStateMap({
          WidgetState.disabled: colors.disable(colors.background),
          WidgetState.hovered: colors.secondary,
          WidgetState.selected: colors.secondary,
          WidgetState.any: Colors.transparent,
        }),
        textStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.foreground)),
          WidgetState.any: typography.base.copyWith(color: colors.foreground),
        }),
        iconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 16),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 16),
        }),
        expandIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 16),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 16),
        }),
        tappableStyle: FTappableStyle(),
        focusedOutlineStyle: style.focusedOutlineStyle,
        lineStyle: FTreeLineStyle.inherit(colors: colors, style: style),
        motion: FTreeItemMotion(),
      );
}

/// The animation style for [FTreeItem] expand/collapse.
class FTreeItemMotion with Diagnosticable {
  /// The expand duration. Defaults to 250ms.
  final Duration expandDuration;

  /// The collapse duration. Defaults to 200ms.
  final Duration collapseDuration;

  /// The expand curve. Defaults to [Curves.easeInOut].
  final Curve expandCurve;

  /// The collapse curve. Defaults to [Curves.easeInOut].
  final Curve collapseCurve;

  /// The icon expand curve. Defaults to [Curves.easeInOut].
  final Curve iconExpandCurve;

  /// The icon collapse curve. Defaults to [Curves.easeInOut].
  final Curve iconCollapseCurve;

  /// The reveal tween. Defaults to `Tween(begin: 0.0, end: 1.0)`.
  final Tween<double> revealTween;

  /// The fade tween. Defaults to `Tween(begin: 0.0, end: 1.0)`.
  final Tween<double> fadeTween;

  /// The icon rotation tween. Defaults to `Tween(begin: 0.0, end: 0.25)`.
  final Tween<double> iconTween;

  /// Creates a [FTreeItemMotion].
  FTreeItemMotion({
    this.expandDuration = const Duration(milliseconds: 250),
    this.collapseDuration = const Duration(milliseconds: 200),
    this.expandCurve = Curves.easeInOut,
    this.collapseCurve = Curves.easeInOut,
    this.iconExpandCurve = Curves.easeInOut,
    this.iconCollapseCurve = Curves.easeInOut,
    Tween<double>? revealTween,
    Tween<double>? fadeTween,
    Tween<double>? iconTween,
  }) : revealTween = revealTween ?? Tween(begin: 0.0, end: 1.0),
       fadeTween = fadeTween ?? Tween(begin: 0.0, end: 1.0),
       iconTween = iconTween ?? Tween(begin: 0.0, end: 0.25);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration))
      ..add(DiagnosticsProperty('expandCurve', expandCurve))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve))
      ..add(DiagnosticsProperty('iconExpandCurve', iconExpandCurve))
      ..add(DiagnosticsProperty('iconCollapseCurve', iconCollapseCurve))
      ..add(DiagnosticsProperty('revealTween', revealTween))
      ..add(DiagnosticsProperty('fadeTween', fadeTween))
      ..add(DiagnosticsProperty('iconTween', iconTween));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTreeItemMotion &&
          runtimeType == other.runtimeType &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          iconExpandCurve == other.iconExpandCurve &&
          iconCollapseCurve == other.iconCollapseCurve &&
          revealTween == other.revealTween &&
          fadeTween == other.fadeTween &&
          iconTween == other.iconTween;

  @override
  int get hashCode =>
      expandDuration.hashCode ^
      collapseDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      iconExpandCurve.hashCode ^
      iconCollapseCurve.hashCode ^
      revealTween.hashCode ^
      fadeTween.hashCode ^
      iconTween.hashCode;
}

/// The line style for tree connectors.
///
/// Note: The [dashPattern] is nullable, which affects equality comparisons.
class FTreeLineStyle with Diagnosticable, _$FTreeLineStyleFunctions {
  /// The line color.
  @override
  final Color color;

  /// The line width. Defaults to 1.0.
  @override
  final double width;

  /// The line dash pattern. If null, the line is solid.
  @override
  final List<double>? dashPattern;

  /// Creates a [FTreeLineStyle].
  const FTreeLineStyle({required this.color, this.width = 1.0, this.dashPattern});

  /// Creates a [FTreeLineStyle] that inherits its properties.
  FTreeLineStyle.inherit({required FColors colors, required FStyle style})
    : this(color: colors.border, width: style.borderWidth);
}
