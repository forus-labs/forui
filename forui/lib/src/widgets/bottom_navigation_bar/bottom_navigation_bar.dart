import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

part 'bottom_navigation_bar_item.dart';

/// A bottom navigation bar.
///
/// A bottom navigation bar is usually present at the bottom of root pages. It is used to navigate between a small
/// number of views, typically between three and five.
///
/// See:
/// * https://forui.dev/docs/bottom-navigation-bar for working examples.
/// * [FBottomNavigationBarStyle] for customizing a card's appearance.
class FBottomNavigationBar extends StatelessWidget {
  /// The style.
  final FBottomNavigationBarStyle? style;

  /// The items.
  final List<Widget> items;

  /// A callback for when an item is selected.
  final ValueChanged<int>? onChange;

  /// Creates a [FBottomNavigationBar] with [FBottomNavigationBarItem]s.
  FBottomNavigationBar({
    required List<FBottomNavigationBarItem> items,
    this.style,
    this.onChange,
    int index = -1,
    super.key,
  }) : items = items
            .mapIndexed(
              (currentIndex, item) => _FBottomNavigationBarItem(
                item: item,
                current: index == currentIndex,
                style: style?.item,
              ),
            )
            .toList();

  /// Creates a [FBottomNavigationBar] with [Widget]s.
  const FBottomNavigationBar.raw({
    required this.items,
    this.style,
    this.onChange,
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
            bottom: style.padding.bottom + (MediaQuery.of(context).viewPadding.bottom * 2 / 3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items
                .mapIndexed(
                  (index, item) => Expanded(
                    child: FTappable(
                      child: item,
                      onTap: () => onChange?.call(index),
                    ),
                  ),
                )
                .toList(),
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
      ..add(IterableProperty('items', items))
      ..add(ObjectFlagProperty.has('onSelect', onChange));
  }
}

/// [FBottomNavigationBar]'s style.
class FBottomNavigationBarStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  final EdgeInsets padding;

  /// The item's style.
  final FBottomNavigationBarItemStyle item;

  /// Creates a [FBottomNavigationBarStyle].
  FBottomNavigationBarStyle({
    required this.decoration,
    required this.item,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarStyle] that inherits its properties from [colorScheme] and [typography].
  FBottomNavigationBarStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : decoration = BoxDecoration(
          border: Border(top: BorderSide(color: colorScheme.border)),
          color: colorScheme.background,
        ),
        padding = const EdgeInsets.all(5),
        item = FBottomNavigationBarItemStyle.inherit(
          colorScheme: colorScheme,
          typography: typography,
        );

  /// Returns a copy of this [FBottomNavigationBarStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FBottomNavigationBarStyle(
  ///   decoration: ...,
  ///   padding: ...,
  ///   ...
  /// );
  ///
  /// final copy = style.copyWith(padding: ...);
  ///
  /// print(style.decoration == copy.decoration); // true
  /// print(style.padding == copy.padding); // false
  /// ```
  @useResult
  FBottomNavigationBarStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsets? padding,
    FBottomNavigationBarItemStyle? item,
  }) =>
      FBottomNavigationBarStyle(
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
        item: item ?? this.item,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('item', item));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBottomNavigationBarStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          item == other.item;

  @override
  int get hashCode => decoration.hashCode ^ padding.hashCode ^ item.hashCode;
}
