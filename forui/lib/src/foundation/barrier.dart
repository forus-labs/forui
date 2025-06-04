import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// These widgets are difficult to test individually, we test them in combination with widgets that use them instead.

/// A widget that prevents the user from interacting with widgets behind itself, and can be configured with an animated
/// value.
///
/// The modal barrier is the scrim that is rendered behind each route, which generally prevents the user from
/// interacting with the route below the current route, and normally partially obscures such routes.
///
/// For example, when a dialog is on the screen, the page below the dialog is usually darkened by the modal barrier.
///
/// ## Implementation details:
/// This class is a copy of [AnimatedModalBarrier] from Flutter 3.32.1 with the following enhancements:
/// * support for [ImageFilter]s instead of just solid colors.
/// * uses [FModalBarrier] instead of [ModalBarrier].
class FAnimatedModalBarrier extends AnimatedWidget {
  /// If non-null, applies the given [ImageFilter] to the barrier.
  final ImageFilter Function(double value)? filter;

  /// {@macro forui.foundation.FModalBarrier.onDismiss}
  final VoidCallback? onDismiss;

  /// Whether the modal barrier semantics are included in the semantics tree.
  final bool? barrierSemanticsDismissible;

  /// Semantics label used for the barrier if it is dismissible.
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack on Android and VoiceOver on iOS) when the
  /// barrier is focused.
  final String? semanticsLabel;

  /// {@macro forui.foundation.FModalBarrier.clipDetailsNotifier}
  final ValueNotifier<EdgeInsets>? clipDetailsNotifier;

  /// This hint text instructs users what they are able to do when they tap on the [FModalBarrier]
  ///
  /// E.g. If the hint text is 'close bottom sheet", it will be announced as "Double tap to close bottom sheet".
  ///
  /// If this value is null, the default onTapHint will be applied, resulting in the announcement of
  /// 'Double tap to activate'.
  final String? semanticsOnTapHint;

  /// Creates a [FAnimatedModalBarrier] that blocks user interaction.
  const FAnimatedModalBarrier({
    required this.filter,
    required this.onDismiss,
    required Animation<double> animation,
    this.semanticsLabel,
    this.barrierSemanticsDismissible,
    this.clipDetailsNotifier,
    this.semanticsOnTapHint,
    super.key,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) => FModalBarrier(
    filter: filter == null ? null : filter!(animation.value),
    onDismiss: onDismiss,
    semanticsLabel: semanticsLabel,
    barrierSemanticsDismissible: barrierSemanticsDismissible,
    clipDetailsNotifier: clipDetailsNotifier,
    semanticsOnTapHint: semanticsOnTapHint,
  );

  /// If non-null, fill the barrier with this color.
  Animation<double> get animation => listenable as Animation<double>;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('filter', filter))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(
        FlagProperty(
          'barrierSemanticsDismissible',
          value: barrierSemanticsDismissible,
          ifTrue: 'barrier semantics dismissible',
        ),
      )
      ..add(DiagnosticsProperty('clipDetailsNotifier', clipDetailsNotifier))
      ..add(StringProperty('semanticsOnTapHint', semanticsOnTapHint))
      ..add(DiagnosticsProperty('animation', animation, defaultValue: null));
  }
}

/// A widget that prevents the user from interacting with widgets behind itself.
///
/// The modal barrier is the scrim that is rendered behind each route, which generally prevents the user from
/// interacting with the route below the current route, and normally partially obscures such routes.
///
/// For example, when a dialog is on the screen, the page below the dialog is usually darkened by the modal barrier.
///
/// See also:
///  * [FAnimatedModalBarrier], which is similar but takes an additional [Animation].
///
/// ## Implementation details:
/// This class is a copy of [ModalBarrier] from Flutter 3.32.1 with the following enhancements:
/// * support for [ImageFilter]s instead of just solid colors.
/// * merge [ModalBarrier.dismissible] and [ModalBarrier.onDismiss].
/// * inlined `_ModalBarrierGestureDetector`.
class FModalBarrier extends StatelessWidget {
  /// If non-null, applies the given [ImageFilter] to the barrier.
  final ImageFilter? filter;

  /// Called when the barrier is being dismissed. Defaults to popping the current route from the ambient [Navigator].
  ///
  /// If [onDismiss] is null, tapping on the barrier will do nothing.
  final VoidCallback? onDismiss;

  /// Whether the modal barrier semantics are included in the semantics tree.
  final bool? barrierSemanticsDismissible;

  /// Semantics label used for the barrier if it is dismissible.
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack on Android and VoiceOver on iOS) when the
  /// barrier is focused.
  final String? semanticsLabel;

  /// {@template forui.foundation.FModalBarrier.clipDetailsNotifier}
  /// Contains a value of type [EdgeInsets] that specifies how the
  /// [SemanticsNode.rect] of the widget should be clipped.
  ///
  /// See also:
  ///
  ///  * [_SemanticsClipper], which utilizes the value inside to update the
  /// [SemanticsNode.rect] for its child.
  /// {@endtemplate}
  final ValueNotifier<EdgeInsets>? clipDetailsNotifier;

  /// The semantic hint text that informs users what will happen if they tap on the widget. Announced in the format of
  /// 'Double tap to ...'.
  ///
  /// If the field is null, the default hint will be used, which results in announcement of 'Double tap to activate'.
  final String? semanticsOnTapHint;

  /// Creates a widget that blocks user interaction.
  const FModalBarrier({
    required this.filter,
    required this.onDismiss,
    this.semanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.clipDetailsNotifier,
    this.semanticsOnTapHint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_asserts_with_message
    assert(onDismiss == null || semanticsLabel == null || debugCheckHasDirectionality(context));

    final semanticsDismissible =
        onDismiss != null &&
        switch (defaultTargetPlatform) {
          TargetPlatform.android || TargetPlatform.iOS || TargetPlatform.macOS => true,
          TargetPlatform.fuchsia || TargetPlatform.linux || TargetPlatform.windows => false,
        };

    void handleDismiss() {
      if (onDismiss case final onDismiss?) {
        onDismiss();
      } else {
        SystemSound.play(SystemSoundType.alert);
      }
    }

    Widget barrier = Semantics(
      onTapHint: semanticsOnTapHint,
      onTap: semanticsDismissible && semanticsLabel != null ? handleDismiss : null,
      onDismiss: semanticsDismissible && semanticsLabel != null ? handleDismiss : null,
      label: semanticsDismissible ? semanticsLabel : null,
      textDirection: semanticsDismissible && semanticsLabel != null ? Directionality.of(context) : null,
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: filter == null ? null : BackdropFilter(filter: filter!, child: Container()),
        ),
      ),
    );

    // Developers can set [dismissible: true] and [barrierSemanticsDismissible: true] to allow assistive technology
    // users to dismiss a modal BottomSheet by tapping on the Scrim focus. On iOS, some modal barriers are not
    // dismissible in accessibility mode.
    final including = semanticsDismissible && (barrierSemanticsDismissible ?? semanticsDismissible);

    if (clipDetailsNotifier case final notifier? when including) {
      barrier = _SemanticsClipper(clipDetailsNotifier: notifier, child: barrier);
    }

    return BlockSemantics(
      child: ExcludeSemantics(
        excluding: including,
        child: RawGestureDetector(
          gestures: {_AnyTapGestureRecognizer: _AnyTapGestureRecognizerFactory(onAnyTapUp: handleDismiss)},
          behavior: HitTestBehavior.opaque,
          child: barrier,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('filter', filter))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty('barrierSemanticsDismissible', barrierSemanticsDismissible))
      ..add(DiagnosticsProperty('clipDetailsNotifier', clipDetailsNotifier))
      ..add(StringProperty('semanticsOnTapHint', semanticsOnTapHint));
  }
}

/// A widget that modifies the size of the [SemanticsNode.rect] created by its child widget.
///
/// It clips the focus in potentially four directions based on the specified [EdgeInsets].
///
/// The size of the accessibility focus is adjusted based on value changes inside the given [ValueNotifier].
///
/// See also:
///  * [FModalBarrier], which utilizes this widget to adjust the barrier focus size based on the size of the content
///    layer rendered on top of it.
///
/// This is an exact copy of [_SemanticsClipper] in Flutter 3.32.1.
class _SemanticsClipper extends SingleChildRenderObjectWidget {
  /// The [ValueNotifier] whose value determines how the child's [SemanticsNode.rect] should be clipped in four
  /// directions.
  final ValueNotifier<EdgeInsets> clipDetailsNotifier;

  /// Creates a [_SemanticsClipper] that updates the size of the [SemanticsNode.rect] of its child based on the value
  /// inside the provided [ValueNotifier], or a default value of [EdgeInsets.zero].
  const _SemanticsClipper({required this.clipDetailsNotifier, super.child});

  @override
  _RenderSemanticsClipper createRenderObject(BuildContext _) =>
      _RenderSemanticsClipper(clipDetailsNotifier: clipDetailsNotifier);

  @override
  void updateRenderObject(BuildContext _, _RenderSemanticsClipper clipper) =>
      clipper.clipDetailsNotifier = clipDetailsNotifier;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('clipDetailsNotifier', clipDetailsNotifier));
  }
}

/// Updates the [SemanticsNode.rect] of its child based on the value inside provided [ValueNotifier].
///
/// This is an exact copy of [_RenderSemanticsClipper] in Flutter 3.32.1.
class _RenderSemanticsClipper extends RenderProxyBox {
  ValueNotifier<EdgeInsets> _clipDetailsNotifier;

  /// Creates a [RenderProxyBox] that Updates the [SemanticsNode.rect] of its child based on the value inside the
  /// provided [ValueNotifier].
  _RenderSemanticsClipper({required ValueNotifier<EdgeInsets> clipDetailsNotifier, RenderBox? child})
    : _clipDetailsNotifier = clipDetailsNotifier,
      super(child);

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    clipDetailsNotifier.addListener(markNeedsSemanticsUpdate);
  }

  @override
  void detach() {
    clipDetailsNotifier.removeListener(markNeedsSemanticsUpdate);
    super.detach();
  }

  @override
  Rect get semanticBounds => Rect.fromLTRB(
    super.semanticBounds.left + _clipDetailsNotifier.value.left,
    super.semanticBounds.top + _clipDetailsNotifier.value.top,
    super.semanticBounds.right - _clipDetailsNotifier.value.right,
    super.semanticBounds.bottom - _clipDetailsNotifier.value.bottom,
  );

  /// The getter and setter retrieves / updates the [ValueNotifier] associated
  /// with this clipper.
  ValueNotifier<EdgeInsets> get clipDetailsNotifier => _clipDetailsNotifier;

  set clipDetailsNotifier(ValueNotifier<EdgeInsets> newNotifier) {
    if (_clipDetailsNotifier == newNotifier) {
      return;
    }

    if (attached) {
      _clipDetailsNotifier.removeListener(markNeedsSemanticsUpdate);
    }

    _clipDetailsNotifier = newNotifier;
    _clipDetailsNotifier.addListener(markNeedsSemanticsUpdate);
    markNeedsSemanticsUpdate();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('clipDetailsNotifier', clipDetailsNotifier));
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
  }
}

/// This is an exact copy of [_AnyTapGestureRecognizerFactory] in Flutter 3.32.1.
class _AnyTapGestureRecognizerFactory extends GestureRecognizerFactory<_AnyTapGestureRecognizer> {
  const _AnyTapGestureRecognizerFactory({this.onAnyTapUp});

  final VoidCallback? onAnyTapUp;

  @override
  _AnyTapGestureRecognizer constructor() => _AnyTapGestureRecognizer();

  @override
  void initializer(_AnyTapGestureRecognizer instance) => instance.onAnyTapUp = onAnyTapUp;
}

/// Recognizes tap down by any pointer button.
///
/// It is similar to [TapGestureRecognizer.onTapDown], but accepts any single button, which means the gesture also takes
/// parts in gesture arenas.
///
/// This is an exact copy of [_AnyTapGestureRecognizer] in Flutter 3.32.1.
class _AnyTapGestureRecognizer extends BaseTapGestureRecognizer {
  _AnyTapGestureRecognizer();

  VoidCallback? onAnyTapUp;

  @protected
  @override
  bool isPointerAllowed(PointerDownEvent event) => onAnyTapUp != null && super.isPointerAllowed(event);

  @protected
  @override
  void handleTapDown({PointerDownEvent? down}) {
    // Do nothing.
  }

  @protected
  @override
  void handleTapUp({PointerDownEvent? down, PointerUpEvent? up}) {
    if (onAnyTapUp case final onAnyTapUp?) {
      invokeCallback('onAnyTapUp', onAnyTapUp);
    }
  }

  @protected
  @override
  void handleTapCancel({PointerDownEvent? down, PointerCancelEvent? cancel, String? reason}) {
    // Do nothing.
  }

  @override
  String get debugDescription => 'any tap';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('onAnyTapUp', onAnyTapUp));
  }
}
