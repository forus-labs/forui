import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:meta/meta.dart';

part 'search_content.style.dart';

/// A [FSelect] search field's query and results.
typedef FSelectSearchData<T> = ({String query, Iterable<T> values});

/// A [FSelect] search field's filter.
typedef FSelectSearchFilter<T> = FutureOr<Iterable<T>> Function(String query);

/// A builder for [FSelect] search results.
typedef FSelectSearchContentBuilder<T> =
    List<FSelectItemMixin> Function(BuildContext context, FSelectSearchData<T> data);

@internal
class SearchContent<T> extends StatefulWidget {
  final ScrollController? controller;
  final FSelectStyle style;
  final FSelectSearchFieldProperties properties;
  final bool first;
  final bool enabled;
  final bool scrollHandles;
  final ScrollPhysics physics;
  final FSelectSearchFilter<T> filter;
  final ValueWidgetBuilder<FSelectSearchStyle> loadingBuilder;
  final FSelectSearchContentBuilder<T> builder;
  final ValueWidgetBuilder<FSelectStyle> emptyBuilder;
  final Widget Function(BuildContext, Object?, StackTrace)? errorBuilder;

  const SearchContent({
    required this.controller,
    required this.style,
    required this.properties,
    required this.first,
    required this.enabled,
    required this.scrollHandles,
    required this.physics,
    required this.filter,
    required this.loadingBuilder,
    required this.builder,
    required this.emptyBuilder,
    required this.errorBuilder,
    super.key,
  });

  @override
  State<SearchContent<T>> createState() => _SearchContentState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('first', first))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('scrollHandles', scrollHandles))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(ObjectFlagProperty.has('filter', filter))
      ..add(ObjectFlagProperty.has('loadingBuilder', loadingBuilder))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('emptyBuilder', emptyBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

class _SearchContentState<T> extends State<SearchContent<T>> {
  final TextEditingController _textController = TextEditingController();
  late String _previous;
  late FutureOr<FSelectSearchData<T>> _data;

  @override
  void initState() {
    super.initState();
    _previous = _textController.text;
    _data = _filter('');
    _textController.addListener(() {
      if (_previous != _textController.text) {
        _previous = _textController.text;
        setState(() {
          // DO NOT TRY TO CONVERT THIS TO AN ARROW EXPRESSION. Doing so changes the return type to a future, which
          // results in an assertion error being thrown.
          _data = _filter(_textController.text);
        });
      }
    });
  }

  FutureOr<FSelectSearchData<T>> _filter(String query) => switch (widget.filter(query)) {
    final Future<Iterable<T>> values => values.then((values) => (query: query, values: values)),
    final values => (query: query, values: values),
  };

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final prefix = widget.properties.prefixBuilder;
    final suffix = widget.properties.suffixBuilder;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FTextField(
          controller: _textController,
          style: widget.style.searchStyle.textFieldStyle,
          hint: widget.properties.hint ?? localizations.selectSearchHint,
          magnifierConfiguration: widget.properties.magnifierConfiguration,
          keyboardType: widget.properties.keyboardType,
          textInputAction: widget.properties.textInputAction,
          textCapitalization: widget.properties.textCapitalization,
          textAlign: widget.properties.textAlign,
          textAlignVertical: widget.properties.textAlignVertical,
          textDirection: widget.properties.textDirection,
          autofocus: widget.properties.autofocus,
          autocorrect: widget.properties.autocorrect,
          smartDashesType: widget.properties.smartDashesType,
          smartQuotesType: widget.properties.smartQuotesType,
          enableSuggestions: widget.properties.enableSuggestions,
          minLines: widget.properties.minLines,
          maxLines: widget.properties.maxLines,
          readOnly: widget.properties.readOnly,
          showCursor: widget.properties.showCursor,
          maxLength: widget.properties.maxLength,
          maxLengthEnforcement: widget.properties.maxLengthEnforcement,
          onChange: widget.properties.onChange,
          onTap: widget.properties.onTap,
          onTapAlwaysCalled: widget.properties.onTapAlwaysCalled,
          onEditingComplete: widget.properties.onEditingComplete,
          onSubmit: widget.properties.onSubmit,
          inputFormatters: widget.properties.inputFormatters,
          enabled: widget.properties.enabled,
          ignorePointers: widget.properties.ignorePointers,
          enableInteractiveSelection: widget.properties.enableInteractiveSelection,
          selectionControls: widget.properties.selectionControls,
          dragStartBehavior: widget.properties.dragStartBehavior,
          mouseCursor: widget.properties.mouseCursor,
          scrollPhysics: widget.properties.scrollPhysics,
          scrollController: widget.properties.scrollController,
          autofillHints: widget.properties.autofillHints,
          restorationId: widget.properties.restorationId,
          stylusHandwritingEnabled: widget.properties.stylusHandwritingEnabled,
          enableIMEPersonalizedLearning: widget.properties.enableIMEPersonalizedLearning,
          contentInsertionConfiguration: widget.properties.contentInsertionConfiguration,
          contextMenuBuilder: widget.properties.contextMenuBuilder,
          undoController: widget.properties.undoController,
          spellCheckConfiguration: widget.properties.spellCheckConfiguration,
          prefixBuilder:
              prefix == null
                  ? null
                  : (context, style, child) => prefix(context, (widget.style.searchStyle, style), child),
          suffixBuilder:
              suffix == null
                  ? null
                  : (context, style, child) => suffix(context, (widget.style.searchStyle, style), child),
          clearable: widget.properties.clearable,
        ),
        FDivider(style: widget.style.searchStyle.dividerStyle),
        switch (_data) {
          final FSelectSearchData<T> data => _content(context, data),
          final Future<FSelectSearchData<T>> future => FutureBuilder(
            future: future,
            builder:
                (context, snapshot) => switch (snapshot.connectionState) {
                  ConnectionState.waiting => Center(
                    child: widget.loadingBuilder(context, widget.style.searchStyle, null),
                  ),
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
  }

  Widget _content(BuildContext context, FSelectSearchData<T> data) {
    final children = widget.builder(context, data);
    if (children.isEmpty) {
      return widget.emptyBuilder(context, widget.style, null);
    }

    return Expanded(
      child: Content<T>(
        controller: widget.controller,
        style: widget.style.contentStyle,
        first: widget.first,
        enabled: widget.enabled,
        scrollHandles: widget.scrollHandles,
        physics: widget.physics,
        children: children,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

/// A [FSelect]'s search field style.
class FSelectSearchStyle with Diagnosticable, _$FSelectSearchStyleFunctions {
  /// The search field's style.
  @override
  final FTextFieldStyle textFieldStyle;

  /// The search icon's style.
  @override
  final FIconStyle iconStyle;

  /// The style of the divider between the search field and results.
  @override
  final FDividerStyle dividerStyle;

  /// The loading indicators style.
  @override
  final FCircularIconProgressStyle loadingIndicatorStyle;

  /// Creates a [FSelectSearchStyle].
  FSelectSearchStyle({
    required this.textFieldStyle,
    required this.iconStyle,
    required this.dividerStyle,
    required this.loadingIndicatorStyle,
  });

  /// Creates a copy of this [FSelectSearchStyle] but with the given fields replaced with the new values.
  FSelectSearchStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
         textFieldStyle: FTextFieldStyle.inherit(
           colorScheme: colorScheme,
           typography: typography,
           style: style,
         ).transform(
           (style) => style.copyWith(
             enabledStyle: style.enabledStyle.copyWith(
               focusedStyle: style.enabledStyle.focusedStyle.copyWith(color: Colors.transparent, width: 0),
               unfocusedStyle: style.enabledStyle.unfocusedStyle.copyWith(color: Colors.transparent, width: 0),
             ),
           ),
         ),
         iconStyle: FIconStyle(size: 15, color: colorScheme.mutedForeground),
         dividerStyle: FDividerStyles.inherit(
           colorScheme: colorScheme,
           style: style,
         ).horizontalStyle.copyWith(width: 2, padding: EdgeInsets.zero),
         loadingIndicatorStyle: FCircularIconProgressStyle.inherit(colorScheme: colorScheme),
       );
}
