import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create bottom-navigation-bar
  /// ```
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
  const FBottomNavigationBar({required this.children, this.style, this.onChange, this.index = -1, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.bottomNavigationBarStyle;
    final padding = style.padding.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    return DecoratedBox(
      decoration: style.decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: padding.copyWith(bottom: padding.bottom + (MediaQuery.viewPaddingOf(context).bottom * 2 / 3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final (i, child) in children.indexed)
                Expanded(
                  child: FBottomNavigationBarData(
                    itemStyle: style.itemStyle,
                    index: i,
                    selected: i == index,
                    onChange: onChange,
                    child: child,
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
      ..add(IntProperty('index', index));
  }
}

/// A FBottomNavigationBar]'s data.
class FBottomNavigationBarData extends InheritedWidget {
  /// Returns the [FBottomNavigationBarItemStyle] and current states of the [FBottomNavigationBar] in the given
  /// [context].
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

  /// The item's index.
  final int index;

  /// True if the item is selected.
  final bool selected;

  /// A callback for when an item is selected.
  final ValueChanged<int>? onChange;

  /// Creates a [FBottomNavigationBarData].
  const FBottomNavigationBarData({
    required this.itemStyle,
    required this.index,
    required this.selected,
    required this.onChange,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FBottomNavigationBarData old) =>
      old.itemStyle != itemStyle || old.index != index || old.selected != selected;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemStyle', itemStyle))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', ifFalse: 'not selected'))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }
}

/// [FBottomNavigationBar]'s style.
class FBottomNavigationBarStyle with Diagnosticable, _$FBottomNavigationBarStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The item's style.
  @override
  final FBottomNavigationBarItemStyle itemStyle;

  /// Creates a [FBottomNavigationBarStyle].
  const FBottomNavigationBarStyle({
    required this.decoration,
    required this.itemStyle,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarStyle] that inherits its properties.
  FBottomNavigationBarStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border)), color: colors.background),
        itemStyle: FBottomNavigationBarItemStyle.inherit(colors: colors, typography: typography, style: style),
      );
}
