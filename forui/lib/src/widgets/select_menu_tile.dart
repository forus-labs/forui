import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'select_menu_tile.design.dart';

/// A [FSelectMenuTile]'s controller.
typedef FSelectMenuTileController<T> = FMultiValueNotifier<T>;

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
class FSelectMenuTile<T> extends FormField<Set<T>> with FTileMixin, FFormFieldProperties<Set<T>> {
  static Widget _builder<T>(BuildContext _, Set<dynamic>? _, Widget? child) => child ?? const SizedBox();

  /// The controller that controls the selected tiles. Defaults to `FSelectMenuTileController.radio`.
  final FSelectMenuTileController<T>? selectController;

  /// The controller that shows and hides the menu. It initially hides the menu.
  final FPopoverController? popoverController;

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

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift;

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

  /// The callback that is called when the value changes.
  final ValueChanged<Set<T>>? onChange;

  /// The callback that is called when an item is selected.
  final ValueChanged<(T, bool)>? onSelect;

  /// Creates a [FSelectMenuTile] that eagerly builds the menu.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * both [selectController] and [initialValue] are provided.
  FSelectMenuTile({
    required this.title,
    required List<FSelectTile<T>> menu,
    this.selectController,
    this.popoverController,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = FItemDivider.full,
    this.menuAnchor = Alignment.topRight,
    this.tileAnchor = Alignment.bottomRight,
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
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
    this.detailsBuilder = _builder,
    this.details,
    this.suffix,
    this.shortcuts,
    this.actions,
    this.onChange,
    this.onSelect,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    T? initialValue,
    super.onSaved,
    super.onReset,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : assert(
         selectController == null || initialValue == null,
         'Cannot provide both selectController and initialValue',
       ),
       super(
         initialValue: {?initialValue, ...?selectController?.value},
         errorBuilder: errorBuilder,
         builder: (field) {
           final state = field as _State<T>;
           final data = FInheritedItemData.maybeOf(state.context);
           final inheritedStyle = FTileGroupStyleData.maybeOf(state.context);

           final global = state.context.theme.selectMenuTileStyle;
           final selectMenuTileStyle = style?.call(global);

           final menuStyle = selectMenuTileStyle?.menuStyle ?? global.menuStyle;
           final tileStyle = selectMenuTileStyle?.tileStyle ?? inheritedStyle?.tileStyle ?? global.tileStyle;

           Widget tile = FPopover(
             // A GlobalObjectKey is used to work around Flutter not recognizing how widgets move inside the widget tree.
             //
             // OverlayPortalControllers are tied to a single _OverlayPortalState, and conditional rebuilds introduced
             // by FLabel and its internals can cause a new parent to be inserted above FPopover. This leads to the
             // entire widget subtree being rebuilt and losing their states. Consequently, the controller is assigned
             // another _OverlayPortalState, causing an assertion to be thrown.
             //
             // See https://stackoverflow.com/a/59410824/4189771
             key: GlobalObjectKey(state._controller._popover),
             controller: state._controller._popover,
             style: menuStyle,
             popoverAnchor: menuAnchor,
             childAnchor: tileAnchor,
             spacing: spacing,
             shift: shift,
             offset: offset,
             hideRegion: hideRegion,
             onTapHide: onTapHide,
             autofocus: autofocus,
             focusNode: focusNode,
             onFocusChange: onFocusChange,
             traversalEdgeBehavior: traversalEdgeBehavior,
             barrierSemanticsLabel: barrierSemanticsLabel,
             barrierSemanticsDismissible: barrierSemanticsDismissible,
             popoverBuilder: (_, _) => ConstrainedBox(
               constraints: BoxConstraints(maxWidth: menuStyle.maxWidth),
               child: FInheritedItemData(
                 child: FSelectTileGroup<T>(
                   selectController: state._controller,
                   scrollController: scrollController,
                   cacheExtent: cacheExtent,
                   maxHeight: maxHeight,
                   dragStartBehavior: dragStartBehavior,
                   physics: physics,
                   style: menuStyle.tileGroupStyle,
                   semanticsLabel: semanticsLabel,
                   divider: divider,
                   children: menu,
                 ),
               ),
             ),
             child: FTile(
               style: tileStyle,
               prefix: prefix,
               enabled: enabled,
               title: title,
               subtitle: subtitle,
               details: ValueListenableBuilder(
                 valueListenable: state._controller.delegate,
                 builder: detailsBuilder,
                 child: details,
               ),
               suffix: suffix ?? const Icon(FIcons.chevronsUpDown),
               shortcuts: shortcuts,
               actions: actions,
               onPress: state._controller._popover.toggle,
             ),
           );

           if (data == null && (label != null || description != null || state.errorText != null)) {
             final states = {if (!enabled) WidgetState.disabled, if (state.errorText != null) WidgetState.error};
             final error = state.errorText == null ? null : errorBuilder(state.context, state.errorText!);

             tile = FLabel(
               axis: Axis.vertical,
               style: selectMenuTileStyle ?? global,
               states: states,
               label: label,
               description: description,
               error: error,
               child: tile,
             );
           }

           return tile;
         },
       );

  /// Creates a [FSelectMenuTile] with the given [menu].
  ///
  /// ## Contract
  /// Each key in [menu] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  ///
  /// Throws [AssertionError] if both [selectController] and [initialValue] are provided.
  factory FSelectMenuTile.fromMap(
    Map<String, T> menu, {
    required Text title,
    FSelectMenuTileController<T>? selectController,
    FPopoverController? popoverController,
    ScrollController? scrollController,
    FSelectMenuTileStyle Function(FSelectMenuTileStyle style)? style,
    double? cacheExtent,
    double maxHeight = double.infinity,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    FItemDivider divider = FItemDivider.full,
    AlignmentGeometry menuAnchor = Alignment.topRight,
    AlignmentGeometry tileAnchor = Alignment.bottomRight,
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FPopoverHideRegion hideRegion = FPopoverHideRegion.excludeChild,
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
    ValueWidgetBuilder<Set<T>> detailsBuilder = _builder,
    Widget? details,
    Widget? suffix,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    ValueChanged<Set<T>>? onChange,
    ValueChanged<(T, bool)>? onSelect,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    T? initialValue,
    FormFieldSetter<Set<T>>? onSaved,
    VoidCallback? onReset,
    FormFieldValidator<Set<T>>? validator,
    String? forceErrorText,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    Key? key,
  }) => FSelectMenuTile<T>(
    title: title,
    menu: [for (final MapEntry(:key, :value) in menu.entries) FSelectTile<T>(title: Text(key), value: value)],
    selectController: selectController,
    popoverController: popoverController,
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
    shift: shift,
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
    onChange: onChange,
    onSelect: onSelect,
    errorBuilder: errorBuilder,
    initialValue: initialValue,
    onSaved: onSaved,
    onReset: onReset,
    validator: validator,
    forceErrorText: forceErrorText,
    enabled: enabled,
    autovalidateMode: autovalidateMode,
    restorationId: restorationId,
    key: key,
  );

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
  /// ## Contract
  /// Throws [AssertionError] if both [selectController] and [initialValue] are provided.
  ///
  /// ## Warning
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e., [Column].
  /// * [count] is null and [menuBuilder] always provides a zero-size widget, i.e., SizedBox(). If possible, provide
  ///   tiles with non-zero size, return null from the builder, or set [count] to non-null.
  FSelectMenuTile.builder({
    required this.title,
    required FSelectTile<T>? Function(BuildContext context, int index) menuBuilder,
    int? count,
    this.selectController,
    this.popoverController,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = FItemDivider.full,
    this.menuAnchor = Alignment.topRight,
    this.tileAnchor = Alignment.bottomRight,
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
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
    this.detailsBuilder = _builder,
    this.details,
    this.suffix,
    this.shortcuts,
    this.actions,
    this.onChange,
    this.onSelect,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    T? initialValue,
    super.onSaved,
    super.onReset,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : assert(
         selectController == null || initialValue == null,
         'Cannot provide both selectController and initialValue',
       ),
       super(
         initialValue: {?initialValue, ...?selectController?.value},
         errorBuilder: errorBuilder,
         builder: (field) {
           final state = field as _State<T>;
           final data = FInheritedItemData.maybeOf(state.context);
           final inheritedStyle = FTileGroupStyleData.maybeOf(state.context);

           final global = state.context.theme.selectMenuTileStyle;
           final selectMenuTileStyle = style?.call(global);

           final menuStyle = selectMenuTileStyle?.menuStyle ?? global.menuStyle;
           final tileStyle = selectMenuTileStyle?.tileStyle ?? inheritedStyle?.tileStyle ?? global.tileStyle;

           Widget tile = FPopover(
             // A GlobalObjectKey is used to work around Flutter not recognizing how widgets move inside the widget tree.
             //
             // OverlayPortalControllers are tied to a single _OverlayPortalState, and conditional rebuilds introduced
             // by FLabel and its internals can cause a new parent to be inserted above FPopover. This leads to the
             // entire widget subtree being rebuilt and losing their states. Consequently, the controller is assigned
             // another _OverlayPortalState, causing an assertion to be thrown.
             //
             // See https://stackoverflow.com/a/59410824/4189771
             key: GlobalObjectKey(state._controller._popover),
             controller: state._controller._popover,
             style: menuStyle,
             constraints: FPortalConstraints(maxWidth: menuStyle.maxWidth),
             popoverAnchor: menuAnchor,
             childAnchor: tileAnchor,
             spacing: spacing,
             shift: shift,
             offset: offset,
             hideRegion: hideRegion,
             onTapHide: onTapHide,
             autofocus: autofocus,
             focusNode: focusNode,
             onFocusChange: onFocusChange,
             traversalEdgeBehavior: traversalEdgeBehavior,
             barrierSemanticsLabel: barrierSemanticsLabel,
             barrierSemanticsDismissible: barrierSemanticsDismissible,
             popoverBuilder: (_, _) => FSelectTileGroup<T>.builder(
               selectController: state._controller,
               scrollController: scrollController,
               cacheExtent: cacheExtent,
               maxHeight: maxHeight,
               dragStartBehavior: dragStartBehavior,
               physics: physics,
               style: menuStyle.tileGroupStyle,
               semanticsLabel: semanticsLabel,
               divider: divider,
               tileBuilder: menuBuilder,
               count: count,
             ),
             child: FTile(
               style: tileStyle,
               prefix: prefix,
               enabled: enabled,
               title: title,
               subtitle: subtitle,
               details: ValueListenableBuilder(
                 valueListenable: state._controller.delegate,
                 builder: detailsBuilder,
                 child: details,
               ),
               suffix: suffix ?? const Icon(FIcons.chevronsUpDown),
               shortcuts: shortcuts,
               actions: actions,
               onPress: state._controller._popover.toggle,
             ),
           );

           if (data == null && (label != null || description != null || state.errorText != null)) {
             final states = {if (!enabled) WidgetState.disabled, if (state.errorText != null) WidgetState.error};
             final error = state.errorText == null ? null : errorBuilder(state.context, state.errorText!);
             tile = FLabel(
               axis: Axis.vertical,
               style: global,
               states: states,
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
      ..add(DiagnosticsProperty('groupController', selectController))
      ..add(DiagnosticsProperty('popoverController', popoverController))
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
      ..add(ObjectFlagProperty.has('shift', shift))
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
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onSelect', onSelect))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions));
  }
}

class _State<T> extends FormFieldState<Set<T>> with SingleTickerProviderStateMixin {
  late _Notifier<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        _Notifier(
            widget.selectController ?? FSelectMenuTileController<T>.radio(widget.initialValue?.firstOrNull),
            widget.popoverController ?? FPopoverController(vsync: this),
            autoHide: widget.autoHide,
          )
          ..addListener(_handleControllerChanged)
          ..addValueListener(widget.onChange)
          ..addUpdateListener(widget.onSelect);
  }

  @override
  void didUpdateWidget(covariant FSelectMenuTile<T> old) {
    super.didUpdateWidget(old);
    _controller
      ..autoHide = old.autoHide
      ..removeListener(_handleControllerChanged)
      ..removeValueListener(old.onChange)
      ..removeUpdateListener(old.onSelect);

    if (widget.popoverController != old.popoverController) {
      if (old.popoverController == null) {
        _controller._popover.dispose();
      }

      _controller._popover = widget.popoverController ?? FPopoverController(vsync: this);
    }

    if (widget.selectController != old.selectController) {
      if (old.selectController == null) {
        _controller.delegate.dispose();
      } else {
        _controller.delegate.removeListener(_handleControllerChanged);
      }

      _controller.delegate =
          widget.selectController ?? FSelectMenuTileController<T>.radio(widget.initialValue?.firstOrNull);
    }

    _controller
      ..addListener(_handleControllerChanged)
      ..addValueListener(widget.onChange)
      ..addUpdateListener(widget.onSelect);
  }

  @override
  Future<void> didChange(Set<T>? value) async {
    super.didChange(value);
    if (!setEquals(_controller.value, value)) {
      _controller.value = value ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    _controller.value = widget.initialValue ?? {};
    super.reset();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..removeValueListener(widget.onChange)
      ..removeUpdateListener(widget.onSelect);

    if (widget.selectController == null) {
      _controller.delegate.dispose();
    }

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
    if (_controller.value != value) {
      didChange(_controller.value);
    }
  }

  @override
  FSelectMenuTile<T> get widget => super.widget as FSelectMenuTile<T>;
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
    return FSelectMenuTileStyle(
      menuStyle: FPopoverMenuStyle.inherit(colors: colors, style: style, typography: typography),
      tileStyle: FTileStyle.inherit(colors: colors, typography: typography, style: style),
      labelTextStyle: groupStyle.labelTextStyle,
      descriptionTextStyle: groupStyle.descriptionTextStyle,
      errorTextStyle: groupStyle.errorTextStyle,
      labelPadding: groupStyle.labelPadding,
      descriptionPadding: groupStyle.descriptionPadding,
      errorPadding: groupStyle.errorPadding,
    );
  }
}
