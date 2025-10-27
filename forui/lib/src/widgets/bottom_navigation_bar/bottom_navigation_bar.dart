import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

part 'bottom_navigation_bar.design.dart';

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
  final FBottomNavigationBarStyle Function(FBottomNavigationBarStyle style)? style;

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
    final style = this.style?.call(context.theme.bottomNavigationBarStyle) ?? context.theme.bottomNavigationBarStyle;
    final padding = style.padding.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    Widget bar = DecoratedBox(
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

    if (style.backgroundFilter case final filter?) {
      bar = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(filter: filter, child: Container()),
            ),
          ),
          bar,
        ],
      );
    }

    return bar;
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

/// A [FBottomNavigationBar]'s data.
class FBottomNavigationBarData extends InheritedWidget {
  /// Returns the [FBottomNavigationBarItemStyle] and current states of the [FBottomNavigationBar] in the given [context].
  @useResult
  static FBottomNavigationBarData of(BuildContext context) {
    assert(debugCheckHasAncestor<FBottomNavigationBarData>('$FBottomNavigationBar', context));
    return context.dependOnInheritedWidgetOfExactType<FBottomNavigationBarData>()!;
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
  ///
  /// ## Removing the top border
  /// By default, both [FBottomNavigationBar] and [FScaffold.footer] specify a top border. When used together, the
  /// top border must be removed from both [FBottomNavigationBarStyle.decoration] and [FScaffoldStyle.footerDecoration]
  /// for the changes to take effect.
  @override
  final BoxDecoration decoration;

  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  @override
  final ImageFilter? backgroundFilter;

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
    this.backgroundFilter,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarStyle] that inherits its properties.
  FBottomNavigationBarStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
          color: colors.background,
        ),
        itemStyle: FBottomNavigationBarItemStyle.inherit(colors: colors, typography: typography, style: style),
      );
}
