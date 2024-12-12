import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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
  final Widget content;

  /// The header.
  final Widget? header;

  /// The footer.
  final Widget? footer;

  /// True if [FScaffoldStyle.contentPadding] should be applied to the [content]. Defaults to `true`.
  final bool contentPad;

  /// If true the [body] and the scaffold's floating widgets should size themselves to avoid the onscreen keyboard
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
    required this.content,
    this.header,
    this.footer,
    this.contentPad = true,
    this.resizeToAvoidBottomInset = true,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.scaffoldStyle;
    final viewInsets = MediaQuery.viewInsetsOf(context);
    Widget content = this.content;
    Widget footer = this.footer != null
        ? DecoratedBox(
            decoration: style.footerDecoration,
            child: this.footer!,
          )
        : const SizedBox();

    if (contentPad) {
      content = Padding(padding: style.contentPadding, child: content);
    }

    if (viewInsets.bottom > 0 && resizeToAvoidBottomInset) {
      footer = SizedBox(height: viewInsets.bottom);
    }

    return ColoredBox(
      color: style.backgroundColor,
      child: _Wrapper(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        children: [
          Column(
            children: [
              if (header != null) DecoratedBox(decoration: style.headerDecoration, child: header!),
              Expanded(child: content),
            ],
          ),
          footer,
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('contentPad', value: contentPad, defaultValue: true))
      ..add(FlagProperty('resizeToAvoidBottomInset', value: resizeToAvoidBottomInset, defaultValue: true));
  }
}

/// [FScaffold]'s style.
final class FScaffoldStyle with Diagnosticable {
  /// The background color.
  final Color backgroundColor;

  /// The content padding. Only used when [FScaffold.contentPad] is `true`.
  final EdgeInsets contentPadding;

  /// The header decoration.
  final BoxDecoration headerDecoration;

  /// The footer decoration.
  final BoxDecoration footerDecoration;

  /// Creates a [FScaffoldStyle].
  FScaffoldStyle({
    required this.backgroundColor,
    required this.contentPadding,
    required this.footerDecoration,
    this.headerDecoration = const BoxDecoration(),
  });

  /// Creates a [FScaffoldStyle] that inherits its properties from the provided [colorScheme] and [style].
  FScaffoldStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : this(
          backgroundColor: colorScheme.background,
          contentPadding: style.pagePadding.copyWith(top: 0, bottom: 0),
          footerDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: colorScheme.border,
                width: style.borderWidth,
              ),
            ),
          ),
        );

  /// Returns a copy of this style with the provided properties replaced.
  @useResult
  FScaffoldStyle copyWith({
    Color? backgroundColor,
    EdgeInsets? contentPadding,
    BoxDecoration? headerDecoration,
    BoxDecoration? footerDecoration,
  }) =>
      FScaffoldStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        contentPadding: contentPadding ?? this.contentPadding,
        headerDecoration: headerDecoration ?? this.headerDecoration,
        footerDecoration: footerDecoration ?? this.footerDecoration,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration))
      ..add(DiagnosticsProperty('footerDecoration', footerDecoration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FScaffoldStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          contentPadding == other.contentPadding &&
          headerDecoration == other.headerDecoration &&
          footerDecoration == other.footerDecoration;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^ contentPadding.hashCode ^ headerDecoration.hashCode ^ footerDecoration.hashCode;
}

class _Wrapper extends MultiChildRenderObjectWidget {
  final bool resizeToAvoidBottomInset;

  const _Wrapper({
    required this.resizeToAvoidBottomInset,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return _RenderScaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      insets: viewInsets,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderScaffold renderObject) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    renderObject.insets = viewInsets;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('resizeToAvoidBottomInset', resizeToAvoidBottomInset));
  }
}

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

class _RenderScaffold extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  final bool resizeToAvoidBottomInset;
  EdgeInsets _insets;

  _RenderScaffold({
    required this.resizeToAvoidBottomInset,
    required EdgeInsets insets,
  }) : _insets = insets;

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = _Data();

  @override
  void performLayout() {
    size = constraints.biggest;
    final others = firstChild!;

    final footerConstraints = constraints.loosen();
    final footer = lastChild!..layout(footerConstraints, parentUsesSize: true);

    final othersHeight = constraints.maxHeight - max(insets.bottom, footer.size.height);
    final othersConstraints = constraints.copyWith(minHeight: 0, maxHeight: othersHeight);
    others.layout(othersConstraints);

    others.data.offset = Offset.zero;
    footer.data.offset = Offset(0, size.height - footer.size.height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  EdgeInsets get insets => _insets;

  set insets(EdgeInsets insets) {
    if (_insets == insets) {
      return;
    }

    _insets = insets;
    markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('resizeToAvoidBottomInset', resizeToAvoidBottomInset))
      ..add(DiagnosticsProperty('insets', insets));
  }
}
