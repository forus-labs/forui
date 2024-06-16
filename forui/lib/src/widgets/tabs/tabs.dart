import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter/foundation.dart';

part 'tabs_style.dart';

part 'tab_content.dart';

/// A [FTabs] that allows switching between tabs.
class FTabs extends StatelessWidget {
  /// The tab and it's corresponding view.
  final List<(String, Widget)> tabs;

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
    this.spacing = 2,
    this.onTap,
    this.initialIndex = 0,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.tabsStyle;

    return DefaultTabController(
      initialIndex: initialIndex,
      length: tabs.length,
      child: Column(
        children: [
          DecoratedBox(
            decoration: style.decoration,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: onTap,
              padding: style.padding,
              unselectedLabelStyle: style.unselectedLabel,
              unselectedLabelColor: style.unselectedColor,
              labelStyle: style.selectedLabel,
              labelColor: style.selectedColor,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicator: style.indicator,
              tabs: [
                for (final (text, _) in tabs)
                  Tab(
                    height: height,
                    child: Text(text),
                  )
              ],
            ),
          ),
          SizedBox(height: spacing),
          Flexible(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [for (final (_, widget) in tabs) widget],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<(String, Widget)>('tabs', tabs))
      ..add(DoubleProperty('height', height))
      ..add(DiagnosticsProperty<double>('spacing', spacing))
      ..add(ObjectFlagProperty<ValueChanged<int>?>.has('onTap', onTap))
      ..add(IntProperty('initialIndex', initialIndex))
      ..add(DiagnosticsProperty<FTabsStyle?>('style', style));
  }
}
