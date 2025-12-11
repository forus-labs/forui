import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form/multi_value_form_field.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart' as popover;
import 'package:forui/src/widgets/select_group/select_group_controller.dart' as select;

part 'select_menu_tile.design.dart';

@internal
Widget defaultSelectMenuTileBuilder<T>(BuildContext _, Set<dynamic>? _, Widget? child) => child ?? const SizedBox();

/// A tile that, when triggered, displays a list of options for the user to pick from.
///
/// A [FSelectMenuTile] is internally a [FormField], therefore it can be used in a [Form].
///
/// For desktop, an [FSelectGroup] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/tile/select-menu-tile for working examples.
/// * [FSelectTile] for a single select tile.
/// * [FSelectMenuTileStyle] for customizing a select menu tile's appearance.
class FSelectMenuTile<T> extends StatefulWidget with FTileMixin, FFormFieldProperties<Set<T>> {
  /// The control that manages the selected values.
  ///
  /// Defaults to a managed radio selection if not provided.
  final FSelectGroupControl<T>? selectControl;

  /// The control that manages the popover visibility.
  ///
  /// Defaults to [FPopoverControl.managed].
  final FPopoverControl popoverControl;

  /// The scroll controller used to control the position to which this menu is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behavior.
  final ScrollController? scrollController;

  /// The menu's cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  final double? cacheExtent;

  /// The menu's max height, in logical pixels. Defaults to infinity.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [maxHeight] is not positive.
  final double maxHeight;

  /// Determines the way that the menu's drag start behavior is handled. Defaults to [DragStartBehavior.start].
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.widgets.FTileGroup.physics}
  final ScrollPhysics physics;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-menu-tile
  /// ```
  final FSelectMenuTileStyle Function(FSelectMenuTileStyle style)? style;

  /// The divider between select tiles. Defaults to [FItemDivider.indented].
  final FItemDivider divider;

  /// The point on the menu (floating content) that connects with the tile at the tile's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the menu will connect with the tile.
  /// See [tileAnchor] for changing the tile's anchor.
  ///
  /// Defaults to [Alignment.topRight].
  final AlignmentGeometry menuAnchor;

  /// The point on the tile that connects with the menu at the menu's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the tile will connect with the menu.
  /// See [menuAnchor] for changing the menu's anchor.
  ///
  /// Defaults to [Alignment.bottomRight].
  final AlignmentGeometry tileAnchor;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow overflow;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.hideRegion}
  final FPopoverHideRegion hideRegion;

  /// {@macro forui.widgets.FPopover.onTapHide}
  final VoidCallback? onTapHide;

  /// True if the menu should be automatically hidden after a menu option is selected. Defaults to true.
  final bool autoHide;

  @override
  final Widget? label;

  @override
  final Widget? description;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.widgets.FPopover.traversalEdgeBehavior}
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@macro forui.widgets.FPopover.barrierSemanticsLabel}
  final String? barrierSemanticsLabel;

  /// {@macro forui.widgets.FPopover.barrierSemanticsDismissible}
  final bool barrierSemanticsDismissible;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// The prefix.
  final Widget? prefix;

  /// The title.
  final Widget title;

  /// The subtitle.
  final Widget? subtitle;

  /// An optional builder which returns the details.
  ///
  /// Can incorporate a value-independent widget subtree from the [details] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [detailsBuilder] builds doest not require the values.
  final ValueWidgetBuilder<Set<T>> detailsBuilder;

  /// The details.
  final Widget? details;

  /// The suffix. Defaults to `Icon(FIcons.chevronsUpDown)`.
  final Widget? suffix;

  /// The shortcuts. Defaults to calling [ActivateIntent].
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The actions. Defaults to selecting a tile when [ActivateIntent] is invoked.
  final Map<Type, Action<Intent>>? actions;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.FFormFieldProperties.onSaved}
  @override
  final FormFieldSetter<Set<T>>? onSaved;

  /// {@macro forui.foundation.FFormFieldProperties.onReset}
  @override
  final VoidCallback? onReset;

  /// {@macro forui.foundation.FFormFieldProperties.validator}
  @override
  final FormFieldValidator<Set<T>>? validator;

  /// {@macro forui.foundation.FFormFieldProperties.forceErrorText}
  @override
  final String? forceErrorText;

  /// Whether the form field is enabled. Defaults to true.
  @override
  final bool enabled;

  /// {@macro flutter.widgets.FormField.autovalidateMode}
  @override
  final AutovalidateMode autovalidateMode;

  final List<FSelectTile<T>>? _menu;
  final FSelectTile<T>? Function(BuildContext context, int index)? _menuBuilder;
  final int? _count;

  /// {@template forui.widgets.FSelectMenuTile.new}
  /// Creates a [FSelectMenuTile] that eagerly builds the menu.
  /// {@endtemplate}
  FSelectMenuTile({
    required this.title,
    required List<FSelectTile<T>> menu,
    this.selectControl,
    this.popoverControl = const .managed(),
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = .full,
    this.menuAnchor = .topRight,
    this.tileAnchor = .bottomRight,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.autoHide = true,
    this.label,
    this.description,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.semanticsLabel,
    this.prefix,
    this.subtitle,
    this.detailsBuilder = defaultSelectMenuTileBuilder,
    this.details,
    this.suffix,
    this.shortcuts,
    this.actions,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = .disabled,
    super.key,
  }) : _menu = menu,
       _menuBuilder = null,
       _count = null;

  /// {@template forui.widgets.FSelectMenuTile.fromMap}
  /// Creates a [FSelectMenuTile] with the given [menu].
  ///
  /// ## Contract
  /// Each key in [menu] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  /// {@endtemplate}
  factory FSelectMenuTile.fromMap(
    Map<String, T> menu, {
    required Text title,
    FSelectGroupControl<T>? selectControl,
    FPopoverControl popoverControl = const .managed(),
    ScrollController? scrollController,
    FSelectMenuTileStyle Function(FSelectMenuTileStyle style)? style,
    double? cacheExtent,
    double maxHeight = .infinity,
    DragStartBehavior dragStartBehavior = .start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    FItemDivider divider = .full,
    AlignmentGeometry menuAnchor = .topRight,
    AlignmentGeometry tileAnchor = .bottomRight,
    FPortalSpacing spacing = const .spacing(4),
    FPortalOverflow overflow = .flip,
    Offset offset = .zero,
    FPopoverHideRegion hideRegion = .excludeChild,
    VoidCallback? onTapHide,
    bool autoHide = true,
    Widget? label,
    Widget? description,
    bool autofocus = false,
    FocusScopeNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    TraversalEdgeBehavior? traversalEdgeBehavior,
    String? barrierSemanticsLabel,
    bool barrierSemanticsDismissible = true,
    String? semanticsLabel,
    Widget? prefix,
    Widget? subtitle,
    ValueWidgetBuilder<Set<T>> detailsBuilder = defaultSelectMenuTileBuilder,
    Widget? details,
    Widget? suffix,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    FormFieldSetter<Set<T>>? onSaved,
    VoidCallback? onReset,
    FormFieldValidator<Set<T>>? validator,
    String? forceErrorText,
    bool enabled = true,
    AutovalidateMode autovalidateMode = .disabled,
    Key? key,
  }) => .new(
    title: title,
    menu: [for (final MapEntry(:key, :value) in menu.entries) FSelectTile<T>(title: Text(key), value: value)],
    selectControl: selectControl,
    popoverControl: popoverControl,
    scrollController: scrollController,
    style: style,
    cacheExtent: cacheExtent,
    maxHeight: maxHeight,
    dragStartBehavior: dragStartBehavior,
    physics: physics,
    divider: divider,
    menuAnchor: menuAnchor,
    tileAnchor: tileAnchor,
    spacing: spacing,
    overflow: overflow,
    offset: offset,
    hideRegion: hideRegion,
    onTapHide: onTapHide,
    autoHide: autoHide,
    label: label,
    description: description,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    traversalEdgeBehavior: traversalEdgeBehavior,
    barrierSemanticsLabel: barrierSemanticsLabel,
    barrierSemanticsDismissible: barrierSemanticsDismissible,
    semanticsLabel: semanticsLabel,
    prefix: prefix,
    subtitle: subtitle,
    detailsBuilder: detailsBuilder,
    details: details,
    suffix: suffix,
    shortcuts: shortcuts,
    actions: actions,
    errorBuilder: errorBuilder,
    onSaved: onSaved,
    onReset: onReset,
    validator: validator,
    forceErrorText: forceErrorText,
    enabled: enabled,
    autovalidateMode: autovalidateMode,
    key: key,
  );

  /// {@template forui.widgets.FSelectMenuTile.builder}
  /// Creates a [FSelectMenuTile] that lazily builds the menu.
  ///
  /// The [menuBuilder] is called for each tile that should be built. The current level's [FInheritedItemData] is **not**
  /// visible to `menuBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of tiles to build. If null, [menuBuilder] will be called until it returns null.
  ///
  /// ## Warning
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e., [Column].
  /// * [count] is null and [menuBuilder] always provides a zero-size widget, i.e., SizedBox(). If possible, provide
  ///   tiles with non-zero size, return null from the builder, or set [count] to non-null.
  /// {@endtemplate}
  FSelectMenuTile.builder({
    required this.title,
    required FSelectTile<T>? Function(BuildContext context, int index) menuBuilder,
    int? count,
    this.selectControl,
    this.popoverControl = const .managed(),
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = .full,
    this.menuAnchor = .topRight,
    this.tileAnchor = .bottomRight,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.autoHide = true,
    this.label,
    this.description,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.semanticsLabel,
    this.prefix,
    this.subtitle,
    this.detailsBuilder = defaultSelectMenuTileBuilder,
    this.details,
    this.suffix,
    this.shortcuts,
    this.actions,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = .disabled,
    super.key,
  }) : _menu = null,
       _menuBuilder = menuBuilder,
       _count = count;

  @override
  State<FSelectMenuTile<T>> createState() => _FSelectMenuTileState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectControl', selectControl))
      ..add(DiagnosticsProperty('popoverControl', popoverControl))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DiagnosticsProperty('tileAnchor', tileAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('barrierSemanticsLabel', barrierSemanticsLabel))
      ..add(
        FlagProperty(
          'barrierSemanticsDismissible',
          value: barrierSemanticsDismissible,
          ifTrue: 'barrier semantics dismissible',
        ),
      )
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(ObjectFlagProperty.has('detailsBuilder', detailsBuilder))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode));
  }
}

class _FSelectMenuTileState<T> extends State<FSelectMenuTile<T>> with TickerProviderStateMixin {
  late _Notifier<T> _controller;

  @override
  void initState() {
    super.initState();
    final selectController = (widget.selectControl ?? FSelectGroupControl<T>.managed()).create(_handleChange);
    final popoverController = widget.popoverControl.create(_handlePopoverChange, this);
    _controller = _Notifier(selectController, popoverController, autoHide: widget.autoHide);
  }

  @override
  void didUpdateWidget(covariant FSelectMenuTile<T> old) {
    super.didUpdateWidget(old);
    _controller.autoHide = widget.autoHide;

    final selectControl = widget.selectControl ?? FSelectGroupControl<T>.managed();
    final oldSelectControl = old.selectControl ?? FSelectGroupControl<T>.managed();
    _controller
      ..delegate = selectControl.update(oldSelectControl, _controller.delegate, _handleChange).$1
      .._popover = widget.popoverControl
          .update(old.popoverControl, _controller._popover, _handlePopoverChange, this)
          .$1;
  }

  @override
  void dispose() {
    widget.popoverControl.dispose(_controller._popover, _handlePopoverChange);
    (widget.selectControl ?? FSelectGroupControl<T>.managed()).dispose(_controller.delegate, _handleChange);
    super.dispose();
  }

  void _handleChange() {
    if (widget.selectControl case select.Managed(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _handlePopoverChange() {
    if (widget.popoverControl case popover.Managed(:final onChange?)) {
      onChange(_controller._popover.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = FInheritedItemData.maybeOf(context);
    final inheritedStyle = FTileGroupStyleData.maybeOf(context);

    final global = context.theme.selectMenuTileStyle;
    final selectMenuTileStyle = widget.style?.call(global);

    final menuStyle = selectMenuTileStyle?.menuStyle ?? global.menuStyle;
    final tileStyle = selectMenuTileStyle?.tileStyle ?? inheritedStyle?.tileStyle ?? global.tileStyle;

    return MultiValueFormField<T>(
      controller: _controller,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      forceErrorText: widget.forceErrorText,
      autovalidateMode: widget.autovalidateMode,
      builder: (state) {
        Widget tile = FPopover(
          // A GlobalObjectKey is used to work around Flutter not recognizing how widgets move inside the widget tree.
          //
          // OverlayPortalControllers are tied to a single _OverlayPortalState, and conditional rebuilds introduced
          // by FLabel and its internals can cause a new parent to be inserted above FPopover. This leads to the
          // entire widget subtree being rebuilt and losing their states. Consequently, the controller is assigned
          // another _OverlayPortalState, causing an assertion to be thrown.
          //
          // See https://stackoverflow.com/a/59410824/4189771
          key: GlobalObjectKey(_controller._popover),
          control: .managed(controller: _controller._popover),
          style: menuStyle,
          constraints: FPortalConstraints(maxWidth: menuStyle.maxWidth),
          popoverAnchor: widget.menuAnchor,
          childAnchor: widget.tileAnchor,
          spacing: widget.spacing,
          overflow: widget.overflow,
          offset: widget.offset,
          hideRegion: widget.hideRegion,
          onTapHide: widget.onTapHide,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          onFocusChange: widget.onFocusChange,
          traversalEdgeBehavior: widget.traversalEdgeBehavior,
          barrierSemanticsLabel: widget.barrierSemanticsLabel,
          barrierSemanticsDismissible: widget.barrierSemanticsDismissible,
          popoverBuilder: (_, _) {
            if (widget._menu case final menu?) {
              return FInheritedItemData(
                child: FSelectTileGroup<T>(
                  control: .managed(controller: _controller),
                  scrollController: widget.scrollController,
                  cacheExtent: widget.cacheExtent,
                  maxHeight: widget.maxHeight,
                  dragStartBehavior: widget.dragStartBehavior,
                  physics: widget.physics,
                  style: menuStyle.tileGroupStyle,
                  semanticsLabel: widget.semanticsLabel,
                  divider: widget.divider,
                  children: menu,
                ),
              );
            }

            return FSelectTileGroup<T>.builder(
              control: .managed(controller: _controller),
              scrollController: widget.scrollController,
              cacheExtent: widget.cacheExtent,
              maxHeight: widget.maxHeight,
              dragStartBehavior: widget.dragStartBehavior,
              physics: widget.physics,
              style: menuStyle.tileGroupStyle,
              semanticsLabel: widget.semanticsLabel,
              divider: widget.divider,
              tileBuilder: widget._menuBuilder!,
              count: widget._count,
            );
          },
          child: FTile(
            style: tileStyle,
            prefix: widget.prefix,
            enabled: widget.enabled,
            title: widget.title,
            subtitle: widget.subtitle,
            details: ValueListenableBuilder(
              valueListenable: _controller.delegate,
              builder: widget.detailsBuilder,
              child: widget.details,
            ),
            suffix: widget.suffix ?? const Icon(FIcons.chevronsUpDown),
            shortcuts: widget.shortcuts,
            actions: widget.actions,
            onPress: _controller._popover.toggle,
          ),
        );

        if (data == null && (widget.label != null || widget.description != null || state.errorText != null)) {
          final states = {if (!widget.enabled) WidgetState.disabled, if (state.errorText != null) WidgetState.error};
          final error = state.errorText == null ? null : widget.errorBuilder(context, state.errorText!);

          tile = FLabel(
            axis: .vertical,
            style: selectMenuTileStyle ?? global,
            states: states,
            label: widget.label,
            description: widget.description,
            error: error,
            child: tile,
          );
        }

        return tile;
      },
    );
  }
}

class _Notifier<T> implements FMultiValueNotifier<T> {
  FMultiValueNotifier<T> delegate;
  FPopoverController _popover;
  bool autoHide;

  _Notifier(this.delegate, this._popover, {required this.autoHide});

  @override
  bool contains(T value) => delegate.contains(value);

  @override
  Future<void> update(T value, {required bool add}) async {
    if (autoHide && _popover.status.isForwardOrCompleted) {
      await _popover.hide();
    }

    delegate.update(value, add: add);
  }

  @override
  void dispose() => throw UnimplementedError('Cannot dispose a _Notifier, dispose the fields individually instead.');

  @override
  void addListener(VoidCallback listener) => delegate.addListener(listener);

  @override
  void addValueListener(ValueChanged<Set<T>>? listener) => delegate.addValueListener(listener);

  @override
  void addUpdateListener(ValueChanged<(T, bool)>? listener) => delegate.addUpdateListener(listener);

  @override
  void removeListener(VoidCallback listener) => delegate.removeListener(listener);

  @override
  void removeValueListener(ValueChanged<Set<T>>? listener) => delegate.removeValueListener(listener);

  @override
  void removeUpdateListener(ValueChanged<(T, bool)>? listener) => delegate.removeUpdateListener(listener);

  @override
  void notifyListeners() => delegate.notifyListeners();

  @override
  void notifyUpdateListeners(T value, {required bool add}) => delegate.notifyUpdateListeners(value, add: add);

  @override
  Set<T> get value => delegate.value;

  @override
  set value(Set<T> values) => delegate.value = values;

  @override
  bool get disposed => delegate.disposed;

  @override
  bool get hasListeners => delegate.hasListeners;
}

/// A select menu tile's style.
class FSelectMenuTileStyle extends FLabelStyle with _$FSelectMenuTileStyleFunctions {
  /// The menu's style.
  @override
  final FPopoverMenuStyle menuStyle;

  /// The tile's style.
  @override
  final FTileStyle tileStyle;

  /// Creates a [FSelectMenuTileStyle].
  FSelectMenuTileStyle({
    required this.menuStyle,
    required this.tileStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FSelectMenuTileStyle] that inherits its properties.
  factory FSelectMenuTileStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final groupStyle = FTileGroupStyle.inherit(colors: colors, style: style, typography: typography);
    return .new(
      menuStyle: .inherit(colors: colors, style: style, typography: typography),
      tileStyle: .inherit(colors: colors, typography: typography, style: style),
      labelTextStyle: groupStyle.labelTextStyle,
      descriptionTextStyle: groupStyle.descriptionTextStyle,
      errorTextStyle: groupStyle.errorTextStyle,
      labelPadding: groupStyle.labelPadding,
      descriptionPadding: groupStyle.descriptionPadding,
      errorPadding: groupStyle.errorPadding,
    );
  }
}
