import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:forui/forui.dart';

part 'tabs_style.dart';

part 'tab_controller.dart';

/// An object that represents a tab entry in a group of tabs.
class FTabEntry {
  /// The label.
  final String? label;

  /// A raw label.
  final Widget? rawLabel;

  /// The content of a tab.
  final Widget content;

  /// Creates a [FTabs].
  FTabEntry({
    required this.content,
    this.label,
    this.rawLabel,
  }) : assert(label == null || rawLabel == null,
            'Cannot provide both a label and a rawLabel.');
}

/// A [FTabs] that allows switching between tabs.
class FTabs extends StatefulWidget {
  /// The tab and it's corresponding view.
  final List<FTabEntry> tabs;

  /// The initial tab that is selected.
  final int initialIndex;

  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [scrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool scrollable;

  /// The tab controller.
  final FTabController? controller;

  /// The style.
  final FTabsStyle? style;

  /// A callback that returns the tab that was tapped.
  final ValueChanged<int>? onTap;

  /// Creates a [FTabs].
  FTabs({
    required this.tabs,
    this.initialIndex = 0,
    this.scrollable = false,
    this.controller,
    this.style,
    this.onTap,
    super.key,
  }) : assert(tabs.isNotEmpty, 'Must have at least 1 tab provided');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('tabs', tabs))
      ..add(IntProperty('initialIndex', initialIndex))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(
          FlagProperty('scrollable', value: scrollable, ifTrue: 'scrollable'));
  }

  @override
  State<FTabs> createState() => _FTabsState();
}

class _FTabsState extends State<FTabs> with SingleTickerProviderStateMixin {
  late int _index;
  late final FTabController _controller;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = FTabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final typography = theme.typography;
    final style = widget.style ?? context.theme.tabsStyle;
    final tabs = widget.tabs;
    final materialLocalizations =
        Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);

    // ignore_for_file: no_leading_underscores_for_local_identifiers
    final _child = Material(
      color: Colors.transparent,
      child: Column(
        children: [
          DecoratedBox(
            decoration: style.decoration,
            child: TabBar(
              tabs: [
                for (final tab in tabs)
                  Tab(
                    height: style.height,
                    child: tab.rawLabel ?? Text(tab.label!),
                  )
              ],
              controller: (widget.controller ?? _controller)._controller,
              isScrollable: widget.scrollable,
              padding: style.padding,
              indicator: style.indicator,
              indicatorSize: style.indicatorSize,
              dividerColor: Colors.transparent,
              labelStyle: style.selectedLabel.scale(typography),
              unselectedLabelStyle: style.unselectedLabel.scale(typography),
              onTap: (index) {
                setState(() => _index = index);
                widget.onTap?.call(_index);
              },
            ),
          ),
          SizedBox(height: style.spacing),
          // A workaround to ensure any widgets under Tabs do not revert to material text style
          // TODO: abstract out logic
          DefaultTextStyle(
            style: theme.typography.toTextStyle(
              fontSize: theme.typography.base,
              color: theme.colorScheme.foreground,
            ),
            child: tabs[_index].content,
          ),
        ],
      ),
    );

    return materialLocalizations == null
        ? Localizations(
            locale: Localizations.maybeLocaleOf(context) ??
                const Locale('en', 'US'),
            delegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            child: _child,
          )
        : _child;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
