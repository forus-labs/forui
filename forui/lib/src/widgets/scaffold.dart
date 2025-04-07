import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';

part 'scaffold.style.dart';

/// A scaffold.
///
/// A scaffold is a layout structure that contains a header, content, and footer.
/// It is highly recommended to use a scaffold when creating a page even if a header and footer are not required.
///
/// See:
/// * https://forui.dev/docs/layout/scaffold for working examples.
/// * [FScaffoldStyle] for customizing a scaffold's appearance.
class FScaffold extends StatelessWidget {
  /// The content.
  final Widget child;

  /// The header.
  final Widget? header;

  /// The footer.
  final Widget? footer;

  /// True if [FScaffoldStyle.childPadding] should be applied to the [child]. Defaults to `true`.
  final bool childPad;

  /// If true the [child] and the scaffold's floating widgets should size themselves to avoid the onscreen keyboard
  /// whose height is defined by the ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the scaffold, the body can be resized to avoid
  /// overlapping the keyboard, which prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to `true`.
  final bool resizeToAvoidBottomInset;

  /// The style. Defaults to [FThemeData.scaffoldStyle].
  final FScaffoldStyle? style;

  /// Creates a [FScaffold].
  const FScaffold({
    required this.child,
    this.header,
    this.footer,
    this.childPad = true,
    this.resizeToAvoidBottomInset = true,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.scaffoldStyle;
    var child = this.child;
    final Widget footer =
        this.footer != null ? DecoratedBox(decoration: style.footerDecoration, child: this.footer!) : const SizedBox();

    if (childPad) {
      child = Padding(padding: style.childPadding, child: child);
    }

    return FSheets(
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
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

/// [FScaffold]'s style.
final class FScaffoldStyle with Diagnosticable, _$FScaffoldStyleFunctions {
  /// The background color.
  @override
  final Color backgroundColor;

  /// The child padding. Only used when [FScaffold.childPad] is `true`.
  @override
  final EdgeInsetsGeometry childPadding;

  /// The header decoration.
  @override
  final BoxDecoration headerDecoration;

  /// The footer decoration.
  @override
  final BoxDecoration footerDecoration;

  /// Creates a [FScaffoldStyle].
  FScaffoldStyle({
    required this.backgroundColor,
    required this.childPadding,
    required this.footerDecoration,
    this.headerDecoration = const BoxDecoration(),
  });

  /// Creates a [FScaffoldStyle] that inherits its properties.
  FScaffoldStyle.inherit({required FColors colors, required FStyle style})
    : this(
        backgroundColor: colors.background,
        childPadding: style.pagePadding.copyWith(top: 0, bottom: 0),
        footerDecoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border, width: style.borderWidth))),
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

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

class _RenderScaffold extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  bool _resizeToAvoidBottomInset;
  EdgeInsets _insets;

  _RenderScaffold({required bool resizeToAvoidBottomInset, required EdgeInsets insets})
    : _resizeToAvoidBottomInset = resizeToAvoidBottomInset,
      _insets = insets;

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = _Data();

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
