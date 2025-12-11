import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tab_controller.dart';

part 'tabs.control.dart';

part 'tabs.design.dart';

part 'tabs_style.dart';

/// An object that represents a tab entry in a group of tabs.
class FTabEntry {
  /// A label.
  final Widget label;

  /// The content of a tab.
  final Widget child;

  /// Creates a [FTabEntry].
  const FTabEntry({required this.label, required this.child});

  /// Creates a [FTabEntry].
  ///
  /// This is identical to [FTabEntry.new], allowing dot-shorthand construction.
  const factory FTabEntry.entry({required Widget label, required Widget child}) = FTabEntry;

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
  /// Controls the tab value.
  final FTabControl control;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tabs
  /// ```
  final FTabsStyle Function(FTabsStyle style)? style;

  /// Whether this tab bar can be scrolled horizontally. Defaults to false.
  ///
  /// If [scrollable] is true, then each tab is as wide as needed for its label and the entire [TabBar] is scrollable.
  /// Otherwise each tab gets an equal share of the available space.
  final bool scrollable;

  /// How the tab should respond to user input.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// A callback that is triggered when a tab is pressed. It is called **before** the tab switching animation begins
  /// and the controller is updated.
  final ValueChanged<int>? onPress;

  /// The mouse cursor. Defaults to [MouseCursor.defer].
  final MouseCursor mouseCursor;

  /// The tabs.
  final List<FTabEntry> children;

  /// Creates a [FTabs].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [children] is empty.
  FTabs({
    required this.children,
    this.control = const .managed(),
    this.scrollable = false,
    this.physics,
    this.style,
    this.onPress,
    this.mouseCursor = .defer,
    super.key,
  }) : assert(children.isNotEmpty, 'Must provide at least 1 tab.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('scrollable', value: scrollable, ifTrue: 'scrollable'))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
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
    _controller = widget.control.create(_update, this, widget.children.length);
  }

  @override
  void didUpdateWidget(covariant FTabs old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _update, this, widget.children.length).$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _update);
    super.dispose();
  }

  void _update() {
    if (!_controller._controller.indexIsChanging) {
      if (widget.control case Managed(:final onChange)) {
        onChange?.call(_controller.index);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style?.call(context.theme.tabsStyle) ?? context.theme.tabsStyle;
    final localizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);

    final tabs = Material(
      color: Colors.transparent,
      child: Column(
        children: [
          DecoratedBox(
            decoration: style.decoration,
            child: TabBar(
              tabAlignment: widget.scrollable ? .start : .fill,
              tabs: [for (final tab in widget.children) _Tab(style: style, label: tab.label)],
              controller: _controller._controller,
              isScrollable: widget.scrollable,
              physics: widget.physics,
              padding: style.padding,
              mouseCursor: widget.mouseCursor,
              indicator: style.indicatorDecoration,
              indicatorSize: style.indicatorSize._value,
              dividerColor: Colors.transparent,
              labelStyle: style.selectedLabelTextStyle,
              unselectedLabelStyle: style.unselectedLabelTextStyle,
              onTap: widget.onPress,
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
