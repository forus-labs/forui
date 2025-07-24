import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:meta/meta.dart';

part 'autocomplete_content.style.dart';

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
class Content extends StatefulWidget {
  final FAutocompleteController controller;
  final FAutocompleteContentStyle style;
  final bool enabled;
  final ScrollController? scrollController;
  final ScrollPhysics physics;
  final FItemDivider divider;
  final FAutocompleteFilter filter;
  final ValueWidgetBuilder<FAutocompleteContentStyle> loadingBuilder;
  final FAutoCompleteContentBuilder builder;
  final ValueWidgetBuilder<FAutocompleteContentStyle> emptyBuilder;
  final Widget Function(BuildContext, Object?, StackTrace)? errorBuilder;

  const Content({
    required this.controller,
    required this.style,
    required this.enabled,
    required this.scrollController,
    required this.physics,
    required this.divider,
    required this.filter,
    required this.loadingBuilder,
    required this.builder,
    required this.emptyBuilder,
    required this.errorBuilder,
    super.key,
  });

  @override
  State<Content> createState() => _State();

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
      ..add(ObjectFlagProperty.has('filter', filter))
      ..add(ObjectFlagProperty.has('loadingBuilder', loadingBuilder))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('emptyBuilder', emptyBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

class _State extends State<Content> {
  late String _previous;
  late FutureOr<FAutocompleteContentData> _data;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);

    _previous = widget.controller.text;
    _data = _filter(widget.controller.text);
  }

  @override
  void didUpdateWidget(covariant Content old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      old.controller.removeListener(_update);
      widget.controller.addListener(_update);

      _previous = widget.controller.text;
      _data = _filter(widget.controller.text);
    }
  }

  void _update() {
    if (_previous != widget.controller.text) {
      _previous = widget.controller.text;
      setState(() {
        // DO NOT TRY TO CONVERT THIS TO AN ARROW EXPRESSION. Doing so changes the return type to a future, which
        // results in an assertion error being thrown.
        _data = _filter(widget.controller.text);
      });
    }
  }

  FutureOr<FAutocompleteContentData> _filter(String query) => switch (widget.filter(query)) {
    final Future<Iterable<String>> values => values.then((values) => (query: query, values: values)),
    final values => (query: query, values: values),
  };

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      switch (_data) {
        final FAutocompleteContentData data => _content(context, data),
        final Future<FAutocompleteContentData> future => FutureBuilder(
          future: future,
          builder: (context, snapshot) => switch (snapshot.connectionState) {
            ConnectionState.waiting => Center(child: widget.loadingBuilder(context, widget.style, null)),
            _ when snapshot.hasError && widget.errorBuilder != null => widget.errorBuilder!.call(
              context,
              snapshot.error,
              snapshot.stackTrace!,
            ),
            _ => _content(context, snapshot.data ?? (query: '', values: [])),
          },
        ),
      },
    ],
  );

  Widget _content(BuildContext context, FAutocompleteContentData data) {
    final children = widget.builder(context, data);
    if (children.isEmpty) {
      return Center(child: widget.emptyBuilder(context, widget.style, null));
    }

    final sectionStyle = widget.style.sectionStyle;
    final itemStyle = widget.style.sectionStyle.itemStyle;

    return Flexible(
      child: ContentData(
        style: sectionStyle,
        enabled: widget.enabled,
        child: Padding(
          padding: widget.style.padding,
          child: ListView(
            controller: widget.scrollController,
            padding: EdgeInsets.zero,
            physics: widget.physics,
            shrinkWrap: true,
            children: [
              for (final (i, child) in children.indexed)
                FInheritedItemData(
                  data: FItemData(
                    style: itemStyle,
                    dividerColor: sectionStyle.dividerColor,
                    dividerWidth: sectionStyle.dividerWidth,
                    divider: i == children.length - 1 ? FItemDivider.none : widget.divider,
                    enabled: widget.enabled,
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
}

/// An [FAutocomplete]'s content style.
class FAutocompleteContentStyle with Diagnosticable, _$FAutocompleteContentStyleFunctions {
  /// The loading indicators style.
  @override
  final IconThemeData loadingIndicatorStyle;

  /// The default text style when there are no results.
  @override
  final TextStyle emptyTextStyle;

  /// The padding surrounding the content. Defaults to `const EdgeInsets.symmetric(vertical: 5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The section's style.
  @override
  final FAutocompleteSectionStyle sectionStyle;

  /// Creates an [FAutocompleteContentStyle].
  FAutocompleteContentStyle({
    required this.loadingIndicatorStyle,
    required this.emptyTextStyle,
    required this.sectionStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 5),
  });

  /// Creates a [FAutocompleteContentStyle] that inherits its properties.
  FAutocompleteContentStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        loadingIndicatorStyle: FProgressStyles.inherit(colors: colors, style: style).circularIconProgressStyle,
        sectionStyle: FAutocompleteSectionStyle.inherit(colors: colors, style: style, typography: typography),
        emptyTextStyle: typography.sm,
      );
}
