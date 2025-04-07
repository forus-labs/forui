import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tabs.style.dart';

part 'tabs_style.dart';

part 'tab_controller.dart';

/// An object that represents a tab entry in a group of tabs.
class FTabEntry {
  /// A label.
  final Widget label;

  /// The content of a tab.
  final Widget child;

  /// Creates a [FTabs].
  const FTabEntry({required this.label, required this.child});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTabEntry && runtimeType == other.runtimeType && label == other.label && child == other.child;

  @override
  int get hashCode => label.hashCode ^ child.hashCode;
}

/// Allows switching between widgets through tabs.
///
/// See:
/// * https://forui.dev/docs/navigation/tabs for working examples.
/// * [FTabsStyle] for customizing tabs' appearance.
class FTabs extends StatefulWidget {
  /// The tab controller.
  final FTabController? controller;

  /// The style.
  final FTabsStyle? style;

  /// The initial tab that is selected.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [initialIndex] is not within the range '0 <= initialIndex < tabs.length`.
  final int initialIndex;

  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [scrollable] is true, then each tab is as wide as needed for its label and the entire [TabBar] is scrollable.
  /// Otherwise each tab gets an equal share of the available space.
  final bool scrollable;

  /// A callback that returns the tab that was tapped.
  final ValueChanged<int>? onPress;

  /// The tabs.
  final List<FTabEntry> children;

  /// Creates a [FTabs].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [children] is empty.
  /// * [initialIndex] is not within the range '0 <= initialIndex < tabs.length`.
  /// * [controller] index does not match the [initialIndex].
  FTabs({
    required this.children,
    this.initialIndex = 0,
    this.scrollable = false,
    this.controller,
    this.style,
    this.onPress,
    super.key,
  }) : assert(children.isNotEmpty, 'Must have at least 1 tab provided.'),
       assert(0 <= initialIndex && initialIndex < children.length, 'initialIndex must be within the range of tabs.'),
       assert(controller == null || controller.index == initialIndex, "Controller's index must match initialIndex."),
       assert(
         controller == null || controller.length == children.length,
         'Controller length must match the number of tabs.',
       );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(IntProperty('initialIndex', initialIndex))
      ..add(FlagProperty('scrollable', value: scrollable, ifTrue: 'scrollable'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(IterableProperty('children', children));
  }

  @override
  State<FTabs> createState() => _FTabsState();
}

class _FTabsState extends State<FTabs> with SingleTickerProviderStateMixin {
  late FTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        FTabController(initialIndex: widget.initialIndex, length: widget.children.length, vsync: this);
    _controller.addListener(_update);
  }

  @override
  void didUpdateWidget(covariant FTabs old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        _controller.removeListener(_update);
      }

      _controller =
          widget.controller ??
          FTabController(initialIndex: widget.initialIndex, length: widget.children.length, vsync: this);
      _controller.addListener(_update);
    }
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style ?? context.theme.tabsStyle;
    final localizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);

    final tabs = Material(
      color: Colors.transparent,
      child: Column(
        children: [
          DecoratedBox(
            decoration: style.decoration,
            child: TabBar(
              tabAlignment: widget.scrollable ? TabAlignment.start : TabAlignment.fill,
              tabs: [for (final tab in widget.children) _Tab(style: style, label: tab.label)],
              controller: _controller._controller,
              isScrollable: widget.scrollable,
              padding: style.padding,
              indicator: style.indicatorDecoration,
              indicatorSize: style.indicatorSize._value,
              dividerColor: Colors.transparent,
              labelStyle: style.selectedLabelTextStyle,
              unselectedLabelStyle: style.unselectedLabelTextStyle,
              onTap: (index) {
                widget.onPress?.call(index);
              },
            ),
          ),
          SizedBox(height: style.spacing),
          DefaultTextStyle(
            style: theme.typography.base.copyWith(
              fontFamily: theme.typography.defaultFontFamily,
              color: theme.colors.foreground,
            ),
            child: widget.children[_controller.index].child,
          ),
        ],
      ),
    );

    if (localizations == null) {
      return Localizations(
        locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: tabs,
      );
    }

    return tabs;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_update);
    }
    super.dispose();
  }
}

class _Tab extends StatefulWidget {
  final FTabsStyle style;
  final Widget label;

  const _Tab({required this.style, required this.label});

  @override
  State<_Tab> createState() => _TabState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

class _TabState extends State<_Tab> {
  FocusNode? _focus;
  bool _focused = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final updated = Focus.of(context);
    if (_focus != updated) {
      _focus?.removeListener(_handleFocusChange);
      _focus = updated..addListener(_handleFocusChange);
    }
  }

  @override
  Widget build(BuildContext _) => FFocusedOutline(
    style: widget.style.focusedOutlineStyle,
    focused: _focused,
    child: Tab(height: widget.style.height, child: widget.label),
  );

  void _handleFocusChange() => setState(() => _focused = _focus?.hasFocus ?? false);

  @override
  void dispose() {
    _focus?.removeListener(_handleFocusChange);
    super.dispose();
  }
}
