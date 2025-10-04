import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'sidebar.design.dart';

/// A sidebar widget that provides an opinionated layout on the side of the screen.
///
/// The [FSidebar] widget is useful for creating navigation sidebars with a header (sticky), content (scrollable), and
/// footer (sticky) sections.
///
/// The layout structure is organized as follows:
/// ```md
/// ┌────────────────────-┐
/// │   Header (Sticky)   │
/// ├────────────────────-┤
/// │                     │
/// │                     │
/// │      Content        │
/// │    (Scrollable)     │
/// │                     │
/// │                     │
/// ├────────────────────-┤
/// │   Footer (Sticky)   │
/// └────────────────────-┘
/// ```
///
/// See:
/// * https://forui.dev/docs/navigation/sidebar for working examples.
/// * [FSidebarStyle] for customizing a sidebar's appearance.
class FSidebar extends StatefulWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  final FSidebarStyle Function(FSidebarStyle style)? style;

  /// An optional sticky header.
  final Widget? header;

  /// The main scrollable content.
  final Widget child;

  /// An optional sticky footer.
  final Widget? footer;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// Controls the transfer of focus beyond the first and the last items in the sidebar. Defaults to
  /// [TraversalEdgeBehavior.parentScope].
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [focusNode] and [traversalEdgeBehavior] are not null.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// The optional width of the sidebar. If not provided, the width from the style will be used.
  final double? width;

  /// Creates a sidebar with a list of children that will be wrapped in a [ListView].
  FSidebar({
    required List<Widget> children,
    this.header,
    this.footer,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.traversalEdgeBehavior,
    this.width,
    super.key,
  }) : assert(
         focusNode == null || traversalEdgeBehavior == null,
         'Cannot provide both a focusNode and traversalEdgeBehavior',
       ),
       child = ListView(children: children);

  /// Creates a sidebar with a builder function that will be wrapped in a [ListView.builder].
  FSidebar.builder({
    required Widget Function(BuildContext context, int index) itemBuilder,
    required int itemCount,
    this.style,
    this.header,
    this.footer,
    this.autofocus = false,
    this.focusNode,
    this.traversalEdgeBehavior,
    this.width,
    super.key,
  }) : assert(
         focusNode == null || traversalEdgeBehavior == null,
         'Cannot provide both a focusNode and traversalEdgeBehavior',
       ),
       child = ListView.builder(itemBuilder: itemBuilder, itemCount: itemCount);

  /// Creates a sidebar with a custom content widget.
  ///
  /// Use this constructor when you want to provide your own scrollable content widget instead of using the default
  /// [ListView].
  const FSidebar.raw({
    required this.child,
    this.header,
    this.footer,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.traversalEdgeBehavior,
    this.width,
    super.key,
  }) : assert(
         focusNode == null || traversalEdgeBehavior == null,
         'Cannot provide both a focusNode and traversalEdgeBehavior',
       );

  @override
  State<FSidebar> createState() => _FSidebarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(DoubleProperty('width', width));
  }
}

class _FSidebarState extends State<FSidebar> {
  FocusScopeNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode =
        widget.focusNode ??
        FocusScopeNode(traversalEdgeBehavior: widget.traversalEdgeBehavior ?? TraversalEdgeBehavior.parentScope);
  }

  @override
  void didUpdateWidget(covariant FSidebar old) {
    super.didUpdateWidget(old);

    if (widget.focusNode != old.focusNode || widget.traversalEdgeBehavior != old.traversalEdgeBehavior) {
      if (old.focusNode == null) {
        _focusNode?.dispose();
      }

      _focusNode =
          widget.focusNode ??
          FocusScopeNode(traversalEdgeBehavior: widget.traversalEdgeBehavior ?? TraversalEdgeBehavior.parentScope);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.sidebarStyle) ?? context.theme.sidebarStyle;

    Widget sidebar = FocusScope(
      autofocus: widget.autofocus,
      node: _focusNode,
      child: FSidebarData(
        style: style,
        child: DecoratedBox(
          decoration: style.decoration,
          child: ConstrainedBox(
            constraints: style.constraints,
            child: Column(
              children: [
                if (widget.header != null) Padding(padding: style.headerPadding, child: widget.header!),
                Expanded(
                  child: Padding(padding: style.contentPadding, child: widget.child),
                ),
                if (widget.footer != null) Padding(padding: style.footerPadding, child: widget.footer!),
              ],
            ),
          ),
        ),
      ),
    );

    if (style.backgroundFilter case final filter?) {
      sidebar = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(filter: filter, child: Container()),
            ),
          ),
          sidebar,
        ],
      );
    }

    return sidebar;
  }
}

/// A [FSidebar]'s data.
class FSidebarData extends InheritedWidget {
  /// Returns the [FSidebarData] of the [FSidebar] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FSidebar] in the given [context].
  static FSidebarData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FSidebarData>();

  /// The [FSidebar]'s style.
  final FSidebarStyle style;

  /// Creates a [FSidebarData].
  const FSidebarData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FSidebarData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FSidebar]'s style.
class FSidebarStyle with Diagnosticable, _$FSidebarStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// An optional background filter applied to the sidebar.
  ///
  /// This is typically combined with a translucent background in [decoration] to create a glassmorphic effect.
  @override
  final ImageFilter? backgroundFilter;

  /// The sidebar's width. Defaults to `BoxConstraints.tightFor(width: 250)`.
  @override
  final BoxConstraints constraints;

  /// The group's style.
  @override
  final FSidebarGroupStyle groupStyle;

  /// The padding for the header section. Defaults to `EdgeInsets.fromLTRB(0, 16, 0, 0)`.
  ///
  /// It is recommended to set the horizontal padding to 0. This ensures that the elements such as the scrollbar is not
  /// overlapped by the content.
  @override
  final EdgeInsetsGeometry headerPadding;

  /// The padding for the content section. Defaults to `EdgeInsets.symmetric(vertical: 12)`.
  ///
  /// It is recommended to set the horizontal padding to 0. This ensures that the elements such as the scrollbar is not
  /// overlapped by the content.
  @override
  final EdgeInsetsGeometry contentPadding;

  /// The padding for the footer section. Defaults to `EdgeInsets.fromLTRB(0, 0, 0, 16)`.
  ///
  /// It is recommended to set the horizontal padding to 0. This ensures that the elements such as the scrollbar is not
  /// overlapped by the content.
  @override
  final EdgeInsetsGeometry footerPadding;

  /// Creates a [FSidebarStyle].
  const FSidebarStyle({
    required this.decoration,
    required this.groupStyle,
    this.constraints = const BoxConstraints.tightFor(width: 250),
    this.backgroundFilter,
    this.headerPadding = const EdgeInsets.fromLTRB(0, 16, 0, 0),
    this.contentPadding = const EdgeInsets.symmetric(vertical: 12),
    this.footerPadding = const EdgeInsets.fromLTRB(0, 0, 0, 16),
  });

  /// Creates a [FSidebarStyle] that inherits its properties.
  FSidebarStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(
          color: colors.background,
          border: BorderDirectional(
            end: BorderSide(color: colors.border, width: style.borderWidth),
          ),
        ),
        groupStyle: FSidebarGroupStyle.inherit(colors: colors, typography: typography, style: style),
      );
}
