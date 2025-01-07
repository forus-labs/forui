// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_group/select_group_controller.dart';
import 'package:meta/meta.dart';

/// A select menu tile's popover properties.
class FSelectMenuTilePopoverProperties extends FPopoverProperties {
  /// The controller that shows and hides the menu. It initially hides the menu.
  final FPopoverController? controller;

  /// True if the menu should be automatically hidden after a menu option is selected. Defaults to false.
  final bool autoHide;

  /// Creates a [FSelectMenuTilePopoverProperties].
  const FSelectMenuTilePopoverProperties({
    this.controller,
    this.autoHide = false,
    super.popoverAnchor = Alignment.topRight,
    super.childAnchor = Alignment.bottomRight,
    super.shift,
    super.hideOnTapOutside,
    super.directionPadding,
    super.autofocus,
    super.focusNode,
    super.onFocusChange,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(FlagProperty('autoHide', value: autoHide));
  }
}

/// A select menu tile's popover properties.
class FSelectMenuTileMenuProperties extends FTileGroupProperties {
  /// Creates a [FSelectMenuTileMenuProperties].
  const FSelectMenuTileMenuProperties({
    super.scrollController,
    super.cacheExtent,
    super.maxHeight = double.infinity,
    super.dragStartBehavior = DragStartBehavior.start,
    super.divider = FTileDivider.full,
  });
}

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
class FSelectMenuTile<T> extends FormField<Set<T>> with FTileMixin implements FFormFieldProperties<Set<T>> {
  /// The controller that controls the selected tiles.
  final FSelectGroupController<T> controller;

  /// The style.
  final FSelectMenuTileStyle? style;

  /// The popover's properties.
  final FSelectMenuTilePopoverProperties popover;

  /// The menu's properties.
  final FSelectMenuTileMenuProperties menu;

  @override
  final Widget? label;

  @override
  final Widget? description;

  @override
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticLabel;

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
    required this.controller,
    required this.title,
    required List<FSelectTile<T>> menuTiles,
    this.popover = const FSelectMenuTilePopoverProperties(),
    this.menu = const FSelectMenuTileMenuProperties(),
    this.style,
    this.label,
    this.description,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.semanticLabel,
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

            Widget tile = FPopover.fromProperties(
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
              automatic: false,
              semanticLabel: null,
              properties: popover,
              popoverBuilder: (context, _, __) => ConstrainedBox(
                constraints: BoxConstraints(maxWidth: menuStyle.maxWidth),
                child: FSelectTileGroup<T>(
                  groupController: state._controller,
                  scrollController: menu.scrollController,
                  cacheExtent: menu.cacheExtent,
                  maxHeight: menu.maxHeight,
                  dragStartBehavior: menu.dragStartBehavior,
                  style: menuStyle.tileGroupStyle,
                  semanticLabel: semanticLabel,
                  divider: menu.divider,
                  children: menuTiles,
                ),
              ),
              child: FTile(
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

  /// Creates a [FSelectMenuTile] that lazily builds the menu.
  ///
  /// The [menuTileBuilder] is called for each tile that should be built. [FTileData] is **not** visible to
  /// `menuTileBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of tiles to build. If null, [menuTileBuilder] will be called until it returns null.
  ///
  /// ## Notes
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e. [Column].
  /// * [count] is null and [menuTileBuilder] always provides a zero-size widget, i.e. SizedBox(). If possible, provide
  ///   tiles with non-zero size, return null from builder, or set [count] to non-null.
  FSelectMenuTile.builder({
    required this.controller,
    required this.title,
    required FSelectTile<T>? Function(BuildContext, int) menuTileBuilder,
    this.popover = const FSelectMenuTilePopoverProperties(),
    this.menu = const FSelectMenuTileMenuProperties(),
    int? count,
    this.style,
    this.label,
    this.description,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.semanticLabel,
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

            Widget tile = FPopover.fromProperties(
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
              automatic: false,
              semanticLabel: null,
              properties: popover,
              popoverBuilder: (context, _, __) => ConstrainedBox(
                constraints: BoxConstraints(maxWidth: menuStyle.maxWidth),
                child: FSelectTileGroup<T>.builder(
                  groupController: state._controller,
                  scrollController: menu.scrollController,
                  cacheExtent: menu.cacheExtent,
                  maxHeight: menu.maxHeight,
                  dragStartBehavior: menu.dragStartBehavior,
                  style: menuStyle.tileGroupStyle,
                  semanticLabel: semanticLabel,
                  divider: menu.divider,
                  tileBuilder: menuTileBuilder,
                  count: count,
                ),
              ),
              child: FTile(
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
      ..add(DiagnosticsProperty('groupController', controller))
      ..add(DiagnosticsProperty('popover', popover))
      ..add(DiagnosticsProperty('menu', menu))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _State<T> extends FormFieldState<Set<T>> with SingleTickerProviderStateMixin {
  late _SelectGroupController<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller = _SelectGroupController(
      widget.controller,
      widget.popover.controller ?? FPopoverController(vsync: this),
      autoHide: widget.popover.autoHide,
    )..addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FSelectMenuTile<T> old) {
    super.didUpdateWidget(old);
    if (widget.popover.controller != old.popover.controller) {
      if (old.popover.controller != null) {
        _controller._popover.dispose();
      }

      _controller._popover = widget.popover.controller ?? FPopoverController(vsync: this);
    }

    if (widget.controller != old.controller) {
      _controller.delegate = widget.controller;
    }

    _controller.autoHide = old.popover.autoHide;
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
    widget.controller.removeListener(_handleControllerChanged);
    if (widget.popover.controller == null) {
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
    if (widget.controller.values != value) {
      didChange(widget.controller.values);
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
  @override
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FSelectMenuTileStyle &&
          runtimeType == other.runtimeType &&
          labelLayoutStyle == other.labelLayoutStyle &&
          menuStyle == other.menuStyle &&
          tileStyle == other.tileStyle;

  @override
  int get hashCode => super.hashCode ^ labelLayoutStyle.hashCode ^ menuStyle.hashCode ^ tileStyle.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('menuStyle', menuStyle))
      ..add(DiagnosticsProperty('tileStyle', tileStyle));
  }
}
