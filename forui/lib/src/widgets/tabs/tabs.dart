import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter/foundation.dart';

part 'tabs_style.dart';

part 'tab_content.dart';

part 'tab_controller.dart';

/// A [FTabs] that allows switching between tabs.
class FTabs extends StatefulWidget {
  /// The tab and it's corresponding view.
  final List<MapEntry<String, Widget>> tabs;

  /// The initial tab that is selected.
  final int initialIndex;

  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [isScrollable] is true, then each tab is as wide as needed for its label
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
  const FTabs({
    required this.tabs,
    this.initialIndex = 0,
    this.scrollable = false,
    this.controller,
    this.style,
    this.onTap,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<MapEntry<String, Widget>>('tabs', tabs))
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
    final style = widget.style ?? context.theme.tabsStyle;
    final tabs = widget.tabs;

    return Column(
      children: [
        DecoratedBox(
          decoration: style.decoration,
          child: TabBar(
            isScrollable: widget.scrollable,
            controller: widget.controller?._controller ?? _controller._controller,
            padding: style.padding,
            indicatorSize: style.indicatorSize,
            indicator: style.indicator,
            unselectedLabelStyle: style.unselectedLabel,
            labelStyle: style.selectedLabel,
            dividerColor: Colors.transparent,
            tabs: [
              for (final child in tabs)
                Tab(
                  height: style.height,
                  child: Text(child.key),
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
        tabs[_selectedTab].value,
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
