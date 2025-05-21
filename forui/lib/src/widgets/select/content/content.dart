import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/scroll_handle.dart';

part 'content.style.dart';

@internal
class SelectContentData<T> extends InheritedWidget {
  final FSelectSectionStyle style;
  final bool enabled;
  final bool first;
  final ValueChanged<BuildContext> ensureVisible;

  const SelectContentData({
    required this.style,
    required this.enabled,
    required this.first,
    required this.ensureVisible,
    required super.child,
    super.key,
  });

  static SelectContentData<T> of<T>(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SelectContentData<T>>();
    assert(
      result != null,
      "No SelectContentData found in context. Try explicitly specifying FSelect's type parameter, i.e. FSelect<String>.",
    );
    return result!;
  }

  @override
  bool updateShouldNotify(SelectContentData<T> old) =>
      style != old.style || first != old.first || enabled != old.enabled || ensureVisible != old.ensureVisible;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(FlagProperty('first', value: first, ifTrue: 'first'))
      ..add(ObjectFlagProperty('ensureVisible', ensureVisible, ifPresent: 'ensureVisible'));
  }
}

@internal
class Content<T> extends StatefulWidget {
  final ScrollController? controller;
  final FSelectContentStyle style;
  final bool first;
  final bool enabled;
  final bool scrollHandles;
  final ScrollPhysics physics;
  final List<FSelectItemMixin> children;

  const Content({
    required this.controller,
    required this.style,
    required this.first,
    required this.enabled,
    required this.scrollHandles,
    required this.physics,
    required this.children,
    super.key,
  });

  @override
  State<Content<T>> createState() => _ContentState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('first', value: first, ifTrue: 'first'))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(FlagProperty('scrollHandles', value: scrollHandles, ifTrue: 'scroll handles'))
      ..add(DiagnosticsProperty('physics', physics));
  }
}

class _ContentState<T> extends State<Content<T>> {
  late ScrollController _controller;
  bool _up = false;
  bool _down = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(_updateHandles);
  }

  @override
  void didUpdateWidget(covariant Content<T> old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller?.removeListener(_updateHandles);
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? ScrollController();
      _controller.addListener(_updateHandles);
    }
  }

  void _updateHandles() {
    if (_controller.positions.isEmpty || !_controller.position.hasContentDimensions) {
      return;
    }

    final up = 0 < _controller.position.extentBefore;
    final down = 0 < _controller.position.extentAfter;
    if (up != _up || down != _down) {
      setState(() {
        _up = up;
        _down = down;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = SelectContentData<T>(
      style: widget.style.sectionStyle,
      first: false,
      enabled: widget.enabled,
      ensureVisible: _ensureVisible,
      child: Padding(
        padding: widget.style.padding,
        child: ListView(
          controller: _controller,
          padding: EdgeInsets.zero,
          physics: widget.physics,
          shrinkWrap: true,
          children: [
            if (widget.children.firstOrNull case final first?)
              SelectContentData<T>(
                style: widget.style.sectionStyle,
                first: widget.first,
                enabled: widget.enabled,
                ensureVisible: _ensureVisible,
                child: first,
              ),
            ...widget.children.skip(1),
          ],
        ),
      ),
    );

    if (widget.scrollHandles) {
      content = Stack(
        children: [
          NotificationListener<ScrollMetricsNotification>(
            onNotification: (_) {
              _updateHandles();
              return false;
            },
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: content,
            ),
          ),
          if (_up) ScrollHandle.up(controller: _controller, style: widget.style.scrollHandleStyle),

          if (_down) ScrollHandle.down(controller: _controller, style: widget.style.scrollHandleStyle),
        ],
      );
    }

    return content;
  }

  Future<void> _ensureVisible(BuildContext context) async {
    await Scrollable.ensureVisible(context);
    // There is an edge case, when at max scroll extent, the first visible item, if selected, remains partially obscured
    // by the scroll handle.
    if (widget.scrollHandles && 0 < _controller.offset && _controller.offset < _controller.position.maxScrollExtent) {
      _controller.jumpTo(_controller.offset - (widget.style.scrollHandleStyle.iconStyle.size ?? 0));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateHandles);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// An [FSelect]'s contents style.
class FSelectContentStyle with Diagnosticable, _$FSelectContentStyleFunctions {
  /// A section's style.
  @override
  final FSelectSectionStyle sectionStyle;

  /// A scroll handle's style.
  @override
  final FSelectScrollHandleStyle scrollHandleStyle;

  /// The padding surrounding the content. Defaults to `const EdgeInsets.symmetric(vertical: 5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FSelectContentStyle].
  const FSelectContentStyle({
    required this.sectionStyle,
    required this.scrollHandleStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 5),
  });

  /// Creates a [FSelectContentStyle] that inherits from the given [FColors], [FStyle], and [FTypography].
  FSelectContentStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
    : this(
        sectionStyle: FSelectSectionStyle.inherit(colors: colors, style: style, typography: typography),
        scrollHandleStyle: FSelectScrollHandleStyle.inherit(colors: colors),
      );
}
