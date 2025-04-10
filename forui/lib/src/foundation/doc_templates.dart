import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
extension Focus on Never {
  /// {@template forui.foundation.doc_templates.autofocus}
  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Ideally, there should be only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  ///
  /// Defaults to false.
  /// {@endtemplate}
  static const autofocus = '';

  /// {@template forui.foundation.doc_templates.focusNode}
  /// An optional focus node to use as the focus node for this widget.
  ///
  /// If one is not supplied, then one will be automatically allocated, owned, and managed by this widget. The widget
  /// will be focusable even if a [focusNode] is not supplied. If supplied, the given `focusNode` will be hosted by this
  /// widget, but not owned. See [FocusNode] for more information on what being hosted and/or owned implies.
  ///
  /// Supplying a focus node is sometimes useful if an ancestor to this widget wants to control when this widget has the
  /// focus. The owner will be responsible for calling [FocusNode.dispose] on the focus node when it is done with it,
  /// but this widget will attach/detach and reparent the node when needed.
  /// {@endtemplate}
  static const focusNode = '';

  /// {@template forui.foundation.doc_templates.onFocusChange}
  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  /// {@endtemplate}
  static const onFocusChange = '';
}

@internal
extension WidgetStates on Never {
  /// {@template forui.foundation.doc_templates.WidgetStates.form}
  ///  Supported states:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// {@endtemplate}
  static const form = '';

  /// {@template forui.foundation.doc_templates.WidgetStates.selectable}
  ///  Supported states:
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.disabled]
  /// {@endtemplate}
  static const selectable = '';

  /// {@template forui.foundation.doc_templates.WidgetStates.tappable}
  ///  Supported states:
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.disabled]
  /// {@endtemplate}
  static const tappable = '';
}

@internal
extension Semantics on Never {
  /// {@template forui.foundation.doc_templates.semanticsLabel}
  /// The semantic label used by accessibility frameworks.
  /// {@endtemplate}
  @internal
  static const semanticsLabel = '';
}

@internal
extension Scroll on Never {
  /// {@template forui.foundation.doc_templates.cacheExtent}
  /// The scrollable area's cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  /// {@endtemplate}
  static const cacheExtent = '';
}
