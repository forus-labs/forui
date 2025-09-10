import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_content.design.dart';

@internal
class Content extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextBaseline? textBaseline;
  final Widget? prefix;
  final Widget? suffix;
  final Widget child;

  const Content({
    required this.mainAxisSize,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.textBaseline,
    required this.prefix,
    required this.suffix,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonStyle(:contentStyle), :states) = FButtonData.of(context);
    return Padding(
      padding: contentStyle.padding,
      child: DefaultTextStyle.merge(
        style: contentStyle.textStyle.resolve(states),
        child: IconTheme(
          data: contentStyle.iconStyle.resolve(states),
          child: FInheritedCircularProgressStyle(
            style: contentStyle.circularProgressStyle.resolve(states),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              textBaseline: textBaseline,
              spacing: contentStyle.spacing,
              children: [?prefix, child, ?suffix],
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
      ..add(EnumProperty('mainAxisSize', mainAxisSize, defaultValue: MainAxisSize.max))
      ..add(EnumProperty('mainAxisAlignment', mainAxisAlignment))
      ..add(EnumProperty('crossAxisAlignment', crossAxisAlignment))
      ..add(EnumProperty('textBaseline', textBaseline));
  }
}

@internal
class IconContent extends StatelessWidget {
  final Widget child;

  const IconContent({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(:style, :states) = FButtonData.of(context);

    return Padding(
      padding: style.iconContentStyle.padding,
      child: IconTheme(data: style.iconContentStyle.iconStyle.resolve(states), child: child),
    );
  }
}

/// [FButton] content's style.
class FButtonContentStyle with Diagnosticable, _$FButtonContentStyleFunctions {
  /// The [TextStyle].
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The circular progress's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<FCircularProgressStyle> circularProgressStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 12.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between prefix, child, and suffix. Defaults to 10.
  @override
  final double spacing;

  /// Creates a [FButtonContentStyle].
  const FButtonContentStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.circularProgressStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
    this.spacing = 10,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties.
  FButtonContentStyle.inherit({required FTypography typography, required Color enabled, required Color disabled})
    : this(
        textStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(color: disabled, fontWeight: FontWeight.w500, height: 1),
          WidgetState.any: typography.base.copyWith(color: enabled, fontWeight: FontWeight.w500, height: 1),
        }),
        iconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: disabled, size: 20),
          WidgetState.any: IconThemeData(color: enabled, size: 20),
        }),
        circularProgressStyle: FWidgetStateMap({
          WidgetState.disabled: FCircularProgressStyle(iconStyle: IconThemeData(color: disabled, size: 20)),
          WidgetState.any: FCircularProgressStyle(iconStyle: IconThemeData(color: enabled, size: 20)),
        }),
      );
}

/// [FButton] icon content's style.
class FButtonIconContentStyle with Diagnosticable, _$FButtonIconContentStyleFunctions {
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The padding. Defaults to `EdgeInsets.all(7.5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({required this.iconStyle, this.padding = const EdgeInsets.all(7.5)});

  /// Creates a [FButtonIconContentStyle] that inherits its properties.
  FButtonIconContentStyle.inherit({required Color enabled, required Color disabled})
    : this(
        iconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: disabled, size: 20),
          WidgetState.any: IconThemeData(color: enabled, size: 20),
        }),
      );
}
