import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A popover menu displays a menu in a portal aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover-menu for working examples.
/// * [FPopoverController] for controlling a popover menu.
/// * [FPopoverMenuStyle] for customizing a popover menu's appearance.
/// * [FTileGroup] for customizing the items in the menu.
class FPopoverMenu extends StatefulWidget implements FPopoverProperties, FTileGroupProperties {
  /// The popover menu's style.
  final FPopoverMenuStyle? style;

  /// The controller that shows and hides the menu. It initially hides the menu.
  final FPopoverController? popoverController;

  @override
  final ScrollController? scrollController;

  @override
  final double? cacheExtent;

  @override
  final double maxHeight;

  @override
  final DragStartBehavior dragStartBehavior;

  @override
  final FTileDivider divider;

  /// {@macro forui.widgets.FPopoverProperties.popoverAnchor}
  ///
  /// Defaults to [Alignment.topCenter].
  @override
  final Alignment popoverAnchor;

  /// {@macro forui.widgets.FPopoverProperties.childAnchor}
  ///
  /// Defaults to [Alignment.bottomCenter].
  @override
  final Alignment childAnchor;

  @override
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  @override
  final bool hideOnTapOutside;

  @override
  final bool directionPadding;

  @override
  final bool autofocus;

  @override
  final FocusNode? focusNode;

  @override
  final ValueChanged<bool>? onFocusChange;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// The menu.
  final List<FTileGroupMixin<FTileMixin>> menu;

  /// The child.
  final Widget child;

  final bool _automatic;

  /// Creates a menu that only shows the menu when the controller is manually toggled.
  const FPopoverMenu({
    required FPopoverController this.popoverController,
    required this.menu,
    required this.child,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FTileDivider.full,
    this.popoverAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : _automatic = false;

  /// Creates a menu that is automatically shown when the [child] is tapped.
  ///
  /// It is not recommended for the [child] to contain a [GestureDetector], such as [FButton]. Only one
  /// `GestureDetector` will be called if there are multiple overlapping `GestureDetector`s, leading to unexpected
  /// behavior.
  const FPopoverMenu.automatic({
    required this.menu,
    required this.child,
    this.style,
    this.popoverController,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FTileDivider.full,
    this.popoverAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : _automatic = true;

  @override
  State<FPopoverMenu> createState() => _FPopoverMenuState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('popoverAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside, ifTrue: 'hideOnTapOutside'))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _FPopoverMenuState extends State<FPopoverMenu> with SingleTickerProviderStateMixin {
  late FPopoverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.popoverController ?? FPopoverController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant FPopoverMenu old) {
    super.didUpdateWidget(old);
    if (widget.popoverController == old.popoverController) {
      return;
    }

    if (old.popoverController != null) {
      _controller.dispose();
    }
    _controller = widget.popoverController ?? FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverMenuStyle;
    return FPopover.fromProperties(
      properties: widget,
      controller: _controller,
      style: style,
      automatic: widget._automatic,
      semanticLabel: null,
      popoverBuilder: (context, _, __) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: style.maxWidth),
        child: FTileGroup.merge(
          scrollController: widget.scrollController,
          cacheExtent: widget.cacheExtent,
          maxHeight: widget.maxHeight,
          dragStartBehavior: widget.dragStartBehavior,
          semanticLabel: widget.semanticLabel,
          style: style.tileGroupStyle,
          divider: widget.divider,
          children: widget.menu,
        ),
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.popoverController == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// A [FPopoverMenuStyle]'s style.
final class FPopoverMenuStyle extends FPopoverStyle {
  /// The tile group's style.
  final FTileGroupStyle tileGroupStyle;

  /// The menu's max width. Defaults to 250.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the width is not positive.
  final double maxWidth;

  /// Creates a [FPopoverMenuStyle].
  const FPopoverMenuStyle({
    required this.tileGroupStyle,
    required super.decoration,
    this.maxWidth = 250,
    super.padding,
  }) : assert(0 < maxWidth, 'maxWidth must be positive');

  /// Creates a [FPopoverMenuStyle] that inherits its properties from [colorScheme], [style] and [typography].
  FPopoverMenuStyle.inherit({
    required super.colorScheme,
    required super.style,
    required FTypography typography,
  })  : tileGroupStyle = FTileGroupStyle.inherit(colorScheme: colorScheme, style: style, typography: typography),
        maxWidth = 250,
        super.inherit();

  /// Returns a copy of this style with the given fields replaced by the new values.
  /// @useResult
  @override
  FPopoverMenuStyle copyWith({
    FTileGroupStyle? tileGroupStyle,
    BoxDecoration? decoration,
    EdgeInsets? padding,
  }) =>
      FPopoverMenuStyle(
        tileGroupStyle: tileGroupStyle ?? this.tileGroupStyle,
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle))
      ..add(DoubleProperty('maxWidth', maxWidth));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPopoverMenuStyle &&
          runtimeType == other.runtimeType &&
          tileGroupStyle == other.tileGroupStyle &&
          maxWidth == other.maxWidth &&
          decoration == other.decoration &&
          padding == other.padding;

  @override
  int get hashCode => tileGroupStyle.hashCode ^ maxWidth.hashCode ^ decoration.hashCode ^ padding.hashCode;
}
