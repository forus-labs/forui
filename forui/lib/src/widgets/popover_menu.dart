import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'popover_menu.style.dart';

/// A popover menu displays a menu in a portal aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover-menu for working examples.
/// * [FPopoverController] for controlling a popover menu.
/// * [FPopoverMenuStyle] for customizing a popover menu's appearance.
/// * [FTileGroup] for customizing the items in the menu.
class FPopoverMenu extends StatefulWidget {
  /// The popover menu's style.
  final FPopoverMenuStyle? style;

  /// The controller that shows and hides the menu. It initially hides the menu.
  final FPopoverController? popoverController;

  /// {@macro forui.widgets.FTileGroup.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.widgets.FTileGroup.cacheExtent}
  final double? cacheExtent;

  /// {@macro forui.widgets.FTileGroup.maxHeight}
  final double maxHeight;

  /// {@macro forui.widgets.FTileGroup.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.widgets.FTileGroup.divider}
  ///
  /// Defaults to [FTileDivider.full].
  final FTileDivider divider;

  /// The point on the menu (floating content) that connects with the child at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the menu will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry menuAnchor;

  /// The point on the child that connects with the menu at the menu's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the menu.
  /// See [menuAnchor] for changing the menu's anchor.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@macro forui.widgets.FPopover.hideOnTapOutside}
  final FHidePopoverRegion hideOnTapOutside;

  /// {@macro forui.widgets.FPopover.directionPadding}
  final bool directionPadding;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.widgets.FPopover.traversalEdgeBehavior}
  final TraversalEdgeBehavior traversalEdgeBehavior;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

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
    this.menuAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.anywhere,
    this.directionPadding = false,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior = TraversalEdgeBehavior.closedLoop,
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
    this.menuAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior = TraversalEdgeBehavior.closedLoop,
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
      ..add(DiagnosticsProperty('popoverAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior));
  }
}

class _FPopoverMenuState extends State<FPopoverMenu> with SingleTickerProviderStateMixin {
  late FPopoverController _popoverController = widget.popoverController ?? FPopoverController(vsync: this);

  @override
  void didUpdateWidget(covariant FPopoverMenu old) {
    super.didUpdateWidget(old);
    if (widget.popoverController != old.popoverController) {
      if (old.popoverController == null) {
        _popoverController.dispose();
      }
      _popoverController = widget.popoverController ?? FPopoverController(vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverMenuStyle;
    return (widget._automatic ? FPopover.automatic : FPopover.new)(
      controller: _popoverController,
      style: style,
      popoverAnchor: widget.menuAnchor,
      childAnchor: widget.childAnchor,
      shift: widget.shift,
      hideOnTapOutside: widget.hideOnTapOutside,
      directionPadding: widget.directionPadding,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      traversalEdgeBehavior: widget.traversalEdgeBehavior,
      popoverBuilder:
          (_, _, _) => ConstrainedBox(
            constraints: BoxConstraints(maxWidth: style.maxWidth),
            child: FTileGroup.merge(
              scrollController: widget.scrollController,
              cacheExtent: widget.cacheExtent,
              maxHeight: widget.maxHeight,
              dragStartBehavior: widget.dragStartBehavior,
              semanticsLabel: widget.semanticsLabel,
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
      _popoverController.dispose();
    }
    super.dispose();
  }
}

/// A [FPopoverMenuStyle]'s style.
final class FPopoverMenuStyle extends FPopoverStyle with _$FPopoverMenuStyleFunctions {
  /// The tile group's style.
  @override
  final FTileGroupStyle tileGroupStyle;

  /// The menu's max width. Defaults to 250.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the width is not positive.
  @override
  final double maxWidth;

  /// Creates a [FPopoverMenuStyle].
  const FPopoverMenuStyle({required this.tileGroupStyle, required super.decoration, this.maxWidth = 250, super.padding})
    : assert(0 < maxWidth, 'maxWidth must be positive');

  /// Creates a [FPopoverMenuStyle] that inherits its properties.
  FPopoverMenuStyle.inherit({required super.colors, required super.style, required FTypography typography})
    : tileGroupStyle = FTileGroupStyle.inherit(colors: colors, style: style, typography: typography),
      maxWidth = 250,
      super.inherit();
}
