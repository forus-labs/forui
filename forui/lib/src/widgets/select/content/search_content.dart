import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:meta/meta.dart';

typedef FSelectSearchData<T> = ({String query, Iterable<T> values});

// TODO: properties

@internal
class SearchContent<T> extends StatefulWidget {
  final ScrollController? controller;
  final FSelectContentStyle style;
  final bool first;
  final bool enabled;
  final bool scrollHandles;
  final ScrollPhysics physics;
  final FutureOr<Iterable<T>> Function(String) filter;
  final WidgetBuilder loadingBuilder;
  final List<FSelectItemMixin> Function(BuildContext, FSelectSearchData<T>) builder;
  final WidgetBuilder emptyBuilder;
  final Widget Function(BuildContext, Object?, StackTrace)? errorBuilder;

  const SearchContent({
    required this.controller,
    required this.style,
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
}

class _SearchContentState<T> extends State<SearchContent<T>> {
  final TextEditingController _textController = TextEditingController();
  late String _previous;
  late FutureOr<FSelectSearchData<T>> _data;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      if (_previous == _textController.text) {
        return;
      }

      _previous = _textController.text;
      setState(() {
        // DO NOT TRY TO CONVERT THIS TO AN ARROW EXPRESSION. Doing so changes the return type to a future, which
        // results in an assertion error being thrown.
        _data = _filter(_textController.text);
      });
    });
    _previous = _textController.text;
    _data = _filter('');
  }

  FutureOr<FSelectSearchData<T>> _filter(String query) {
    final values = widget.filter(query);
    return values is Future<Iterable<T>>
        ? values.then((values) => (query: query, values: values))
        : (query: query, values: values);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FTextField(
          controller: _textController,
          style: FTextFieldStyle.inherit(
            colorScheme: context.theme.colorScheme,
            typography: context.theme.typography,
            style: context.theme.style,
          ).transform(
            (style) => style.copyWith(
              enabledStyle: style.enabledStyle.copyWith(
                focusedStyle: style.enabledStyle.focusedStyle.copyWith(color: Colors.transparent, width: 0),
                unfocusedStyle: style.enabledStyle.unfocusedStyle.copyWith(color: Colors.transparent, width: 0),
              ),
            ),
          ),
          hint: localizations.selectSearchHint, // TODO: custom search hint
          prefixBuilder:
              (_, style, _) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0, end: 4.0),
                child: FIcon(FAssets.icons.search, size: 15, color: context.theme.colorScheme.mutedForeground),
              ),
        ),
        FDivider(style: context.theme.dividerStyles.horizontalStyle.copyWith(width: 2, padding: EdgeInsets.zero)),
        switch (_data) {
          final Future<FSelectSearchData<T>> future => FutureBuilder<FSelectSearchData<T>>(
            future: future,
            builder:
                (context, snapshot) => switch (snapshot.connectionState) {
                  ConnectionState.waiting => Center(child: widget.loadingBuilder(context)),
                  _ when snapshot.hasError && widget.errorBuilder != null => widget.errorBuilder!.call(
                    context,
                    snapshot.error,
                    snapshot.stackTrace!,
                  ),
                  _ => _content(snapshot.data ?? (query: '', values: [])),
                },
          ),
          final data => _content(data),
        },
      ],
    );
  }

  Widget _content(FSelectSearchData<T> data) {
    final children = widget.builder(context, data);
    if (children.isEmpty) {
      return widget.emptyBuilder(context);
    }

    return Expanded(
      child: Content<T>(
        controller: widget.controller,
        style: widget.style,
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
