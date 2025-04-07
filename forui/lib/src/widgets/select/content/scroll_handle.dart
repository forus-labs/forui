import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'scroll_handle.style.dart';

@internal
class ScrollHandle extends StatefulWidget {
  final ScrollController controller;
  final FSelectScrollHandleStyle style;
  final Alignment alignment;
  final IconData icon;

  const ScrollHandle.up({required this.controller, required this.style, super.key})
    : alignment = Alignment.topCenter,
      icon = FIcons.chevronUp;

  const ScrollHandle.down({required this.controller, required this.style, super.key})
    : alignment = Alignment.bottomCenter,
      icon = FIcons.chevronDown;

  @override
  State<ScrollHandle> createState() => _ScrollHandleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

class _ScrollHandleState extends State<ScrollHandle> {
  bool _hovered = false;
  int _monotonic = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final (scroll, label) = switch (widget.alignment) {
      Alignment.topCenter => (_up, localizations.selectScrollUpSemanticsLabel),
      _ => (_down, localizations.selectScrollDownSemanticsLabel),
    };

    return Align(
      alignment: widget.alignment,
      child: MouseRegion(
        onEnter: (_) {
          _hovered = true;
          scroll();
        },
        onExit: (_) {
          _hovered = false;
          _monotonic++;
          widget.controller.jumpTo(widget.controller.offset);
        },
        child: Listener(
          onPointerDown: (_) => scroll(),
          onPointerUp: (_) {
            _monotonic++;
            if (!_hovered) {
              widget.controller.jumpTo(widget.controller.offset);
            }
          },
          child: Semantics(
            label: label,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: SizedBox(
                width: double.infinity,
                child: ColoredBox(
                  color: widget.style.background,
                  child: IconTheme(data: widget.style.iconStyle, child: Icon(widget.icon)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _up() async {
    final current = _monotonic;
    await Future.delayed(widget.style.enterDuration);
    if (current != _monotonic) {
      return;
    }

    final currentOffset = widget.controller.offset;
    if (currentOffset <= 0) {
      return;
    }

    final ms = currentOffset / (widget.style.pixelsPerSecond / 1000);

    await widget.controller.animateTo(0, duration: Duration(microseconds: (ms * 1000).round()), curve: Curves.linear);
  }

  Future<void> _down() async {
    final current = _monotonic;
    await Future.delayed(widget.style.enterDuration);
    if (current != _monotonic) {
      return;
    }

    final currentOffset = widget.controller.offset;
    final maxScrollExtent = widget.controller.position.maxScrollExtent;
    if (maxScrollExtent <= currentOffset) {
      return;
    }

    final distance = maxScrollExtent - currentOffset;
    final ms = distance / (widget.style.pixelsPerSecond / 1000);

    await widget.controller.animateTo(
      maxScrollExtent,
      duration: Duration(microseconds: (ms * 1000).round()),
      curve: Curves.linear,
    );
  }
}

/// A [FSelect] content scroll handle's style.
class FSelectScrollHandleStyle with Diagnosticable, _$FSelectScrollHandleStyleFunctions {
  /// The handle icon's style.
  @override
  final IconThemeData iconStyle;

  /// The background color.
  @override
  final Color background;

  /// The duration to wait before scrolling. Defaults to 200ms.
  @override
  final Duration enterDuration;

  /// The number of pixels to scroll per second. Defaults to 200.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the pixels per second <= 0.
  @override
  final double pixelsPerSecond;

  /// Creates a [FSelectScrollHandleStyle].
  const FSelectScrollHandleStyle({
    required this.background,
    required this.iconStyle,
    this.enterDuration = const Duration(milliseconds: 200),
    this.pixelsPerSecond = 200,
  }) : assert(0 < pixelsPerSecond, 'The pixels per second must be greater than 0.');

  /// Creates a [FSelectScrollHandleStyle] that inherits its properties.
  FSelectScrollHandleStyle.inherit({required FColors colors})
    : this(iconStyle: IconThemeData(color: colors.primary, size: 17), background: colors.background);
}
