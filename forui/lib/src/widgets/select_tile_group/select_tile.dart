import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A tile that represents a selection in a [FSelectTileGroup]. It should only be used in a [FSelectTileGroup].
///
/// See:
/// * https://forui.dev/docs/tile/select-tile for working examples.
/// * [FSelectTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a select tile's appearance.
class FSelectTile<T> extends StatelessWidget with FTileMixin {
  /// The style.
  final FTileStyle? style;

  /// The checked icon. Defaults to `FIcon(FAssets.icons.check)`.
  final Widget? checkedIcon;

  /// The unchecked icon.
  final Widget? uncheckedIcon;

  /// The title.
  final Widget title;

  /// The subtitle below the title.
  final Widget? subtitle;

  /// The details on the right hand side of the title and subtitle.
  final Widget? details;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// The current value.
  final T value;

  /// Whether this radio tile is enabled. Defaults to true.
  final bool? enabled;

  /// Whether this radio tile should focus itself if nothing else is already focused. Defaults to false.
  final bool autofocus;

  /// Defines the [FocusNode] for this radio.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

  final Widget? _icon;

  final bool _suffix;

  /// Creates a [FSelectTile] with a prefix check icon.
  FSelectTile({
    required this.title,
    required this.value,
    this.style,
    this.subtitle,
    this.details,
    this.semanticLabel,
    this.enabled,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Widget? checkedIcon,
    Widget? uncheckedIcon,
    Widget? suffixIcon,
    super.key,
  })  : checkedIcon = checkedIcon ?? FIcon(FAssets.icons.check),
        uncheckedIcon = uncheckedIcon ?? FIcon.empty(),
        _suffix = false,
        _icon = suffixIcon;

  /// Creates a [FSelectTile] with a suffix check icon.
  FSelectTile.suffix({
    required this.title,
    required this.value,
    this.style,
    this.subtitle,
    this.details,
    this.semanticLabel,
    this.enabled,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Widget? prefixIcon,
    Widget? checkedIcon,
    Widget? uncheckedIcon,
    super.key,
  })  : _icon = prefixIcon,
        checkedIcon = checkedIcon ?? FIcon(FAssets.icons.check),
        uncheckedIcon = uncheckedIcon ?? FIcon.empty(),
        _suffix = true;

  @override
  Widget build(BuildContext context) {
    final FSelectTileData(:controller, :selected) = FSelectTileData.of<T>(context);
    final prefix = switch ((_suffix, selected)) {
      (true, _) => _icon,
      (false, true) => checkedIcon,
      (false, false) => uncheckedIcon,
    };

    final suffix = switch ((_suffix, selected)) {
      (false, _) => _icon,
      (true, true) => checkedIcon,
      (true, false) => uncheckedIcon,
    };

    return FTile(
      prefixIcon: prefix,
      title: title,
      subtitle: subtitle,
      details: details,
      suffixIcon: suffix,
      style: style,
      semanticLabel: semanticLabel,
      enabled: enabled,
      onPress: () => controller.select(value, !selected),
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

@internal
class FSelectTileData<T> extends InheritedWidget with FTileMixin {
  static FSelectTileData<T> of<T>(BuildContext context) {
    final FSelectTileData<T>? result = context.dependOnInheritedWidgetOfExactType<FSelectTileData<T>>();
    assert(
      result != null,
      "No FSelectTileData found in context. This likely because FSelectTileGroup's type parameter could not be inferred. "
      'It is currently inferred as FSelectTileGroup<$T>. To fix this, provide the type parameter explicitly, i.e. '
      'FSelectTileGroup<MyType>.',
    );
    return result!;
  }

  final FSelectGroupController<T> controller;
  final bool selected;

  const FSelectTileData({
    required this.controller,
    required this.selected,
    required super.child,
    super.key,
  });

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
