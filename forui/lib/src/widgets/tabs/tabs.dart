import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter/foundation.dart';

part 'tabs_style.dart';

part 'tab_content.dart';

/// A [FTabs] that allows switching between tabs.
class FTabs extends StatefulWidget {
  /// The tab and it's corresponding view.
  final List<MapEntry<String, Widget>> tabs;

  /// The height of the tab button.
  final double? height;

  /// The spacing between the tabs and its content.
  final double spacing;

  /// A callback that returns the tab that was tapped.
  final ValueChanged<int>? onTap;

  /// The initial tab that is selected.
  final int initialIndex;

  /// The style.
  final FTabsStyle? style;

  /// Creates a [FTabs].
  const FTabs({
    required this.tabs,
    this.height,
    this.spacing = 10,
    this.onTap,
    this.initialIndex = 0,
    this.style,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<MapEntry<String, Widget>>('tabs', tabs))
      ..add(DoubleProperty('height', height))
      ..add(DiagnosticsProperty<double>('spacing', spacing))
      ..add(ObjectFlagProperty<ValueChanged<int>?>.has('onTap', onTap))
      ..add(IntProperty('initialIndex', initialIndex))
      ..add(DiagnosticsProperty<FTabsStyle?>('style', style));
  }

  @override
  State<FTabs> createState() => _FTabsState();
}

class _FTabsState extends State<FTabs> with SingleTickerProviderStateMixin {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.tabsStyle;
    final tabs = widget.tabs;

    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: tabs.length,
      child: Column(
        children: [
          DecoratedBox(
            decoration: style.decoration,
            child: TabBar(
              padding: style.padding,
              indicatorSize: style.indicatorSize,
              indicator: style.indicator,
              unselectedLabelStyle: style.unselectedLabel,
              labelStyle: style.selectedLabel,
              dividerColor: Colors.transparent,
              tabs: [
                for (final child in tabs)
                  Tab(
                    height: widget.height,
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
          SizedBox(height: widget.spacing),
          tabs[_selectedTab].value,
        ],
      ),
    );
  }
}
