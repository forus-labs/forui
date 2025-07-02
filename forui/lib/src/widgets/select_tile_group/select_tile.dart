import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A tile that represents a selection in a [FSelectTileGroup]. It should only be used in a [FSelectTileGroup].
///
/// See:
/// * https://forui.dev/docs/tile/select-tile-group for working examples.
/// * [FSelectTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a select tile's appearance.
class FSelectTile<T> extends StatelessWidget with FItemMixin {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile
  /// ```
  final FItemStyle Function(FItemStyle)? style;

  /// The checked icon. Defaults to `FIcon(FIcons.check)`.
  final Widget? checkedIcon;

  /// The unchecked icon.
  final Widget? uncheckedIcon;

  /// The title.
  final Widget title;

  /// The subtitle below the title.
  final Widget? subtitle;

  /// The details on the right hand side of the title and subtitle.
  final Widget? details;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// The current value.
  final T value;

  /// Whether this radio tile is enabled. Defaults to true.
  final bool? enabled;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onHoverChange}
  final ValueChanged<bool>? onHoverChange;

  /// {@macro forui.foundation.FTappable.onStateChange}
  final ValueChanged<Set<WidgetState>>? onStatesChange;

  final Widget? _icon;

  final bool _suffix;

  /// Creates a [FSelectTile] with a prefix check icon.
  const FSelectTile({
    required this.title,
    required this.value,
    this.style,
    this.checkedIcon = const Icon(FIcons.check),
    this.uncheckedIcon = const Icon(FIcons.check, color: Colors.transparent),
    this.subtitle,
    this.details,
    this.semanticsLabel,
    this.enabled,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStatesChange,
    Widget? suffix,
    super.key,
  }) : _suffix = false,
       _icon = suffix;

  /// Creates a [FSelectTile] with a suffix check icon.
  const FSelectTile.suffix({
    required this.title,
    required this.value,
    this.style,
    this.checkedIcon = const Icon(FIcons.check),
    this.uncheckedIcon = const Icon(FIcons.check, color: Colors.transparent),
    this.subtitle,
    this.details,
    this.semanticsLabel,
    this.enabled,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStatesChange,
    Widget? prefix,
    super.key,
  }) : _icon = prefix,
       _suffix = true;

  @override
  Widget build(BuildContext context) {
    final FSelectTileData(:controller, :selected) = FSelectTileData.of<T>(context);
    return FTile(
      style: style,
      prefix: switch ((_suffix, selected)) {
        (true, _) => _icon,
        (false, true) => checkedIcon,
        (false, false) => uncheckedIcon,
      },
      title: title,
      subtitle: subtitle,
      details: details,
      suffix: switch ((_suffix, selected)) {
        (false, _) => _icon,
        (true, true) => checkedIcon,
        (true, false) => uncheckedIcon,
      },
      semanticsLabel: semanticsLabel,
      enabled: enabled,
      selected: selected,
      onPress: () => controller.update(value, add: !selected),
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onStateChange: onStatesChange,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStatesChange', onStatesChange));
  }
}

@internal
class FSelectTileData<T> extends InheritedWidget with FTileMixin {
  static FSelectTileData<T> of<T>(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FSelectTileData<T>>();
    assert(
      result != null,
      "No FSelectTileData found in context. This likely because FSelectTileGroup's type parameter could not be inferred. "
      'It is currently inferred as FSelectTileGroup<$T>. To fix this, provide the type parameter explicitly, i.e. '
      'FSelectTileGroup<MyType>.',
    );
    return result!;
  }

  final FSelectTileGroupController<T> controller;
  final bool selected;

  const FSelectTileData({required this.controller, required this.selected, required super.child, super.key});

  @override
  bool updateShouldNotify(FSelectTileData old) => controller != old.controller || selected != old.selected;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'));
  }
}
