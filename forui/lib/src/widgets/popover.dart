import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/foundation/tappable.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
final class FPopoverController extends FChangeNotifier {
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

  /// Convenience method for toggling the current [shown] status.
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
    notifyListeners();
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
    notifyListeners();
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
/// * https://forui.dev/docs/overlay/popover for working examples.
/// * [FPopoverController] for controlling a popover.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  static ({Alignment follower, Alignment target}) get _platform => Touch.primary
      ? (follower: Alignment.bottomCenter, target: Alignment.topCenter)
      : (follower: Alignment.topCenter, target: Alignment.bottomCenter);

  /// The controller that shows and hides the follower. It initially hides the follower.
  final FPopoverController? controller;

  /// The popover's style.
  final FPopoverStyle? style;

  /// The anchor of the follower to which the [targetAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final Alignment followerAnchor;

  /// The anchor of the target to which the [followerAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final Alignment targetAnchor;

  /// The shifting strategy used to shift a follower when it overflows out of the viewport. Defaults to
  /// [FPortalFollowerShift.flip].
  ///
  /// See [FPortalFollowerShift] for more information on the different shifting strategies.
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  /// True if the popover is hidden when tapped outside of it. Defaults to true.
  final bool hideOnTapOutside;

  /// True if the follower should include the cross-axis padding of the anchor when aligning to it. Defaults to false.
  ///
  /// Diagonal corners are ignored.
  final bool directionPadding;

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

  /// The follower builder. The child passed to [followerBuilder] will always be null.
  final ValueWidgetBuilder<FPopoverStyle> followerBuilder;

  /// The target.
  final Widget target;

  final bool _tappable;

  /// Creates a popover that only shows the follower when the controller is manually toggled.
  FPopover({
    required this.controller,
    required this.followerBuilder,
    required this.target,
    this.style,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Alignment? followerAnchor,
    Alignment? targetAnchor,
    super.key,
  })  : followerAnchor = followerAnchor ?? _platform.follower,
        targetAnchor = targetAnchor ?? _platform.target,
        _tappable = false;

  /// Creates a popover that is automatically shown when the [target] is tapped.
  ///
  /// It is not recommended for the [target] to contain a [GestureDetector], such as [FButton]. This is because only
  /// one `GestureDetector` will be called if there are multiple overlapping `GestureDetector`s.
  FPopover.tappable({
    required this.followerBuilder,
    required this.target,
    this.controller,
    this.style,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Alignment? followerAnchor,
    Alignment? targetAnchor,
    super.key,
  })  : followerAnchor = followerAnchor ?? _platform.follower,
        targetAnchor = targetAnchor ?? _platform.target,
        _tappable = true;

  @override
  State<FPopover> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('followerAnchor', followerAnchor))
      ..add(DiagnosticsProperty('targetAnchor', targetAnchor))
      ..add(DiagnosticsProperty('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside, ifTrue: 'hideOnTapOutside'))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(DiagnosticsProperty('followerBuilder', followerBuilder));
  }
}

class _State extends State<FPopover> with SingleTickerProviderStateMixin {
  final Key _group = UniqueKey();
  late final FPopoverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FPopoverController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant FPopover old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    if (old.controller != null) {
      _controller.dispose();
    }
    _controller = widget.controller ?? FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverStyle;
    final follower = widget.followerAnchor;
    final target = widget.targetAnchor;

    return FPortal(
      controller: _controller._overlay,
      followerAnchor: widget.followerAnchor,
      targetAnchor: widget.targetAnchor,
      shift: widget.shift,
      offset:
          widget.directionPadding ? Offset.zero : Alignments.removeDirectionalPadding(style.padding, follower, target),
      followerBuilder: (context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _controller.hide,
        },
        child: Semantics(
          label: widget.semanticLabel,
          container: true,
          child: Focus(
            child: Padding(
              padding: style.padding,
              child: FadeTransition(
                opacity: _controller._fade,
                child: ScaleTransition(
                  scale: _controller._scale,
                  child: TapRegion(
                    groupId: _group,
                    onTapOutside: widget.hideOnTapOutside ? (_) => _controller.hide() : null,
                    child: DecoratedBox(
                      decoration: style.decoration,
                      child: widget.followerBuilder(context, style, null),
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
        child: widget._tappable
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _controller.toggle,
                child: widget.target,
              )
            : widget.target,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// A [FPopover]'s style.
class FPopoverStyle with Diagnosticable {
  /// The popover's default shadow in [FPopoverStyle.inherit].
  static const shadow = [
    BoxShadow(
      color: Color(0x0d000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// The popover's decoration.
  final BoxDecoration decoration;

  /// The margin surrounding the popover. Defaults to `EdgeInsets.all(4)`.
  final EdgeInsets padding;

  /// Creates a [FPopoverStyle].
  const FPopoverStyle({
    required this.decoration,
    this.padding = const EdgeInsets.all(4),
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
            boxShadow: shadow,
          ),
        );

  /// Returns a copy of this style with the given fields replaced by the new values.
  @useResult
  FPopoverStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsets? padding,
  }) =>
      FPopoverStyle(
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPopoverStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding;

  @override
  int get hashCode => decoration.hashCode ^ padding.hashCode;
}
