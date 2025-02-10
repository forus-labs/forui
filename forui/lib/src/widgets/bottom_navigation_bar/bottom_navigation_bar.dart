import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_bar.style.dart';

/// A bottom navigation bar.
///
/// A bottom navigation bar is usually present at the bottom of root pages. It is used to navigate between a small
/// number of views, typically between three and five.
///
/// See:
/// * https://forui.dev/docs/navigation/bottom-navigation-bar for working examples.
/// * [FBottomNavigationBarStyle] for customizing a bottom navigation bar's appearance.
/// * [FBottomNavigationBarItem] for the items in a bottom navigation bar.
class FBottomNavigationBar extends StatelessWidget {
  /// The style.
  final FBottomNavigationBarStyle? style;

  /// A callback for when an item is selected.
  final ValueChanged<int>? onChange;

  /// The index.
  final int index;

  /// The children.
  final List<Widget> children;

  /// Creates a [FBottomNavigationBar] with [FBottomNavigationBarItem]s.
  ///
  /// See [FBottomNavigationBarItem] for the items in a bottom navigation bar.
  const FBottomNavigationBar({
    required this.children,
    this.style,
    this.onChange,
    this.index = -1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.bottomNavigationBarStyle;
    return DecoratedBox(
      decoration: style.decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: style.padding.copyWith(
            bottom: style.padding.bottom + (MediaQuery.viewPaddingOf(context).bottom * 2 / 3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final (i, child) in children.indexed)
                Expanded(
                  child: FTappable.animated(
                    focusedOutlineStyle: style.focusedOutlineStyle,
                    onPress: () => onChange?.call(i),
                    child: FBottomNavigationBarData(
                      itemStyle: style.itemStyle,
                      selected: index == i,
                      child: child,
                    ),
                  ),
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
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(IntProperty('initialIndex', index));
  }
}

/// A FBottomNavigationBar]'s data.
class FBottomNavigationBarData extends InheritedWidget {
  /// Returns the [FBottomNavigationBarItemStyle] and currently selected index of the [FBottomNavigationBar] in the
  /// given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FBottomNavigationBar] in the given [context].
  @useResult
  static FBottomNavigationBarData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FBottomNavigationBarData>();
    assert(result != null, 'No FBottomNavigationBarData found in context');
    return result!;
  }

  /// The item's style.
  final FBottomNavigationBarItemStyle itemStyle;

  /// Whether the item is currently selected.
  final bool selected;

  /// Creates a [FBottomNavigationBarData].
  const FBottomNavigationBarData({
    required this.itemStyle,
    required this.selected,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FBottomNavigationBarData old) => old.itemStyle != itemStyle || old.selected != selected;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemStyle', itemStyle))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'));
  }
}

/// [FBottomNavigationBar]'s style.
class FBottomNavigationBarStyle with Diagnosticable, _$FBottomNavigationBarStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsets padding;

  /// The item's focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The item's style.
  @override
  final FBottomNavigationBarItemStyle itemStyle;

  /// Creates a [FBottomNavigationBarStyle].
  FBottomNavigationBarStyle({
    required this.decoration,
    required this.focusedOutlineStyle,
    required this.itemStyle,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarStyle] that inherits its properties from [colorScheme] and [typography].
  FBottomNavigationBarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colorScheme.border)),
            color: colorScheme.background,
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          itemStyle: FBottomNavigationBarItemStyle.inherit(
            colorScheme: colorScheme,
            typography: typography,
          ),
        );
}
