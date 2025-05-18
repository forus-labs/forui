import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sidebar.style.dart';

/// A sidebar widget that provides an opinionated layout.
///
/// The [FSidebar] widget is useful for creating navigation sidebars with
/// a header (sticky), content (scrollable), and footer (sticky) sections.
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
/// * https://forui.dev/docs/layout/sidebar for working examples.
/// * [FSidebarStyle] for customizing a sidebar's appearance.
class FSidebar extends StatelessWidget {
  /// The sidebar's style.
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

  /// Creates a sidebar with a list of children that will be wrapped in a [ListView].
  FSidebar({required List<Widget> children, this.header, this.footer, this.style, super.key})
    : child = ListView(children: children);

  /// Creates a sidebar with a builder function that will be wrapped in a [ListView.builder].
  FSidebar.builder({
    required Widget Function(BuildContext, int) itemBuilder,
    required int itemCount,
    this.style,
    this.header,
    this.footer,
    super.key,
  }) : child = ListView.builder(itemBuilder: itemBuilder, itemCount: itemCount);

  /// Creates a sidebar with a custom content widget.
  ///
  /// Use this constructor when you want to provide your own scrollable content widget
  /// instead of using the default [ListView].
  const FSidebar.raw({required this.child, this.header, this.footer, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.sidebarStyle;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: BorderDirectional(end: BorderSide(color: style.borderColor, width: style.borderWidth)),
      ),
      child: SizedBox(
        width: style.width,
        child: Column(children: [if (header != null) header!, Expanded(child: child), if (footer != null) footer!]),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FSidebarStyle>('style', style));
  }
}

/// A [FSidebar]'s style.
class FSidebarStyle with Diagnosticable, _$FSidebarStyleFunctions {
  /// The width of the sidebar.
  @override
  final double width;

  /// The border color for the sidebar.
  @override
  final Color borderColor;

  /// The border width for the sidebar.
  @override
  final double borderWidth;

  /// The style for [FSidebarGroup]s.
  @override
  final FSidebarGroupStyle groupStyle;

  /// The style for [FSidebarItem]s.
  @override
  final FSidebarItemStyle itemStyle;

  /// Creates a [FSidebarStyle].
  const FSidebarStyle({
    required this.width,
    required this.borderColor,
    required this.borderWidth,
    required this.groupStyle,
    required this.itemStyle,
  });

  /// Creates a [FSidebarStyle] that inherits its properties from the theme.
  FSidebarStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        width: 250,
        borderColor: colors.border,
        borderWidth: 1,
        groupStyle: FSidebarGroupStyle.inherit(colors: colors, typography: typography, style: style),
        itemStyle: FSidebarItemStyle.inherit(colors: colors, typography: typography, style: style),
      );
}
