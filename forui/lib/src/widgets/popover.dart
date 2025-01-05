import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:meta/meta.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
final class FPopoverController extends FChangeNotifier {
  static final _fadeTween = Tween<double>(begin: 0, end: 1);
  static final _scaleTween = Tween<double>(begin: 0.95, end: 1);

  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FPopoverController] with the given [vsync] and animation [animationDuration].
  FPopoverController({required TickerProvider vsync, animationDuration = const Duration(milliseconds: 100)}) {
    _animation = AnimationController(vsync: vsync, duration: animationDuration);
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
class FPopover extends StatefulWidget implements FPopoverProperties, FFocusableProperties {
  /// The controller that shows and hides the follower. It initially hides the follower.
  final FPopoverController? controller;

  /// The popover's style.
  final FPopoverStyle? style;

  @override
  final Alignment popoverAnchor;

  @override
  final Alignment childAnchor;

  @override
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  @override
  final bool hideOnTapOutside;

  @override
  final bool directionPadding;

  /// The follower's semantic label used by accessibility frameworks.
  final String? semanticLabel;

  @override
  final bool autofocus;

  @override
  final FocusNode? focusNode;

  @override
  final ValueChanged<bool>? onFocusChange;

  /// The popover builder. The child passed to [popoverBuilder] will always be null.
  final ValueWidgetBuilder<FPopoverStyle> popoverBuilder;

  /// The child to which the popover is laid over.
  final Widget child;

  final bool _tappable;

  /// Creates a popover that only shows the popover when the controller is manually toggled.
  FPopover({
    required this.controller,
    required this.popoverBuilder,
    required this.child,
    this.style,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Alignment? popoverAnchor,
    Alignment? childAnchor,
    super.key,
  })  : popoverAnchor = popoverAnchor ?? FPopoverProperties.defaultAlignment.popover,
        childAnchor = childAnchor ?? FPopoverProperties.defaultAlignment.child,
        _tappable = false;

  /// Creates a popover that is automatically shown when the [child] is tapped.
  ///
  /// It is not recommended for the [child] to contain a [GestureDetector], such as [FButton]. This is because only
  /// one `GestureDetector` will be called if there are multiple overlapping `GestureDetector`s.
  FPopover.tappable({
    required this.popoverBuilder,
    required this.child,
    this.controller,
    this.style,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Alignment? popoverAnchor,
    Alignment? childAnchor,
    super.key,
  })  : popoverAnchor = popoverAnchor ?? FPopoverProperties.defaultAlignment.popover,
        childAnchor = childAnchor ?? FPopoverProperties.defaultAlignment.child,
        _tappable = true;

  @override
  State<FPopover> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('followerAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('targetAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside, ifTrue: 'hideOnTapOutside'))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('followerBuilder', popoverBuilder));
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
    final follower = widget.popoverAnchor;
    final target = widget.childAnchor;

    return FPortal(
      controller: _controller._overlay,
      followerAnchor: widget.popoverAnchor,
      targetAnchor: widget.childAnchor,
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
                      child: widget.popoverBuilder(context, style, null),
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
                child: widget.child,
              )
            : widget.child,
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
