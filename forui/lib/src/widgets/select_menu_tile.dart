// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_group/select_group_controller.dart';

/// A tile that, when triggered, displays a list of options for the user to pick from.
///
/// A [FSelectMenuTile] is internally a [FormField], therefore it can be used in a [Form].
///
/// For desktop, a [FSelectGroup] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/tile/select-menu-tile for working examples.
/// * [FSelectTile] for a single select tile.
/// * [FSelectMenuTileStyle] for customizing a select group's appearance.
class FSelectMenuTile<T> extends FormField<Set<T>> with FTileMixin {
  static Widget _errorBuilder(BuildContext context, String error) => Text(error);

  /// The controller that controls the selected tiles.
  final FSelectGroupController<T> groupController;

  /// The controller that shows and hides the menu. It initially hides the menu.
  final FPopoverController? popoverController;

  /// The style.
  final FSelectMenuTileStyle? style;

  /// The divider between select tiles. Defaults to [FTileDivider.indented].
  final FTileDivider divider;

  /// The anchor of the menu to which the [tileAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final Alignment menuAnchor;

  /// The anchor of the child to which the [menuAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final Alignment tileAnchor;

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

  /// True if the menu should be automatically hidden after a menu option is selected. Defaults to false.
  final bool autoHide;

  /// The label displayed next to the select group.
  final Widget? label;

  /// The description displayed below the group.
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  final Widget Function(BuildContext, String) errorBuilder;

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
  final List<FSelectTile<T>> menu;

  /// The prefix icon.
  final Widget? prefixIcon;

  /// The title.
  final Widget title;

  /// The subtitle.
  final Widget? subtitle;

  /// The details.
  final Widget? details;

  /// The suffix icon. Defaults to `FAssets.icons.chevronsUpDown`.
  final Widget? suffixIcon;

  /// Creates a [FSelectMenuTile].
  FSelectMenuTile({
    required this.groupController,
    required this.menu,
    required this.title,
    this.popoverController,
    this.style,
    this.divider = FTileDivider.full,
    this.menuAnchor = Alignment.topRight,
    this.tileAnchor = Alignment.bottomRight,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.ignoreDirectionalPadding = true,
    this.autoHide = false,
    this.label,
    this.description,
    this.errorBuilder = _errorBuilder,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.prefixIcon,
    this.subtitle,
    this.details,
    this.suffixIcon,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
          builder: (field) {
            final state = field as _State<T>;
            final groupData = FTileGroupData.maybeOf(state.context);
            final tileData = FTileData.maybeOf(state.context);

            final global = state.context.theme.selectMenuTileStyle;
            final labelStyle = style?.labelStyle ?? global.labelStyle;
            final menuStyle = style?.menuStyle ?? global.menuStyle;
            final tileStyle = style?.tileStyle ?? tileData?.style ?? groupData?.style.tileStyle ?? global.tileStyle;

            final (labelState, error) = switch (state.errorText) {
              _ when !enabled => (FLabelState.disabled, null),
              final text? => (FLabelState.error, errorBuilder(state.context, text)),
              null => (FLabelState.enabled, null),
            };

            Widget tile = FPopover(
              // A GlobalObjectKey is used to workaround Flutter not recognizing how widgets move inside the widget tree.
              //
              // OverlayPortalControllers are tied to a single _OverlayPortalState, and conditional rebuilds introduced
              // by FLabel and its internals can cause a new parent to be inserted above FPopover. This leads to the
              // entire widget subtree being rebuilt and losing their state. Consequently, the controller is assigned
              // another _OverlayPortalState, causing an assertion to be thrown.
              //
              // See https://stackoverflow.com/a/59410824/4189771
              key: GlobalObjectKey(state._controller._popover),
              controller: state._controller._popover,
              style: menuStyle,
              followerAnchor: menuAnchor,
              targetAnchor: tileAnchor,
              shift: shift,
              hideOnTapOutside: hideOnTapOutside,
              ignoreDirectionalPadding: ignoreDirectionalPadding,
              autofocus: autofocus,
              focusNode: focusNode,
              onFocusChange: onFocusChange,
              followerBuilder: (context, _, __) => ConstrainedBox(
                constraints: BoxConstraints(maxWidth: menuStyle.maxWidth),
                child: FSelectTileGroup<T>(
                  controller: state._controller,
                  style: menuStyle.tileGroupStyle,
                  semanticLabel: semanticLabel,
                  divider: divider,
                  children: menu,
                ),
              ),
              target: FTile(
                style: tileStyle,
                prefixIcon: prefixIcon,
                enabled: enabled,
                title: title,
                subtitle: subtitle,
                details: details,
                suffixIcon: suffixIcon ?? FIcon(FAssets.icons.chevronsUpDown),
                onPress: state._controller._popover.toggle,
              ),
            );

            if (groupData == null && tileData == null && (label != null || description != null || error != null)) {
              tile = FLabel(
                axis: Axis.vertical,
                style: labelStyle,
                state: labelState,
                label: label,
                description: description,
                error: error,
                child: tile,
              );
            }

            return tile;
          },
        );

  @override
  FormFieldState<Set<T>> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('groupController', groupController))
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DiagnosticsProperty('tileAnchor', tileAnchor))
      ..add(DiagnosticsProperty('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside, ifTrue: 'hideOnTapOutside'))
      ..add(
        FlagProperty(
          'ignoreDirectionalPadding',
          value: ignoreDirectionalPadding,
          ifTrue: 'ignoreDirectionalPadding',
        ),
      )
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _State<T> extends FormFieldState<Set<T>> with SingleTickerProviderStateMixin {
  late _SelectGroupController<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller = _SelectGroupController(
      widget.groupController,
      widget.popoverController ?? FPopoverController(vsync: this),
      autoHide: widget.autoHide,
    )..addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FSelectMenuTile<T> old) {
    super.didUpdateWidget(old);
    if (widget.popoverController != old.popoverController) {
      if (old.popoverController != null) {
        _controller._popover.dispose();
      }

      _controller._popover = widget.popoverController ?? FPopoverController(vsync: this);
    }

    if (widget.groupController != old.groupController) {
      _controller.delegate = widget.groupController;
    }

    _controller.autoHide = old.autoHide;
  }

  @override
  Future<void> didChange(Set<T>? values) async {
    super.didChange(values);
    if (!setEquals(_controller.values, values)) {
      _controller.values = values ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    _controller.values = widget.initialValue ?? {};
    super.reset();
  }

  @override
  void dispose() {
    widget.groupController.removeListener(_handleControllerChanged);
    if (widget.popoverController == null) {
      _controller._popover.dispose();
    }
    super.dispose();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (widget.groupController.values != value) {
      didChange(widget.groupController.values);
    }
  }

  @override
  FSelectMenuTile<T> get widget => super.widget as FSelectMenuTile<T>;
}

class _SelectGroupController<T> extends DelegateSelectGroupController<T> {
  FPopoverController _popover;
  bool autoHide;

  _SelectGroupController(super.delegate, this._popover, {required this.autoHide});

  @override
  Future<void> select(T value, bool selected) async {
    if (autoHide && _popover.shown) {
      await _popover.hide();
    }

    super.select(value, selected);
  }

  @override
  void dispose() {
    _popover.dispose();
    super.dispose();
  }
}

/// A [FSelectMenuTileStyle]'s style.
final class FSelectMenuTileStyle extends FLabelStateStyles with Diagnosticable {
  /// The group label's layout style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The menu's style.
  final FPopoverMenuStyle menuStyle;

  /// The tile's style.
  final FTileStyle tileStyle;

  /// Creates a [FSelectMenuTileStyle].
  FSelectMenuTileStyle({
    required this.labelLayoutStyle,
    required this.menuStyle,
    required this.tileStyle,
    required super.enabledStyle,
    required super.disabledStyle,
    required super.errorStyle,
  });

  /// Creates a [FSelectMenuTileStyle] that inherits its properties from [colorScheme], [style] and [typography].
  factory FSelectMenuTileStyle.inherit({
    required FColorScheme colorScheme,
    required FStyle style,
    required FTypography typography,
  }) {
    final groupStyle = FTileGroupStyle.inherit(colorScheme: colorScheme, style: style, typography: typography);
    return FSelectMenuTileStyle(
      labelLayoutStyle: groupStyle.labelLayoutStyle,
      menuStyle: FPopoverMenuStyle.inherit(colorScheme: colorScheme, style: style, typography: typography),
      tileStyle: groupStyle.tileStyle,
      enabledStyle: groupStyle.enabledStyle,
      disabledStyle: groupStyle.disabledStyle,
      errorStyle: groupStyle.errorStyle,
    );
  }

  /// Returns a copy of this [FTileStyle] with the given fields replaced with the new values.
  @useResult
  FSelectMenuTileStyle copyWith({
    FLabelLayoutStyle? labelLayoutStyle,
    FPopoverMenuStyle? menuStyle,
    FTileStyle? tileStyle,
    FFormFieldStyle? enabledStyle,
    FFormFieldStyle? disabledStyle,
    FFormFieldErrorStyle? errorStyle,
  }) =>
      FSelectMenuTileStyle(
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        menuStyle: menuStyle ?? this.menuStyle,
        tileStyle: tileStyle ?? this.tileStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  /// The label's style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (layout: labelLayoutStyle, state: this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('menuStyle', menuStyle))
      ..add(DiagnosticsProperty('tileStyle', tileStyle));
  }
}
