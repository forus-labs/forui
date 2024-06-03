import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

/// A [FTappable] creates a scale animation that mimics a tap.
@internal class FTappable extends StatefulWidget {
  /// A pointer that might cause a tap with a primary button has contacted the
  /// screen at a particular location.
  ///
  /// This is called after a short timeout, even if the winning gesture has not
  /// yet been selected. If the tap gesture wins, [onTapUp] will be called,
  /// otherwise [onTapCancel] will be called.
  final GestureTapDownCallback? onTapDown;

  /// A pointer that will trigger a tap with a primary button has stopped
  /// contacting the screen at a particular location.
  ///
  /// This triggers immediately before [onTap] in the case of the tap gesture
  /// winning. If the tap gesture did not win, [onTapCancel] is called instead.
  final GestureTapUpCallback? onTapUp;

  /// A tap with a primary button has occurred.
  ///
  /// This triggers when the tap gesture wins. If the tap gesture did not win,
  /// [onTapCancel] is called instead.
  final GestureTapCallback? onTap;

  /// The pointer that previously triggered [onTapDown] will not end up causing
  /// a tap.
  ///
  /// This is called after [onTapDown], and instead of [onTapUp] and [onTap], if
  /// the tap gesture did not win.
  final GestureTapCancelCallback? onTapCancel;

  /// A tap with a secondary button has occurred.
  ///
  /// This triggers when the tap gesture wins. If the tap gesture did not win,
  /// [onSecondaryTapCancel] is called instead.
  final GestureTapCallback? onSecondaryTap;

  /// A pointer that might cause a tap with a secondary button has contacted the
  /// screen at a particular location.
  ///
  /// This is called after a short timeout, even if the winning gesture has not
  /// yet been selected. If the tap gesture wins, [onSecondaryTapUp] will be
  /// called, otherwise [onSecondaryTapCancel] will be called.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// A pointer that will trigger a tap with a secondary button has stopped
  /// contacting the screen at a particular location.
  ///
  /// This triggers in the case of the tap gesture winning. If the tap gesture
  /// did not win, [onSecondaryTapCancel] is called instead.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// The pointer that previously triggered [onSecondaryTapDown] will not end up
  /// causing a tap.
  ///
  /// This is called after [onSecondaryTapDown], and instead of
  /// [onSecondaryTapUp], if the tap gesture did not win.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// A pointer that might cause a tap with a tertiary button has contacted the
  /// screen at a particular location.
  ///
  /// This is called after a short timeout, even if the winning gesture has not
  /// yet been selected. If the tap gesture wins, [onTertiaryTapUp] will be
  /// called, otherwise [onTertiaryTapCancel] will be called.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// A pointer that will trigger a tap with a tertiary button has stopped
  /// contacting the screen at a particular location.
  ///
  /// This triggers in the case of the tap gesture winning. If the tap gesture
  /// did not win, [onTertiaryTapCancel] is called instead.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// The pointer that previously triggered [onTertiaryTapDown] will not end up
  /// causing a tap.
  ///
  /// This is called after [onTertiaryTapDown], and instead of
  /// [onTertiaryTapUp], if the tap gesture did not win.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// A pointer that might cause a double tap has contacted the screen at a
  /// particular location.
  ///
  /// Triggered immediately after the down event of the second tap.
  ///
  /// If the user completes the double tap and the gesture wins, [onDoubleTap]
  /// will be called after this callback. Otherwise, [onDoubleTapCancel] will
  /// be called after this callback.
  final GestureTapDownCallback? onDoubleTapDown;

  /// The user has tapped the screen with a primary button at the same location
  /// twice in quick succession.
  final GestureTapCallback? onDoubleTap;

  /// The pointer that previously triggered [onDoubleTapDown] will not end up
  /// causing a double tap.
  final GestureTapCancelCallback? onDoubleTapCancel;

  /// The pointer has contacted the screen with a primary button, which might
  /// be the start of a long-press.
  ///
  /// This triggers after the pointer down event.
  ///
  /// If the user completes the long-press, and this gesture wins,
  /// [onLongPressStart] will be called after this callback. Otherwise,
  /// [onLongPressCancel] will be called after this callback.
  final GestureLongPressDownCallback? onLongPressDown;

  /// A pointer that previously triggered [onLongPressDown] will not end up
  /// causing a long-press.
  ///
  /// This triggers once the gesture loses if [onLongPressDown] has previously
  /// been triggered.
  ///
  /// If the user completed the long-press, and the gesture won, then
  /// [onLongPressStart] and [onLongPress] are called instead.
  final GestureLongPressCancelCallback? onLongPressCancel;

  /// Called when a long press gesture with a primary button has been recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// This is equivalent to (and is called immediately after) [onLongPressStart].
  /// The only difference between the two is that this callback does not
  /// contain details of the position at which the pointer initially contacted
  /// the screen.
  final GestureLongPressCallback? onLongPress;

  /// Called when a long press gesture with a primary button has been recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// This is equivalent to (and is called immediately before) [onLongPress].
  /// The only difference between the two is that this callback contains
  /// details of the position at which the pointer initially contacted the
  /// screen, whereas [onLongPress] does not.
  final GestureLongPressStartCallback? onLongPressStart;

  /// A pointer has been drag-moved after a long-press with a primary button.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// A pointer that has triggered a long-press with a primary button has
  /// stopped contacting the screen.
  ///
  /// This is equivalent to (and is called immediately after) [onLongPressEnd].
  /// The only difference between the two is that this callback does not
  /// contain details of the state of the pointer when it stopped contacting
  /// the screen.
  final GestureLongPressUpCallback? onLongPressUp;

  /// A pointer that has triggered a long-press with a primary button has
  /// stopped contacting the screen.
  ///
  /// This is equivalent to (and is called immediately before) [onLongPressUp].
  /// The only difference between the two is that this callback contains
  /// details of the state of the pointer when it stopped contacting the
  /// screen, whereas [onLongPressUp] does not.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// The pointer has contacted the screen with a secondary button, which might
  /// be the start of a long-press.
  ///
  /// This triggers after the pointer down event.
  ///
  /// If the user completes the long-press, and this gesture wins,
  /// [onSecondaryLongPressStart] will be called after this callback. Otherwise,
  /// [onSecondaryLongPressCancel] will be called after this callback.
  final GestureLongPressDownCallback? onSecondaryLongPressDown;

  /// A pointer that previously triggered [onSecondaryLongPressDown] will not
  /// end up causing a long-press.
  ///
  /// This triggers once the gesture loses if [onSecondaryLongPressDown] has
  /// previously been triggered.
  ///
  /// If the user completed the long-press, and the gesture won, then
  /// [onSecondaryLongPressStart] and [onSecondaryLongPress] are called instead.
  final GestureLongPressCancelCallback? onSecondaryLongPressCancel;

  /// Called when a long press gesture with a secondary button has been
  /// recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// This is equivalent to (and is called immediately after)
  /// [onSecondaryLongPressStart]. The only difference between the two is that
  /// this callback does not contain details of the position at which the
  /// pointer initially contacted the screen.
  final GestureLongPressCallback? onSecondaryLongPress;

  /// Called when a long press gesture with a secondary button has been
  /// recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// This is equivalent to (and is called immediately before)
  /// [onSecondaryLongPress]. The only difference between the two is that this
  /// callback contains details of the position at which the pointer initially
  /// contacted the screen, whereas [onSecondaryLongPress] does not.
  final GestureLongPressStartCallback? onSecondaryLongPressStart;

  /// A pointer has been drag-moved after a long press with a secondary button.
  final GestureLongPressMoveUpdateCallback? onSecondaryLongPressMoveUpdate;

  /// A pointer that has triggered a long-press with a secondary button has
  /// stopped contacting the screen.
  ///
  /// This is equivalent to (and is called immediately after)
  /// [onSecondaryLongPressEnd]. The only difference between the two is that
  /// this callback does not contain details of the state of the pointer when
  /// it stopped contacting the screen.
  final GestureLongPressUpCallback? onSecondaryLongPressUp;

  /// A pointer that has triggered a long-press with a secondary button has
  /// stopped contacting the screen.
  ///
  /// This is equivalent to (and is called immediately before)
  /// [onSecondaryLongPressUp]. The only difference between the two is that
  /// this callback contains details of the state of the pointer when it
  /// stopped contacting the screen, whereas [onSecondaryLongPressUp] does not.
  final GestureLongPressEndCallback? onSecondaryLongPressEnd;

  /// The pointer has contacted the screen with a tertiary button, which might
  /// be the start of a long-press.
  ///
  /// This triggers after the pointer down event.
  ///
  /// If the user completes the long-press, and this gesture wins,
  /// [onTertiaryLongPressStart] will be called after this callback. Otherwise,
  /// [onTertiaryLongPressCancel] will be called after this callback.
  final GestureLongPressDownCallback? onTertiaryLongPressDown;

  /// A pointer that previously triggered [onTertiaryLongPressDown] will not
  /// end up causing a long-press.
  ///
  /// This triggers once the gesture loses if [onTertiaryLongPressDown] has
  /// previously been triggered.
  ///
  /// If the user completed the long-press, and the gesture won, then
  /// [onTertiaryLongPressStart] and [onTertiaryLongPress] are called instead.
  final GestureLongPressCancelCallback? onTertiaryLongPressCancel;

  /// Called when a long press gesture with a tertiary button has been
  /// recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// This is equivalent to (and is called immediately after)
  /// [onTertiaryLongPressStart]. The only difference between the two is that
  /// this callback does not contain details of the position at which the
  /// pointer initially contacted the screen.
  final GestureLongPressCallback? onTertiaryLongPress;

  /// Called when a long press gesture with a tertiary button has been
  /// recognized.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  /// This is equivalent to (and is called immediately before)
  /// [onTertiaryLongPress]. The only difference between the two is that this
  /// callback contains details of the position at which the pointer initially
  /// contacted the screen, whereas [onTertiaryLongPress] does not.
  final GestureLongPressStartCallback? onTertiaryLongPressStart;

  /// A pointer has been drag-moved after a long press with a tertiary button.
  final GestureLongPressMoveUpdateCallback? onTertiaryLongPressMoveUpdate;

  /// A pointer that has triggered a long-press with a tertiary button has
  /// stopped contacting the screen.
  ///
  /// This is equivalent to (and is called immediately after)
  /// [onTertiaryLongPressEnd]. The only difference between the two is that
  /// this callback does not contain details of the state of the pointer when
  /// it stopped contacting the screen.
  final GestureLongPressUpCallback? onTertiaryLongPressUp;

  /// A pointer that has triggered a long-press with a tertiary button has
  /// stopped contacting the screen.
  ///
  /// This is equivalent to (and is called immediately before)
  /// [onTertiaryLongPressUp]. The only difference between the two is that
  /// this callback contains details of the state of the pointer when it
  /// stopped contacting the screen, whereas [onTertiaryLongPressUp] does not.
  final GestureLongPressEndCallback? onTertiaryLongPressEnd;

  /// A pointer has contacted the screen with a primary button and might begin
  /// to move vertically.
  final GestureDragDownCallback? onVerticalDragDown;

  /// A pointer has contacted the screen with a primary button and has begun to
  /// move vertically.
  final GestureDragStartCallback? onVerticalDragStart;

  /// A pointer that is in contact with the screen with a primary button and
  /// moving vertically has moved in the vertical direction.
  final GestureDragUpdateCallback? onVerticalDragUpdate;

  /// A pointer that was previously in contact with the screen with a primary
  /// button and moving vertically is no longer in contact with the screen and
  /// was moving at a specific velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onVerticalDragEnd;

  /// The pointer that previously triggered [onVerticalDragDown] did not
  /// complete.
  final GestureDragCancelCallback? onVerticalDragCancel;

  /// A pointer has contacted the screen with a primary button and might begin
  /// to move horizontally.
  final GestureDragDownCallback? onHorizontalDragDown;

  /// A pointer has contacted the screen with a primary button and has begun to
  /// move horizontally.
  final GestureDragStartCallback? onHorizontalDragStart;

  /// A pointer that is in contact with the screen with a primary button and
  /// moving horizontally has moved in the horizontal direction.
  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  /// A pointer that was previously in contact with the screen with a primary
  /// button and moving horizontally is no longer in contact with the screen and
  /// was moving at a specific velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onHorizontalDragEnd;

  /// The pointer that previously triggered [onHorizontalDragDown] did not
  /// complete.
  final GestureDragCancelCallback? onHorizontalDragCancel;

  /// A pointer has contacted the screen with a primary button and might begin
  /// to move.
  final GestureDragDownCallback? onPanDown;

  /// A pointer has contacted the screen with a primary button and has begun to
  /// move.
  final GestureDragStartCallback? onPanStart;

  /// A pointer that is in contact with the screen with a primary button and
  /// moving has moved again.
  final GestureDragUpdateCallback? onPanUpdate;

  /// A pointer that was previously in contact with the screen with a primary
  /// button and moving is no longer in contact with the screen and was moving
  /// at a specific velocity when it stopped contacting the screen.
  final GestureDragEndCallback? onPanEnd;

  /// The pointer that previously triggered [onPanDown] did not complete.
  final GestureDragCancelCallback? onPanCancel;

  /// The pointers in contact with the screen have established a focal point and
  /// initial scale of 1.0.
  final GestureScaleStartCallback? onScaleStart;

  /// The pointers in contact with the screen have indicated a new focal point
  /// and/or scale.
  final GestureScaleUpdateCallback? onScaleUpdate;

  /// The pointers are no longer in contact with the screen.
  final GestureScaleEndCallback? onScaleEnd;

  /// The pointer is in contact with the screen and has pressed with sufficient
  /// force to initiate a force press. The amount of force is at least
  /// [ForcePressGestureRecognizer.startPressure].
  ///
  /// This callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressStartCallback? onForcePressStart;

  /// The pointer is in contact with the screen and has pressed with the maximum
  /// force. The amount of force is at least
  /// [ForcePressGestureRecognizer.peakPressure].
  ///
  /// This callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressPeakCallback? onForcePressPeak;

  /// A pointer is in contact with the screen, has previously passed the
  /// [ForcePressGestureRecognizer.startPressure] and is either moving on the
  /// plane of the screen, pressing the screen with varying forces or both
  /// simultaneously.
  ///
  /// This callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressUpdateCallback? onForcePressUpdate;

  /// The pointer tracked by [onForcePressStart] is no longer in contact with the screen.
  ///
  /// This callback will only be fired on devices with pressure
  /// detecting screens.
  final GestureForcePressEndCallback? onForcePressEnd;

  /// How this gesture detector should behave during hit testing when deciding
  /// how the hit test propagates to children and whether to consider targets
  /// behind this one.
  ///
  /// This defaults to [HitTestBehavior.deferToChild] if [child] is not null and
  /// [HitTestBehavior.translucent] if child is null.
  ///
  /// See [HitTestBehavior] for the allowed values and their meanings.
  final HitTestBehavior? behavior;

  /// Whether to exclude these gestures from the semantics tree. For
  /// example, the long-press gesture for showing a tooltip is
  /// excluded because the tooltip itself is included in the semantics
  /// tree directly and so having a gesture to show it would result in
  /// duplication of information.
  final bool excludeFromSemantics;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], gesture drag behavior will
  /// begin at the position where the drag gesture won the arena. If set to
  /// [DragStartBehavior.down] it will begin at the position where a down event
  /// is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// Only the [DragGestureRecognizer.onStart] callbacks for the
  /// [VerticalDragGestureRecognizer], [HorizontalDragGestureRecognizer] and
  /// [PanGestureRecognizer] are affected by this setting.
  final DragStartBehavior dragStartBehavior;

  /// The kind of devices that are allowed to be recognized.
  ///
  /// If set to null, events from all device types will be recognized. Defaults to null.
  final Set<PointerDeviceKind>? supportedDevices;

  /// Whether scrolling up/down on a trackpad should cause scaling instead of panning.
  /// Defaults to false.
  final bool trackpadScrollCausesScale;

  /// A factor to control the direction and magnitude of scale when converting trackpad scrolling.
  /// Incoming trackpad pan offsets will be divided by this factor to get scale values.
  /// Increasing this offset will reduce the amount of scaling caused by a fixed amount of trackpad scrolling.
  final Offset trackpadScrollToScaleFactor;

  /// This child.
  final Widget child;

  /// Creates a [FTappable] widget.
  const FTappable({
    required this.child,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onDoubleTapDown,
    this.onDoubleTap,
    this.onDoubleTapCancel,
    this.onLongPressDown,
    this.onLongPressCancel,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onSecondaryLongPressDown,
    this.onSecondaryLongPressCancel,
    this.onSecondaryLongPress,
    this.onSecondaryLongPressStart,
    this.onSecondaryLongPressMoveUpdate,
    this.onSecondaryLongPressUp,
    this.onSecondaryLongPressEnd,
    this.onTertiaryLongPressDown,
    this.onTertiaryLongPressCancel,
    this.onTertiaryLongPress,
    this.onTertiaryLongPressStart,
    this.onTertiaryLongPressMoveUpdate,
    this.onTertiaryLongPressUp,
    this.onTertiaryLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.behavior,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.trackpadScrollCausesScale = false,
    this.trackpadScrollToScaleFactor = kDefaultTrackpadScrollToScaleFactor,
    this.supportedDevices,
    super.key,
  });

  @override
  State<FTappable> createState() => _FTappableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(EnumProperty<HitTestBehavior?>('behavior', behavior))
      ..add(EnumProperty<DragStartBehavior?>('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty<bool>('excludeFromSemantics', excludeFromSemantics))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDoubleTap', onDoubleTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDoubleTapCancel', onDoubleTapCancel))
      ..add(ObjectFlagProperty<void Function(TapDownDetails p1)?>.has('onDoubleTapDown', onDoubleTapDown))
      ..add(ObjectFlagProperty<GestureTapDownCallback?>.has('onTapDown', onTapDown))
      ..add(ObjectFlagProperty<GestureTapUpCallback?>.has('onTapUp', onTapUp))
      ..add(ObjectFlagProperty<GestureTapCancelCallback?>.has('onTapCancel', onTapCancel))
      ..add(ObjectFlagProperty<GestureTapCallback?>.has('onSecondaryTap', onSecondaryTap))
      ..add(ObjectFlagProperty<GestureTapDownCallback?>.has('onSecondaryTapDown', onSecondaryTapDown))
      ..add(ObjectFlagProperty<GestureTapUpCallback?>.has('onSecondaryTapUp', onSecondaryTapUp))
      ..add(ObjectFlagProperty<GestureTapCancelCallback?>.has('onSecondaryTapCancel', onSecondaryTapCancel))
      ..add(ObjectFlagProperty<GestureTapDownCallback?>.has('onTertiaryTapDown', onTertiaryTapDown))
      ..add(ObjectFlagProperty<GestureTapUpCallback?>.has('onTertiaryTapUp', onTertiaryTapUp))
      ..add(ObjectFlagProperty<GestureTapCancelCallback?>.has('onTertiaryTapCancel', onTertiaryTapCancel))
      ..add(ObjectFlagProperty<GestureLongPressDownCallback?>.has('onLongPressDown', onLongPressDown))
      ..add(ObjectFlagProperty<GestureLongPressCancelCallback?>.has('onLongPressCancel', onLongPressCancel))
      ..add(ObjectFlagProperty<GestureLongPressCallback?>.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty<GestureLongPressStartCallback?>.has('onLongPressStart', onLongPressStart))
      ..add(ObjectFlagProperty<GestureLongPressMoveUpdateCallback?>.has('onLongPressMoveUpdate', onLongPressMoveUpdate))
      ..add(ObjectFlagProperty<GestureLongPressUpCallback?>.has('onLongPressUp', onLongPressUp))
      ..add(ObjectFlagProperty<GestureLongPressEndCallback?>.has('onLongPressEnd', onLongPressEnd))
      ..add(ObjectFlagProperty<GestureLongPressDownCallback?>.has('onSecondaryLongPressDown', onSecondaryLongPressDown))
      ..add(ObjectFlagProperty<GestureLongPressCancelCallback?>.has(
          'onSecondaryLongPressCancel', onSecondaryLongPressCancel))
      ..add(ObjectFlagProperty<GestureLongPressCallback?>.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(ObjectFlagProperty<GestureLongPressStartCallback?>.has(
          'onSecondaryLongPressStart', onSecondaryLongPressStart))
      ..add(ObjectFlagProperty<GestureLongPressMoveUpdateCallback?>.has(
          'onSecondaryLongPressMoveUpdate', onSecondaryLongPressMoveUpdate))
      ..add(ObjectFlagProperty<GestureLongPressUpCallback?>.has('onSecondaryLongPressUp', onSecondaryLongPressUp))
      ..add(ObjectFlagProperty<GestureLongPressEndCallback?>.has('onSecondaryLongPressEnd', onSecondaryLongPressEnd))
      ..add(ObjectFlagProperty<GestureLongPressDownCallback?>.has('onTertiaryLongPressDown', onTertiaryLongPressDown))
      ..add(ObjectFlagProperty<GestureLongPressCancelCallback?>.has(
          'onTertiaryLongPressCancel', onTertiaryLongPressCancel))
      ..add(ObjectFlagProperty<GestureLongPressCallback?>.has('onTertiaryLongPress', onTertiaryLongPress))
      ..add(
          ObjectFlagProperty<GestureLongPressStartCallback?>.has('onTertiaryLongPressStart', onTertiaryLongPressStart))
      ..add(ObjectFlagProperty<GestureLongPressMoveUpdateCallback?>.has(
          'onTertiaryLongPressMoveUpdate', onTertiaryLongPressMoveUpdate))
      ..add(ObjectFlagProperty<GestureLongPressUpCallback?>.has('onTertiaryLongPressUp', onTertiaryLongPressUp))
      ..add(ObjectFlagProperty<GestureLongPressEndCallback?>.has('onTertiaryLongPressEnd', onTertiaryLongPressEnd))
      ..add(ObjectFlagProperty<GestureDragDownCallback?>.has('onVerticalDragDown', onVerticalDragDown))
      ..add(ObjectFlagProperty<GestureDragStartCallback?>.has('onVerticalDragStart', onVerticalDragStart))
      ..add(ObjectFlagProperty<GestureDragUpdateCallback?>.has('onVerticalDragUpdate', onVerticalDragUpdate))
      ..add(ObjectFlagProperty<GestureDragEndCallback?>.has('onVerticalDragEnd', onVerticalDragEnd))
      ..add(ObjectFlagProperty<GestureDragCancelCallback?>.has('onVerticalDragCancel', onVerticalDragCancel))
      ..add(ObjectFlagProperty<GestureDragDownCallback?>.has('onHorizontalDragDown', onHorizontalDragDown))
      ..add(ObjectFlagProperty<GestureDragStartCallback?>.has('onHorizontalDragStart', onHorizontalDragStart))
      ..add(ObjectFlagProperty<GestureDragUpdateCallback?>.has('onHorizontalDragUpdate', onHorizontalDragUpdate))
      ..add(ObjectFlagProperty<GestureDragEndCallback?>.has('onHorizontalDragEnd', onHorizontalDragEnd))
      ..add(ObjectFlagProperty<GestureDragCancelCallback?>.has('onHorizontalDragCancel', onHorizontalDragCancel))
      ..add(ObjectFlagProperty<GestureDragDownCallback?>.has('onPanDown', onPanDown))
      ..add(ObjectFlagProperty<GestureDragStartCallback?>.has('onPanStart', onPanStart))
      ..add(ObjectFlagProperty<GestureDragUpdateCallback?>.has('onPanUpdate', onPanUpdate))
      ..add(ObjectFlagProperty<GestureDragEndCallback?>.has('onPanEnd', onPanEnd))
      ..add(ObjectFlagProperty<GestureDragCancelCallback?>.has('onPanCancel', onPanCancel))
      ..add(ObjectFlagProperty<GestureScaleStartCallback?>.has('onScaleStart', onScaleStart))
      ..add(ObjectFlagProperty<GestureScaleUpdateCallback?>.has('onScaleUpdate', onScaleUpdate))
      ..add(ObjectFlagProperty<GestureScaleEndCallback?>.has('onScaleEnd', onScaleEnd))
      ..add(ObjectFlagProperty<GestureForcePressStartCallback?>.has('onForcePressStart', onForcePressStart))
      ..add(ObjectFlagProperty<GestureForcePressPeakCallback?>.has('onForcePressPeak', onForcePressPeak))
      ..add(ObjectFlagProperty<GestureForcePressUpdateCallback?>.has('onForcePressUpdate', onForcePressUpdate))
      ..add(ObjectFlagProperty<GestureForcePressEndCallback?>.has('onForcePressEnd', onForcePressEnd))
      ..add(IterableProperty<PointerDeviceKind>('supportedDevices', supportedDevices))
      ..add(DiagnosticsProperty<bool>('trackpadScrollCausesScale', trackpadScrollCausesScale))
      ..add(DiagnosticsProperty<Offset>('trackpadScrollToScaleFactor', trackpadScrollToScaleFactor));
  }
}

class _FTappableState extends State<FTappable> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _animation,
        child: GestureDetector(
          behavior: widget.behavior,
          dragStartBehavior: widget.dragStartBehavior,
          excludeFromSemantics: widget.excludeFromSemantics,
          onDoubleTap: widget.onDoubleTap,
          onDoubleTapCancel: widget.onDoubleTapCancel,
          onDoubleTapDown: widget.onDoubleTapDown,
          onForcePressEnd: widget.onForcePressEnd,
          onForcePressPeak: widget.onForcePressPeak,
          onForcePressStart: widget.onForcePressStart,
          onForcePressUpdate: widget.onForcePressUpdate,
          onHorizontalDragCancel: widget.onHorizontalDragCancel,
          onHorizontalDragDown: widget.onHorizontalDragDown,
          onHorizontalDragEnd: widget.onHorizontalDragEnd,
          onHorizontalDragStart: widget.onHorizontalDragStart,
          onHorizontalDragUpdate: widget.onHorizontalDragUpdate,
          onLongPress: widget.onLongPress,
          onLongPressCancel: widget.onLongPressCancel,
          onLongPressDown: widget.onLongPressDown,
          onLongPressEnd: widget.onLongPressEnd,
          onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
          onLongPressStart: widget.onLongPressStart,
          onLongPressUp: widget.onLongPressUp,
          onPanCancel: widget.onPanCancel,
          onPanDown: widget.onPanDown,
          onPanEnd: widget.onPanEnd,
          onPanStart: widget.onPanStart,
          onPanUpdate: widget.onPanUpdate,
          onScaleEnd: widget.onScaleEnd,
          onScaleStart: widget.onScaleStart,
          onScaleUpdate: widget.onScaleUpdate,
          onSecondaryLongPress: widget.onSecondaryLongPress,
          onSecondaryLongPressCancel: widget.onSecondaryLongPressCancel,
          onSecondaryLongPressDown: widget.onSecondaryLongPressDown,
          onSecondaryLongPressEnd: widget.onSecondaryLongPressEnd,
          onSecondaryLongPressMoveUpdate: widget.onSecondaryLongPressMoveUpdate,
          onSecondaryLongPressStart: widget.onSecondaryLongPressStart,
          onSecondaryLongPressUp: widget.onSecondaryLongPressUp,
          onSecondaryTap: widget.onSecondaryTap,
          onSecondaryTapCancel: widget.onSecondaryTapCancel,
          onSecondaryTapDown: widget.onSecondaryTapDown,
          onSecondaryTapUp: widget.onSecondaryTapUp,
          onTapCancel: widget.onTapCancel,
          onTapDown: widget.onTapDown,
          onTapUp: widget.onTapUp,
          onTap: widget.onTap == null
              ? null
              : () {
                  widget.onTap!();
                  _controller.forward();
                },
          onTertiaryLongPress: widget.onTertiaryLongPress,
          onTertiaryLongPressCancel: widget.onTertiaryLongPressCancel,
          onTertiaryLongPressDown: widget.onTertiaryLongPressDown,
          onTertiaryLongPressEnd: widget.onTertiaryLongPressEnd,
          onTertiaryLongPressMoveUpdate: widget.onTertiaryLongPressMoveUpdate,
          onTertiaryLongPressStart: widget.onTertiaryLongPressStart,
          onTertiaryLongPressUp: widget.onTertiaryLongPressUp,
          onTertiaryTapCancel: widget.onTertiaryTapCancel,
          onTertiaryTapDown: widget.onTertiaryTapDown,
          onTertiaryTapUp: widget.onTertiaryTapUp,
          onVerticalDragCancel: widget.onVerticalDragCancel,
          onVerticalDragDown: widget.onVerticalDragDown,
          onVerticalDragEnd: widget.onVerticalDragEnd,
          onVerticalDragStart: widget.onVerticalDragStart,
          onVerticalDragUpdate: widget.onVerticalDragUpdate,
          supportedDevices: widget.supportedDevices,
          trackpadScrollCausesScale: widget.trackpadScrollCausesScale,
          trackpadScrollToScaleFactor: widget.trackpadScrollToScaleFactor,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
