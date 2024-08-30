import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/platform.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
final class FPopoverController extends ChangeNotifier {
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
/// * https://forui.dev/docs/popover for working examples.
/// * [FPopoverController] for controlling a popover.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  static ({Alignment follower, Alignment target}) get _platform => touchPlatforms.contains(defaultTargetPlatform)
      ? (follower: Alignment.bottomCenter, target: Alignment.topCenter)
      : (follower: Alignment.topCenter, target: Alignment.bottomCenter);

  /// The controller that shows and hides the follower. It initially hides the follower.
  final FPopoverController controller;

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

  /// Creates a popover.
  FPopover({
    required this.controller,
    required this.followerBuilder,
    required this.target,
    this.style,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Alignment? followerAnchor,
    Alignment? targetAnchor,
    super.key,
  })  : followerAnchor = followerAnchor ?? _platform.follower,
        targetAnchor = targetAnchor ?? _platform.target;

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
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(DiagnosticsProperty('follower', followerBuilder));
  }
}

class _State extends State<FPopover> with SingleTickerProviderStateMixin {
  final Key _group = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.popoverStyle;
    return FPortal(
      controller: widget.controller._overlay,
      followerAnchor: widget.followerAnchor,
      targetAnchor: widget.targetAnchor,
      shift: widget.shift,
      followerBuilder: (context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): widget.controller.hide,
        },
        child: Semantics(
          label: widget.semanticLabel,
          container: true,
          child: Focus(
            child: Padding(
              padding: style.padding,
              child: FadeTransition(
                opacity: widget.controller._fade,
                child: ScaleTransition(
                  scale: widget.controller._scale,
                  child: TapRegion(
                    groupId: _group,
                    onTapOutside: widget.hideOnTapOutside ? (_) => widget.controller.hide() : null,
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
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.controller.toggle,
          child: widget.target,
        ),
      ),
    );
  }
}

/// A [FPopover]'s style.
final class FPopoverStyle with Diagnosticable {
  /// The popover's default shadow in [FPopoverStyle.inherit].
  static const shadow = [
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
