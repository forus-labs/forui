import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

part 'autocomplete_content.design.dart';

@internal
class ContentData extends InheritedWidget {
  static ContentData of(BuildContext context) {
    assert(debugCheckHasAncestor<ContentData>('$FAutocomplete', context));
    return context.dependOnInheritedWidgetOfExactType<ContentData>()!;
  }

  final FAutocompleteSectionStyle style;
  final bool enabled;

  const ContentData({required this.style, required this.enabled, required super.child, super.key});

  @override
  bool updateShouldNotify(ContentData old) => style != old.style || enabled != old.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

@internal
class Content extends StatelessWidget {
  final FAutocompleteController controller;
  final FAutocompleteContentStyle style;
  final bool enabled;
  final ScrollController? scrollController;
  final ScrollPhysics physics;
  final FItemDivider divider;
  final FutureOr<Iterable<String>> data;
  final Widget Function(BuildContext context, FAutocompleteContentStyle style) loadingBuilder;
  final FAutoCompleteContentBuilder builder;
  final Widget Function(BuildContext context, FAutocompleteContentStyle style) emptyBuilder;
  final Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? errorBuilder;

  const Content({
    required this.controller,
    required this.style,
    required this.enabled,
    required this.scrollController,
    required this.physics,
    required this.divider,
    required this.data,
    required this.loadingBuilder,
    required this.builder,
    required this.emptyBuilder,
    required this.errorBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      switch (data) {
        final Iterable<String> data => _content(context, data),
        final Future<Iterable<String>> future => FutureBuilder(
          future: future,
          builder: (context, snapshot) => switch (snapshot.connectionState) {
            ConnectionState.waiting => Center(child: loadingBuilder(context, style)),
            _ when snapshot.hasError && errorBuilder != null => errorBuilder!.call(
              context,
              snapshot.error,
              snapshot.stackTrace!,
            ),
            _ => _content(context, snapshot.data ?? []),
          },
        ),
      },
    ],
  );

  Widget _content(BuildContext context, Iterable<String> values) {
    final children = builder(context, controller.text, values);
    if (children.isEmpty) {
      return Center(child: emptyBuilder(context, style));
    }

    final sectionStyle = style.sectionStyle;
    final itemStyle = style.sectionStyle.itemStyle;

    return Flexible(
      child: ContentData(
        style: sectionStyle,
        enabled: enabled,
        child: Padding(
          padding: style.padding,
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            physics: physics,
            shrinkWrap: true,
            children: [
              for (final (i, child) in children.indexed)
                FInheritedItemData(
                  data: FItemData(
                    style: itemStyle,
                    dividerColor: sectionStyle.dividerColor,
                    dividerWidth: sectionStyle.dividerWidth,
                    divider: i == children.length - 1 ? FItemDivider.none : divider,
                    enabled: enabled,
                    index: i,
                    last: i == children.length - 1,
                    globalLast: i == children.length - 1,
                  ),
                  child: child,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(EnumProperty('divider', divider))
      ..add(ObjectFlagProperty.has('data', data))
      ..add(ObjectFlagProperty.has('loadingBuilder', loadingBuilder))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('emptyBuilder', emptyBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

/// An [FAutocomplete]'s content style.
class FAutocompleteContentStyle extends FPopoverStyle with Diagnosticable, _$FAutocompleteContentStyleFunctions {
  /// The default text style when there are no results.
  @override
  final TextStyle emptyTextStyle;

  /// The padding surrounding the content. Defaults to `const EdgeInsets.symmetric(vertical: 5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The loading progress's style.
  @override
  final FCircularProgressStyle progressStyle;

  /// The section's style.
  @override
  final FAutocompleteSectionStyle sectionStyle;

  /// Creates an [FAutocompleteContentStyle].
  FAutocompleteContentStyle({
    required this.emptyTextStyle,
    required this.progressStyle,
    required this.sectionStyle,
    required super.decoration,
    this.padding = const EdgeInsets.symmetric(vertical: 5),
    super.barrierFilter,
    super.backgroundFilter,
    super.viewInsets,
  });

  /// Creates a [FAutocompleteContentStyle] that inherits its properties.
  FAutocompleteContentStyle.inherit({required super.colors, required FTypography typography, required super.style})
    : emptyTextStyle = typography.sm,
      progressStyle = FCircularProgressStyle.inherit(colors: colors),
      sectionStyle = FAutocompleteSectionStyle.inherit(colors: colors, style: style, typography: typography),
      padding = const EdgeInsets.symmetric(vertical: 5),
      super.inherit();
}
