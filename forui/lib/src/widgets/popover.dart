import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A popover displays rich content in a portal that is aligned to a target.
///
/// See:
/// * https://forui.dev/docs/popover for working examples.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  /// The controller that shows and hides the follower. It initially hides the follower.
  final OverlayPortalController? controller;

  /// The popover's style.
  final FPopoverStyle? style;

  /// The anchor of the follower to which the [childAnchor] is aligned to. Defaults to [Alignment.topCenter].
  final Alignment followerAnchor;

  /// The anchor of the target to which the [followerAnchor] is aligned to. Defaults to [Alignment.bottomCenter].
  final Alignment childAnchor;

  /// The shifting strategy used to shift a follower when it overflows out of the viewport. Defaults to
  /// [FPortalFollowerShift.flip].
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  /// True if the popover is hidden when tapped outside of it. Defaults to true.
  final bool hideOnTapOutside;

  /// The follower.
  final ValueWidgetBuilder<FPopoverStyle> follower;

  /// The target.
  final Widget child;

  /// Creates a popover.
  const FPopover({
    required this.controller,
    required this.follower,
    required this.child,
    this.style,
    this.followerAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    super.key,
  });

  @override
  State<FPopover> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('followerAnchor', followerAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside, ifTrue: 'hideOnTapOutside'))
      ..add(DiagnosticsProperty('follower', follower));
  }
}

class _State extends State<FPopover> with SingleTickerProviderStateMixin {
  final Key _group = UniqueKey();
  late OverlayPortalController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OverlayPortalController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didUpdateWidget(covariant FPopover old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller = widget.controller ?? OverlayPortalController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverStyle;
    return FPortal(
      controller: _controller,
      followerAnchor: widget.followerAnchor,
      childAnchor: widget.childAnchor,
      shift: widget.shift,
      follower: (context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _controller.hide,
        },
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: style.margin,
            child: TapRegion(
              groupId: _group,
              onTapOutside: widget.hideOnTapOutside ? (_) => _controller.hide() : null,
              child: DecoratedBox(
                decoration: style.decoration,
                child: Padding(
                  padding: style.padding,
                  child: widget.follower(context, style, null),
                ),
              ),
            ),
          ),
        ),
      ),
      child: TapRegion(
        groupId: _group,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print('tapped');
            _controller.show();
            _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
          },
          child: widget.child,
        ),
      ),
    );
  }
}

/// The popover's style.
final class FPopoverStyle with Diagnosticable {
  /// The popover's decoration.
  final BoxDecoration decoration;

  /// The margin surrounding the popover. Defaults to `EdgeInsets.all(4)`.
  final EdgeInsets margin;

  /// The padding surrounding the popover's content. Defaults to `EdgeInsets.all(16)`.
  final EdgeInsets padding;

  /// Creates a [FPopoverStyle].
  const FPopoverStyle({
    required this.decoration,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.all(16),
  });

  /// Creates a [FPopoverStyle] that inherits its properties from [colorScheme] and [style].
  FPopoverStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : this(
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
            border: Border.all(
              width: style.borderWidth,
              color: colorScheme.border,
            ),
            boxShadow: const [
              // TODO: add constants for shadows.
              BoxShadow(
                color: Color(0x1a000000),
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
              BoxShadow(
                color: Color(0x1a000000),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
            ]
          ),
        );

  // TODO: other methods;
}
