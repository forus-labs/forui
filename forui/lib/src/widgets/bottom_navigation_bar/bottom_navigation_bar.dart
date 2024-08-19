import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

/// A bottom navigation bar.
///
/// A bottom navigation bar is usually present at the bottom of root pages. It is used to navigate between a small
/// number of views, typically between three and five.
///
/// See:
/// * https://forui.dev/docs/bottom-navigation-bar for working examples.
/// * [FBottomNavigationBarStyle] for customizing a bottom navigation bar's appearance.
class FBottomNavigationBar extends StatelessWidget {
  /// Returns the [FBottomNavigationBarItemStyle] and currently selected index of the [FBottomNavigationBar] in the
  /// given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FBottomNavigationBar] in the given [context].
  static ({FBottomNavigationBarItemStyle itemStyle, bool current}) of(BuildContext context) {
    final _InheritedData? result = context.dependOnInheritedWidgetOfExactType<_InheritedData>();
    assert(result != null, 'No _InheritedData found in context');
    return (itemStyle: result!.itemStyle, current: result.current);
  }

  /// The style.
  final FBottomNavigationBarStyle? style;

  /// A callback for when an item is selected.
  final ValueChanged<int>? onChange;

  /// The index.
  final int? index;

  /// The children.
  final List<Widget> children;

  /// Creates a [FBottomNavigationBar] with [FBottomNavigationBarItem]s.
  const FBottomNavigationBar({
    required this.children,
    this.style,
    this.onChange,
    this.index,
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
                    onPress: () {
                      onChange?.call(i);
                    },
                    child: _InheritedData(
                      itemStyle: style.itemStyle,
                      current: index == i,
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

class _InheritedData extends InheritedWidget {
  final FBottomNavigationBarItemStyle itemStyle;
  final bool current;

  const _InheritedData({
    required this.itemStyle,
    required this.current,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedData old) => old.itemStyle != itemStyle || old.current != current;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', itemStyle))
      ..add(FlagProperty('current', value: current, ifTrue: 'current'));
  }
}

/// [FBottomNavigationBar]'s style.
class FBottomNavigationBarStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  final EdgeInsets padding;

  /// The item's style.
  final FBottomNavigationBarItemStyle itemStyle;

  /// Creates a [FBottomNavigationBarStyle].
  FBottomNavigationBarStyle({
    required this.decoration,
    required this.itemStyle,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarStyle] that inherits its properties from [colorScheme] and [typography].
  FBottomNavigationBarStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : decoration = BoxDecoration(
          border: Border(top: BorderSide(color: colorScheme.border)),
          color: colorScheme.background,
        ),
        padding = const EdgeInsets.all(5),
        itemStyle = FBottomNavigationBarItemStyle.inherit(
          colorScheme: colorScheme,
          typography: typography,
        );

  /// Returns a copy of this [FBottomNavigationBarStyle] with the given properties replaced.
  @useResult
  FBottomNavigationBarStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsets? padding,
    FBottomNavigationBarItemStyle? item,
  }) =>
      FBottomNavigationBarStyle(
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
        itemStyle: item ?? this.itemStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBottomNavigationBarStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          itemStyle == other.itemStyle;

  @override
  int get hashCode => decoration.hashCode ^ padding.hashCode ^ itemStyle.hashCode;
}
