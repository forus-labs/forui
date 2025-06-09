import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'sidebar.style.dart';

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
class FSidebar extends StatelessWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  final FSidebarStyle? style;

  /// The optional sticky header widget.
  final Widget? header;

  /// The main scrollable content widget.
  final Widget child;

  /// The optional sticky footer widget.
  final Widget? footer;

  /// The optional width of the sidebar. If not provided, the width from the style will be used.
  final double? width;

  /// Creates a sidebar with a list of children that will be wrapped in a [ListView].
  FSidebar({required List<Widget> children, this.header, this.footer, this.style, this.width, super.key})
    : child = ListView(children: children);

  /// Creates a sidebar with a builder function that will be wrapped in a [ListView.builder].
  FSidebar.builder({
    required Widget Function(BuildContext, int) itemBuilder,
    required int itemCount,
    this.style,
    this.header,
    this.footer,
    this.width,
    super.key,
  }) : child = ListView.builder(itemBuilder: itemBuilder, itemCount: itemCount);

  /// Creates a sidebar with a custom content widget.
  ///
  /// Use this constructor when you want to provide your own scrollable content widget instead of using the default
  /// [ListView].
  const FSidebar.raw({required this.child, this.header, this.footer, this.style, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.sidebarStyle;

    Widget sidebar = FSidebarData(
      style: style,
      child: DecoratedBox(
        decoration: style.decoration,
        child: ConstrainedBox(
          constraints: style.constraints,
          child: Column(
            children: [
              if (header != null) Padding(padding: style.headerPadding, child: header!),
              Expanded(
                child: Padding(padding: style.contentPadding, child: child),
              ),
              if (footer != null) Padding(padding: style.footerPadding, child: footer!),
            ],
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('width', width));
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
