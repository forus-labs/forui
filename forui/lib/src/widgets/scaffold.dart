import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';

part 'scaffold.design.dart';

/// A layout structure that contains a header, content, and footer.
///
/// A scaffold provides the basic visual structure for an application, containing
/// elements like header, sidebar, content area, and footer. It is highly recommended
/// to use a scaffold when creating a page even if other elements are not required.
///
/// The layout structure (LTR) is organized as follows:
/// ```md
/// ┌─────────┬─────────────────────┐
/// │         │       HEADER        │
/// │         ├─────────────────────┤
/// │         │                     │
/// │         │                     │
/// │ SIDEBAR │    CONTENT AREA     │
/// │         │                     │
/// │         │                     │
/// │         ├─────────────────────┤
/// │         │       FOOTER        │
/// └─────────┴─────────────────────┘
/// ```
///
/// See:
/// * https://forui.dev/docs/layout/scaffold for working examples.
/// * [FScaffoldStyle] for customizing a scaffold's appearance.
class FScaffold extends StatelessWidget {
  /// The style. Defaults to [FThemeData.scaffoldStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create scaffold
  /// ```
  final FScaffoldStyle Function(FScaffoldStyle style)? scaffoldStyle;

  /// The toaster style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create toast
  /// ```
  final FToasterStyle Function(FToasterStyle style)? toasterStyle;

  /// The main content area of the scaffold.
  final Widget child;

  /// The optional header displayed at the top of the scaffold.
  final Widget? header;

  /// The optional sidebar displayed at the side of the scaffold.
  final Widget? sidebar;

  /// The optional footer displayed at the bottom of the scaffold.
  final Widget? footer;

  /// True if [FScaffoldStyle.childPadding] should be applied to the [child]. Defaults to `true`.
  final bool childPad;

  /// If true, the [child] and the scaffold's floating widgets should size themselves to avoid the onscreen keyboard
  /// whose height is defined by the ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the scaffold, the body can be resized to avoid
  /// overlapping the keyboard, which prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to `true`.
  final bool resizeToAvoidBottomInset;

  /// Creates a [FScaffold].
  const FScaffold({
    required this.child,
    this.scaffoldStyle,
    this.toasterStyle,
    this.header,
    this.sidebar,
    this.footer,
    this.childPad = true,
    this.resizeToAvoidBottomInset = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = scaffoldStyle?.call(context.theme.scaffoldStyle) ?? context.theme.scaffoldStyle;
    var child = this.child;

    final Widget footer = this.footer != null
        ? DecoratedBox(decoration: style.footerDecoration, child: this.footer!)
        : const SizedBox();

    if (childPad) {
      child = Padding(padding: style.childPadding, child: child);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style.systemOverlayStyle,
      child: IconTheme(
        // TODO: Move to ForuiApp.
        data: context.theme.style.iconStyle,
        child: FSheets(
          child: FToaster(
            style: toasterStyle?.call(context.theme.toasterStyle) ?? context.theme.toasterStyle,
            child: Row(
              children: [
                if (sidebar != null) ColoredBox(color: style.sidebarBackgroundColor, child: sidebar),
                Expanded(
                  child: ColoredBox(
                    color: style.backgroundColor,
                    child: _RenderScaffoldWidget(
                      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                      children: [
                        Column(
                          children: [
                            if (header != null) DecoratedBox(decoration: style.headerDecoration, child: header!),
                            Expanded(child: child),
                          ],
                        ),
                        footer,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', scaffoldStyle))
      ..add(DiagnosticsProperty('toasterStyle', toasterStyle))
      ..add(FlagProperty('childPad', value: childPad, ifTrue: 'contentPad', defaultValue: true))
      ..add(
        FlagProperty(
          'resizeToAvoidBottomInset',
          value: resizeToAvoidBottomInset,
          ifTrue: 'resizeToAvoidBottomInset',
          defaultValue: true,
        ),
      );
  }
}

/// The scaffold style.
class FScaffoldStyle with Diagnosticable, _$FScaffoldStyleFunctions {
  /// The fallback system overlay style.
  ///
  /// This is used as a fallback when no other widgets override [AnnotatedRegion<SystemUiOverlayStyle>]. Typically, the
  /// [SystemUiOverlayStyle] property is overridden by [FHeader].
  @override
  final SystemUiOverlayStyle systemOverlayStyle;

  /// The background color.
  @override
  final Color backgroundColor;

  /// The sidebar background color.
  @override
  final Color sidebarBackgroundColor;

  /// The child padding. Only used when [FScaffold.childPad] is `true`.
  @override
  final EdgeInsetsGeometry childPadding;

  /// The header decoration.
  @override
  final BoxDecoration headerDecoration;

  /// The footer decoration.
  ///
  /// ## Removing the top border
  /// By default, both [FBottomNavigationBar] and [FScaffold.footer] specify a top border. When used together, the
  /// top border must be removed from both [FBottomNavigationBarStyle.decoration] and [FScaffoldStyle.footerDecoration]
  /// for the changes to take effect.
  @override
  final BoxDecoration footerDecoration;

  /// Creates a [FScaffoldStyle].
  FScaffoldStyle({
    required this.systemOverlayStyle,
    required this.backgroundColor,
    required this.sidebarBackgroundColor,
    required this.childPadding,
    required this.footerDecoration,
    this.headerDecoration = const BoxDecoration(),
  });

  /// Creates a [FScaffoldStyle] that inherits its properties.
  FScaffoldStyle.inherit({required FColors colors, required FStyle style})
    : this(
        systemOverlayStyle: colors.systemOverlayStyle,
        backgroundColor: colors.background,
        sidebarBackgroundColor: colors.background,
        childPadding: style.pagePadding.copyWith(top: 0, bottom: 0),
        footerDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: colors.border, width: style.borderWidth),
          ),
        ),
      );
}

class _RenderScaffoldWidget extends MultiChildRenderObjectWidget {
  final bool resizeToAvoidBottomInset;

  const _RenderScaffoldWidget({required this.resizeToAvoidBottomInset, required super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return _RenderScaffold(resizeToAvoidBottomInset: resizeToAvoidBottomInset, insets: viewInsets);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderScaffold renderObject) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    renderObject
      ..insets = viewInsets
      ..resizeToAvoidBottomInset = resizeToAvoidBottomInset;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty('resizeToAvoidBottomInset', value: resizeToAvoidBottomInset, ifTrue: 'resizeToAvoidBottomInset'),
    );
  }
}

class _RenderScaffold extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  bool _resizeToAvoidBottomInset;
  EdgeInsets _insets;

  _RenderScaffold({required bool resizeToAvoidBottomInset, required EdgeInsets insets})
    : _resizeToAvoidBottomInset = resizeToAvoidBottomInset,
      _insets = insets;

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = DefaultData();

  @override
  void performLayout() {
    size = constraints.biggest;
    final others = firstChild!;

    final footerConstraints = constraints.loosen();
    final footer = lastChild!..layout(footerConstraints, parentUsesSize: true);
    final footerHeight = _resizeToAvoidBottomInset ? max(insets.bottom, footer.size.height) : footer.size.height;

    final othersHeight = constraints.maxHeight - footerHeight;
    others.layout(constraints.copyWith(minHeight: 0, maxHeight: othersHeight));

    others.data.offset = Offset.zero;
    footer.data.offset = Offset(0, size.height - footer.size.height);
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  EdgeInsets get insets => _insets;

  set insets(EdgeInsets value) {
    if (_insets == value) {
      return;
    }

    _insets = value;
    markNeedsLayout();
  }

  bool get resizeToAvoidBottomInset => _resizeToAvoidBottomInset;

  set resizeToAvoidBottomInset(bool value) {
    if (_resizeToAvoidBottomInset == value) {
      return;
    }

    _resizeToAvoidBottomInset = value;
    markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        FlagProperty('resizeToAvoidBottomInset', value: resizeToAvoidBottomInset, ifTrue: 'resizeToAvoidBottomInset'),
      )
      ..add(DiagnosticsProperty('insets', insets));
  }
}
