import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'popover.style.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
final class FPopoverController extends FChangeNotifier {
  static final _fadeTween = Tween<double>(begin: 0, end: 1);
  static final _scaleTween = Tween<double>(begin: 0.95, end: 1);

  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FPopoverController] with the given [vsync] and animation [animationDuration].
  FPopoverController({required TickerProvider vsync, Duration animationDuration = const Duration(milliseconds: 100)}) {
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
  /// If [shown] is already true, calling this method brings the popover to the top.
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
  /// widgets in the popover may lose their states as a result.
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
  static ({Alignment popover, Alignment child}) get defaultPlatform => FTouch.primary
      ? (popover: Alignment.bottomCenter, child: Alignment.topCenter)
      : (popover: Alignment.topCenter, child: Alignment.bottomCenter);

  /// The controller that shows and hides the popover. It initially hides the popover.
  final FPopoverController? controller;

  /// The popover's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover
  /// ```
  final FPopoverStyle? style;

  /// The constraints.
  final FPortalConstraints constraints;

  /// {@template forui.widgets.FPopover.popoverAnchor}
  /// The point on the popover (floating content) that connects with the child at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the popover will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final AlignmentGeometry popoverAnchor;

  /// {@template forui.widgets.FPopover.childAnchor}
  /// The point on the child that connects with the popover at the popover's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the popover.
  /// See [popoverAnchor] for changing the popover's anchor.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final AlignmentGeometry childAnchor;

  /// {@template forui.widgets.FPopover.spacing}
  /// The spacing between the child's anchor and popover's anchor. Defaults to `FPortalSpacing(4)`.
  ///
  /// It applied before [shift].
  /// {@endtemplate}
  final FPortalSpacing spacing;

  /// {@template forui.widgets.FPopover.shift}
  /// The shifting strategy used to shift a popover when it overflows out of the viewport. Defaults to
  /// [FPortalShift.flip].
  ///
  /// It is applied after [spacing] and before [offset].
  ///
  /// See [FPortalShift] for more information on the different shifting strategies.
  /// {@endtemplate}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@template forui.widgets.FPopover.offset}
  /// The offset to adjust the popover by. Defaults to [Offset.zero].
  ///
  /// It is applied after [shift].
  /// {@endtemplate}
  final Offset offset;

  /// {@template forui.widgets.FPopover.groupId}
  /// An optional group ID that groups [TapRegion]s together so that they operate as one region. If a tap occurs outside
  /// of all group members, then group members that are shown will be hidden.
  ///
  /// If the group id is null, then only this region is hit tested.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the group id is not null and [hideOnTapOutside] is not set to
  /// [FHidePopoverRegion.excludeTarget].
  /// {@endtemplate}
  final Object? groupId;

  /// {@template forui.widgets.FPopover.hideOnTapOutside}
  /// The region that can be tapped to hide the popover.
  /// {@endtemplate}
  final FHidePopoverRegion hideOnTapOutside;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@template forui.widgets.FPopover.traversalEdgeBehavior}
  /// Controls the transfer of focus beyond the first and the last items in a popover. Defaults to
  /// [TraversalEdgeBehavior.closedLoop].
  ///
  /// Changing this field value has no immediate effect on the UI.
  /// {@endtemplate}
  final TraversalEdgeBehavior traversalEdgeBehavior;

  /// The popover's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// The shortcuts and the associated actions.
  ///
  /// Defaults to closing the popover when the escape key is pressed.
  final Map<ShortcutActivator, VoidCallback>? shortcuts;

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
    this.constraints = const FPortalConstraints(),
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.groupId,
    this.hideOnTapOutside = FHidePopoverRegion.anywhere,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior = TraversalEdgeBehavior.closedLoop,
    this.semanticsLabel,
    this.shortcuts,
    AlignmentGeometry? popoverAnchor,
    AlignmentGeometry? childAnchor,
    super.key,
  }) : assert(
         groupId == null || hideOnTapOutside == FHidePopoverRegion.excludeTarget,
         'groupId can only be used with FHidePopoverRegion.excludeTarget',
       ),
       popoverAnchor = popoverAnchor ?? defaultPlatform.popover,
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
    this.constraints = const FPortalConstraints(),
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.groupId,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior = TraversalEdgeBehavior.closedLoop,
    this.semanticsLabel,
    this.shortcuts,
    AlignmentGeometry? popoverAnchor,
    AlignmentGeometry? childAnchor,
    super.key,
  }) : assert(
         groupId == null || hideOnTapOutside == FHidePopoverRegion.excludeTarget,
         'groupId can only be used with FHidePopoverRegion.excludeTarget',
       ),
       popoverAnchor = popoverAnchor ?? defaultPlatform.popover,
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
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('popoverAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder));
  }
}

class _State extends State<FPopover> with SingleTickerProviderStateMixin {
  late Object? _groupId = widget.groupId ?? UniqueKey();
  late FPopoverController _controller = widget.controller ?? FPopoverController(vsync: this);

  @override
  void didUpdateWidget(covariant FPopover old) {
    super.didUpdateWidget(old);
    if (widget.groupId != old.groupId) {
      _groupId = widget.groupId ?? UniqueKey();
    }

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
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;

    var child = widget._automatic
        ? GestureDetector(behavior: HitTestBehavior.translucent, onTap: _controller.toggle, child: widget.child)
        : widget.child;

    if (widget.hideOnTapOutside == FHidePopoverRegion.excludeTarget) {
      child = TapRegion(groupId: _groupId, onTapOutside: (_) => _hide(), child: child);
    }

    return FPortal(
      controller: _controller._overlay,
      constraints: widget.constraints,
      portalAnchor: widget.popoverAnchor,
      childAnchor: widget.childAnchor,
      viewInsets: MediaQuery.viewPaddingOf(context) + style.viewInsets.resolve(direction),
      spacing: widget.spacing,
      shift: widget.shift,
      offset: widget.offset,
      portalBuilder: (context) => CallbackShortcuts(
        bindings: widget.shortcuts ?? {const SingleActivator(LogicalKeyboardKey.escape): _hide},
        child: Semantics(
          label: widget.semanticsLabel,
          container: true,
          child: FocusScope(
            autofocus: widget.autofocus,
            node: widget.focusNode,
            onFocusChange: widget.onFocusChange,
            child: FadeTransition(
              opacity: _controller._fade,
              child: ScaleTransition(
                scale: _controller._scale,
                child: TapRegion(
                  groupId: _groupId,
                  onTapOutside: widget.hideOnTapOutside == FHidePopoverRegion.none ? null : (_) => _hide(),
                  child: DecoratedBox(decoration: style.decoration, child: widget.popoverBuilder(context, style, null)),
                ),
              ),
            ),
          ),
        ),
      ),
      child: child,
    );
  }

  void _hide() {
    // We need to check if it is shown first, otherwise it will fire even when hidden. This messes with the focus
    // when there are multiple FSelects/other widgets.
    if (_controller.shown) {
      _controller.hide();
    }
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
class FPopoverStyle with Diagnosticable, _$FPopoverStyleFunctions {
  /// The popover's decoration.
  @override
  final BoxDecoration decoration;

  /// The additional insets of the view. In other words, the minimum distance between the edges of the view and the
  /// edges of the popover. This applied in addition to the insets provided by [MediaQueryData.viewPadding].
  ///
  /// Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry viewInsets;

  /// Creates a [FPopoverStyle].
  const FPopoverStyle({required this.decoration, this.viewInsets = const EdgeInsets.all(5)});

  /// Creates a [FPopoverStyle] that inherits its properties.
  FPopoverStyle.inherit({required FColors colors, required FStyle style})
    : this(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: style.borderRadius,
          border: Border.all(width: style.borderWidth, color: colors.border),
          boxShadow: style.shadow,
        ),
      );
}
