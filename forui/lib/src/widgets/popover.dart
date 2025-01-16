import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/foundation/tappable.dart';
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
  /// This method should typically not be called while the widget tree is being rebuilt.
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

/// The regions that can be tapped to hide a popover.
enum FHidePopoverRegion {
  /// The entire screen, excluding the popover.
  anywhere,

  /// The entire screen, excluding the target and popover.
  excludeTarget,

  /// Disables tapping outside of the popover to hide it.
  none,
}

/// A popover displays rich content in a portal that is aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover for working examples.
/// * [FPopoverController] for controlling a popover.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  /// The platform-specific default popover and child anchors.
  static ({Alignment popover, Alignment child}) get defaultPlatform => Touch.primary
      ? (popover: Alignment.bottomCenter, child: Alignment.topCenter)
      : (popover: Alignment.topCenter, child: Alignment.bottomCenter);

  /// The controller that shows and hides the popover. It initially hides the popover.
  final FPopoverController? controller;

  /// The popover's style.
  final FPopoverStyle? style;

  /// {@template forui.widgets.FPopover.popoverAnchor}
  /// The point on the popover (floating content) that connects with the child, at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the popover will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final Alignment popoverAnchor;

  /// {@template forui.widgets.FPopover.childAnchor}
  /// The point on the child that connects with the popover, at the popover's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the popover.
  /// See [popoverAnchor] for changing the popover's anchor.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final Alignment childAnchor;

  /// {@template forui.widgets.FPopover.shift}
  /// The shifting strategy used to shift a popover when it overflows out of the viewport. Defaults to
  /// [FPortalShift.flip].
  ///
  /// See [FPortalShift] for more information on the different shifting strategies.
  /// {@endtemplate}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@template forui.widgets.FPopover.hideOnTapOutside}
  /// The region that can be tapped to hide the popover.
  /// {@endtemplate}
  final FHidePopoverRegion hideOnTapOutside;

  /// {@template forui.widgets.FPopover.directionPadding}
  /// True if the popover should include the cross-axis padding of the anchor when aligning to it. Defaults to false.
  ///
  /// Diagonal corners are ignored.
  /// {@endtemplate}
  final bool directionPadding;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// The popover's semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// The popover builder. The child passed to [popoverBuilder] will always be null.
  final ValueWidgetBuilder<FPopoverStyle> popoverBuilder;

  /// The child.
  final Widget child;

  final bool _automatic;

  /// Creates a popover that only shows the popover when the controller is manually toggled.
  FPopover({
    required FPopoverController this.controller,
    required this.popoverBuilder,
    required this.child,
    this.style,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.anywhere,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    Alignment? popoverAnchor,
    Alignment? childAnchor,
    super.key,
  })  : popoverAnchor = popoverAnchor ?? defaultPlatform.popover,
        childAnchor = childAnchor ?? defaultPlatform.child,
        _automatic = false;

  /// Creates a popover that is automatically shown when the [child] is tapped.
  ///
  /// It is not recommended for the [child] to contain a [GestureDetector], such as [FButton]. Only one
  /// `GestureDetector` will be called if there are multiple overlapping `GestureDetector`s, leading to unexpected
  /// behavior.
  FPopover.automatic({
    required this.popoverBuilder,
    required this.child,
    this.controller,
    this.style,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.semanticLabel,
    Alignment? popoverAnchor,
    Alignment? childAnchor,
    super.key,
  })  : popoverAnchor = popoverAnchor ?? defaultPlatform.popover,
        childAnchor = childAnchor ?? defaultPlatform.child,
        _automatic = true;

  @override
  State<FPopover> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('popoverAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder));
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
    final popover = widget.popoverAnchor;
    final childAnchor = widget.childAnchor;

    var child = widget._automatic
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _controller.toggle,
            child: widget.child,
          )
        : widget.child;

    if (widget.hideOnTapOutside == FHidePopoverRegion.excludeTarget) {
      child = TapRegion(
        groupId: _group,
        onTapOutside: (_) => _controller.hide(),
        child: child,
      );
    }

    return FPortal(
      controller: _controller._overlay,
      portalAnchor: widget.popoverAnchor,
      childAnchor: widget.childAnchor,
      shift: widget.shift,
      offset: widget.directionPadding
          ? Offset.zero
          : Alignments.removeDirectionalPadding(style.padding, popover, childAnchor),
      portalBuilder: (context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _controller.hide,
        },
        child: Semantics(
          label: widget.semanticLabel,
          container: true,
          child: Focus(
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            onFocusChange: widget.onFocusChange,
            child: FocusTraversalGroup(
              child: Padding(
                padding: style.padding,
                child: FadeTransition(
                  opacity: _controller._fade,
                  child: ScaleTransition(
                    scale: _controller._scale,
                    child: TapRegion(
                      groupId: _group,
                      onTapOutside:
                          widget.hideOnTapOutside == FHidePopoverRegion.none ? null : (_) => _controller.hide(),
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
      ),
      child: child,
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
            boxShadow: style.shadow,
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
