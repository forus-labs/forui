import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'scroll_handle.style.dart';

@internal
class ScrollHandle extends StatefulWidget {
  final ScrollController controller;
  final FSelectScrollHandleStyle style;
  final Alignment alignment;
  final SvgAsset icon;

  ScrollHandle.up({required this.controller, required this.style, super.key})
      : alignment = Alignment.topCenter,
        icon = FAssets.icons.chevronUp;

  ScrollHandle.down({required this.controller, required this.style, super.key})
      : alignment = Alignment.bottomCenter,
        icon = FAssets.icons.chevronDown;

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
    final scroll = widget.alignment == Alignment.topCenter ? _up : _down;
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
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: SizedBox(
            width: double.infinity,
            child: ColoredBox(
              color: widget.style.background,
              child: FIcon(widget.icon, color: widget.style.color, size: widget.style.size),
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

    final ms = currentOffset / widget.style.pixelsPerMillisecond;

    await widget.controller.animateTo(
      0,
      duration: Duration(microseconds: (ms * 1000).round()),
      curve: Curves.linear,
    );
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
    final ms = distance / widget.style.pixelsPerMillisecond;

    await widget.controller.animateTo(
      maxScrollExtent,
      duration: Duration(microseconds: (ms * 1000).round()),
      curve: Curves.linear,
    );
  }
}

/// A [FSelect] content scroll handle's style.
class FSelectScrollHandleStyle with Diagnosticable, _$FSelectScrollHandleStyleFunctions {
  /// The handle icon's color.
  @override
  final Color color;

  /// The background color.
  @override
  final Color background;

  /// The handle icon's size. Defaults to 17.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the size <= 0.
  @override
  final double size;

  /// The duration to wait before scrolling. Defaults to 200ms.
  @override
  final Duration enterDuration;

  /// The number of pixels per millisecond for the scroll animation. Defaults to 0.2.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the pixels per millisecond <= 0.
  @override
  final double pixelsPerMillisecond;

  /// Creates a [FSelectScrollHandleStyle].
  const FSelectScrollHandleStyle({
    required this.color,
    required this.background,
    this.size = 17,
    this.enterDuration = const Duration(milliseconds: 200),
    this.pixelsPerMillisecond = 0.2,
  }) : assert(0 < size, 'The size must be greater than 0.'),
        assert(0 < pixelsPerMillisecond, 'The pixels per millisecond must be greater than 0.');

  /// Creates a [FSelectScrollHandleStyle] that inherits from the given [colorScheme].
  FSelectScrollHandleStyle.inherit({required FColorScheme colorScheme})
      : this(color: colorScheme.primary, background: colorScheme.background);
}
