import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
class FPopoverController extends ChangeNotifier {
  static final _fadeTween = Tween<double>(begin: 0, end: 1);
  static final _scaleTween = Tween<double>(begin: 0.95, end: 1);

  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FPopoverController] with the given [vsync] and animation [duration].
  FPopoverController({required TickerProvider vsync, duration = const Duration(milliseconds: 100)}) {
    _animation = AnimationController(vsync: vsync, duration: duration);
    _fade = _fadeTween.animate(_animation);
    _scale = _scaleTween.animate(_animation);
  }

  /// Convenience method for toggling the current [isShowing] status.
  ///
  /// This method should typically not be called while the widget tree is being
  /// rebuilt.
  Future<void> toggle() async => shown ? hide() : show();

  /// Shows the popover.
  ///
  /// If [shown] is already true, calling this method brings the popover it controls to the top.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> show() async {
    _overlay.show();
    await _animation.forward();
  }

  /// Hides the popover.
  ///
  /// Once hidden, the popover will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the popover may lose states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    await _animation.reverse();
    _overlay.hide();
  }

  /// True if the popover is currently being shown. False if it is hidden.
  bool get shown => _overlay.isShowing;

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

/// A popover displays rich content in a portal that is aligned to a target.
///
/// See:
/// * https://forui.dev/docs/popover for working examples.
/// * [FPopoverController] for controlling a popover.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  /// The controller that shows and hides the follower. It initially hides the follower.
  final FPopoverController? controller;

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

  /// The follower's semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// True if the follower will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Defaults to false.
  ///
  /// Ideally, there is only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  final bool autofocus;

  /// An optional focus node to use as the focus node for the follower.
  ///
  /// If one is not supplied, then one will be automatically allocated, owned, and managed by the follower. The follower
  /// will be focusable even if a [focusNode] is not supplied. If supplied, the given `focusNode` will be hosted by the
  /// follower but not owned. See [FocusNode] for more information on what being hosted and/or owned implies.
  ///
  /// Supplying a focus node is sometimes useful if an ancestor to the follower wants to control when the follower has
  /// the focus. The owner will be responsible for calling [FocusNode.dispose] on the focus node when it is done with
  /// it, but the follower will attach/detach and reparent the node when needed.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if the follower's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

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
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
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
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(DiagnosticsProperty('follower', follower));
  }
}

class _State extends State<FPopover> with SingleTickerProviderStateMixin {
  final Key _group = UniqueKey();
  late FPopoverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FPopoverController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant FPopover old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? FPopoverController(vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverStyle;
    return FPortal(
      controller: _controller._overlay,
      followerAnchor: widget.followerAnchor,
      childAnchor: widget.childAnchor,
      shift: widget.shift,
      follower: (context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _controller.hide,
        },
        child: Semantics(
          label: widget.semanticLabel,
          container: true,
          child: Focus(
            child: Padding(
              padding: style.margin,
              child: FadeTransition(
                opacity: _controller._fade,
                child: ScaleTransition(
                  scale: _controller._scale,
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
          ),
        ),
      ),
      child: TapRegion(
        groupId: _group,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _controller.toggle,
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
              ]),
        );

  // TODO: other methods;
}