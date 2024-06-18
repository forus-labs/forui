import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:forui/forui.dart';

part 'tabs_style.dart';

part 'tab_controller.dart';

/// An object that represents a tab entry in a group of tabs.
class FTabEntry {
  final String? _label;

  /// A raw label.
  final Widget? rawLabel;

  /// The content of a tab.
  final Widget content;

  /// Creates a [FTabs].
  FTabEntry({
    required this.content,
    String? label,
    this.rawLabel,
  })  : _label = label,
        assert((label != null && rawLabel == null) || (label == null && rawLabel != null),
            'Either a label or rawLabel must be provided');

  /// Returns either the provided raw label or the label text as a widget.
  Widget get label => _label != null ? Text(_label) : rawLabel!;
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
      ..add(IterableProperty<FTabEntry>('tabs', tabs))
      ..add(IntProperty('initialIndex', initialIndex))
      ..add(DiagnosticsProperty<FTabController?>('controller', controller))
      ..add(DiagnosticsProperty<FTabsStyle?>('style', style))
      ..add(ObjectFlagProperty<ValueChanged<int>?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('scrollable', scrollable));
  }

  @override
  State<FTabs> createState() => _FTabsState();
}

class _FTabsState extends State<FTabs> with SingleTickerProviderStateMixin {
  late int _selectedTab;
  late final FTabController _controller;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialIndex;
    _controller = FTabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final typography = theme.typography;
    final style = widget.style ?? context.theme.tabsStyle;
    final tabs = widget.tabs;
    final materialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);

    final widget_ = Material(
      color: Colors.transparent,
      child: Column(
        children: [
          DecoratedBox(
            decoration: style.decoration,
            child: TabBar(
              isScrollable: widget.scrollable,
              controller: widget.controller?._controller ?? _controller._controller,
              padding: style.padding,
              indicatorSize: style.indicatorSize,
              indicator: style.indicator,
              unselectedLabelStyle: style.unselectedLabel.scale(typography),
              labelStyle: style.selectedLabel.scale(typography),
              dividerColor: Colors.transparent,
              tabs: [
                for (final tab in tabs)
                  Tab(
                    height: style.height,
                    child: tab.label,
                  )
              ],
              onTap: (index) {
                setState(() {
                  _selectedTab = index;
                });
                widget.onTap?.call(_selectedTab);
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
            child: tabs[_selectedTab].content,
          ),
        ],
      ),
    );

    return materialLocalizations == null
        ? Localizations(
            locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
            delegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            child: widget_,
          )
        : widget_;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
