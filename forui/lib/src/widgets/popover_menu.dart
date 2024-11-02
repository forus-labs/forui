import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A popover menu displays a menu in a portal aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover-menu for working examples.
/// * [FPopoverController] for controlling a popover menu.
/// * [FPopoverMenuStyle] for customizing a popover menu's appearance.
/// * [FTileGroup] for customizing the items in the menu.
class FPopoverMenu extends StatefulWidget {
  /// The controller that shows and hides the menu. It initially hides the menu.
  final FPopoverController? controller;

  /// The popover menu's style.
  final FPopoverMenuStyle? style;

  /// The divider between tile groups. Defaults to [FTileDivider.full].
  final FTileDivider divider;

  /// The anchor of the menu to which the [childAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final Alignment menuAnchor;

  /// The anchor of the child to which the [menuAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final Alignment childAnchor;

  /// The shifting strategy used to shift a menu when it overflows out of the viewport. Defaults to
  /// [FPortalFollowerShift.flip].
  ///
  /// See [FPortalFollowerShift] for more information on the different shifting strategies.
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  /// True if the popover is hidden when tapped outside of it. Defaults to true.
  final bool hideOnTapOutside;

  /// True if the menu should ignore the cross-axis padding of the anchor when aligning to it. Defaults to true.
  ///
  /// Diagonal corners are ignored.
  final bool ignoreDirectionalPadding;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// True if the menu will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Defaults to false.
  ///
  /// Ideally, there is only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  final bool autofocus;

  /// An optional focus node to use as the focus node for the menu.
  ///
  /// If one is not supplied, then one will be automatically allocated, owned, and managed by the menu. The menu
  /// will be focusable even if a [focusNode] is not supplied. If supplied, the given `focusNode` will be hosted by the
  /// menu but not owned. See [FocusNode] for more information on what being hosted and/or owned implies.
  ///
  /// Supplying a focus node is sometimes useful if an ancestor to the menu wants to control when the menu has
  /// the focus. The owner will be responsible for calling [FocusNode.dispose] on the focus node when it is done with
  /// it, but the menu will attach/detach and reparent the node when needed.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if the menu's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// The menu.
  final List<FTileGroupMixin<FTileMixin>> menu;

  /// The child.
  final Widget child;

  final bool _tappable;

  /// Creates a menu that only shows the menu when the controller is manually toggled.
  const FPopoverMenu({
    required this.controller,
    required this.menu,
    required this.child,
    this.style,
    this.divider = FTileDivider.full,
    this.menuAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.ignoreDirectionalPadding = true,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : _tappable = false;

  /// Creates a menu that is automatically shown when the [child] is tapped.
  ///
  /// It is not recommended for the [child] to contain a [GestureDetector], such as [FButton]. This is because only
  /// one `GestureDetector` will be called if there are multiple overlapping `GestureDetector`s.
  const FPopoverMenu.tappable({
    required this.menu,
    required this.child,
    this.controller,
    this.style,
    this.divider = FTileDivider.full,
    this.menuAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.ignoreDirectionalPadding = true,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  }) : _tappable = true;

  @override
  State<FPopoverMenu> createState() => _FPopoverMenuState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside, ifTrue: 'hideOnTapOutside'))
      ..add(
        FlagProperty(
          'ignoreDirectionalPadding',
          value: ignoreDirectionalPadding,
          ifTrue: 'ignoreDirectionalPadding',
        ),
      )
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
    _controller = widget.controller ?? FPopoverController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant FPopoverMenu old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    if (old.controller != null) {
      _controller.dispose();
    }
    _controller = widget.controller ?? FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverMenuStyle;
    return (widget._tappable ? FPopover.tappable : FPopover.new)(
      controller: _controller,
      style: style,
      followerAnchor: widget.menuAnchor,
      targetAnchor: widget.childAnchor,
      shift: widget.shift,
      hideOnTapOutside: widget.hideOnTapOutside,
      ignoreDirectionalPadding: widget.ignoreDirectionalPadding,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      followerBuilder: (context, _, __) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: style.maxWidth),
        child: FTileGroup.merge(
          semanticLabel: widget.semanticLabel,
          style: style.tileGroupStyle,
          divider: widget.divider,
          children: widget.menu,
        ),
      ),
      target: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// A [FPopoverMenuStyle]'s style.
final class FPopoverMenuStyle extends FPopoverStyle {
  /// The popover's default shadow in [FPopoverMenuStyle.inherit].
  static const shadow = [
    BoxShadow(
      color: Color(0x0d000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

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
  FPopoverMenuStyle.inherit({required FColorScheme colorScheme, required FStyle style, required FTypography typography})
      : this(
          tileGroupStyle: FTileGroupStyle.inherit(colorScheme: colorScheme, style: style, typography: typography),
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
            border: Border.all(
              width: style.borderWidth,
              color: colorScheme.border,
            ),
            boxShadow: shadow,
          ),
        );

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
