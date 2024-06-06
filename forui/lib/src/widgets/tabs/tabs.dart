import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter/foundation.dart';

part 'tabs_style.dart';

/// A [FTabs] that allows switching between tabs.
class FTabs extends StatelessWidget {
  /// The tab and it's corresponding view.
  final List<(String, Widget)> tabs;

  /// The heigh of the toggle bar.
  final double? height;

  /// The padding around the tabs.
  final EdgeInsets padding;

  /// A callback that returns the tab that was tapped.
  final ValueChanged<int>? onTap;

  /// The initial tab that is displayed.
  final int initialIndex;

  /// The style.
  final FTabsStyle? style;

  /// Creates a [FTabs].
  const FTabs({
    required this.tabs,
    this.height,
    this.padding = EdgeInsets.zero,
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
            Container(
              padding: padding,
              child: DecoratedBox(
                decoration: style.decoration,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: onTap,
                  padding: style.padding,
                  unselectedLabelColor: style.unselectedColor,
                  unselectedLabelStyle: style.unselectedLabel,
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
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [for (final (_, widget) in tabs) widget],
              ),
            ),
          ],
        ),
      );
  }
}
