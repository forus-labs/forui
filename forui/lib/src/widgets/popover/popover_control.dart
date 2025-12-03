import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Defines how a popover's shown state is controlled.
sealed class FPopoverControl {
  /// Creates a [FPopoverControl] for controlling a popover using lifted state.
  ///
  /// The [shown] parameter indicates whether the popover is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FPopoverControl.lifted({
    required bool shown,
    required void Function(bool shown) onChange,
    FPopoverMotion motion,
  }) = Lifted;

  /// Creates a [FPopoverControl] for controlling a popover using a controller.
  ///
  /// Either [controller] or [motion] can be provided. If neither is provided,
  /// an internal controller with default motion is created.
  ///
  /// The [onChange] callback is invoked when the popover's shown state changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [motion] are provided.
  const factory FPopoverControl.managed({
    FPopoverController? controller,
    FPopoverMotion? motion,
    void Function(bool shown)? onChange,
  }) = Managed;
}

@internal
class Lifted with Diagnosticable implements FPopoverControl {
  final bool shown;
  final void Function(bool shown) onChange;
  final FPopoverMotion motion;

  const Lifted({required this.shown, required this.onChange, this.motion = const FPopoverMotion()});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('shown', value: shown, ifTrue: 'shown'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(DiagnosticsProperty('motion', motion));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lifted &&
          runtimeType == other.runtimeType &&
          shown == other.shown &&
          onChange == other.onChange &&
          motion == other.motion;

  @override
  int get hashCode => Object.hash(shown, onChange, motion);
}

@internal
class Managed with Diagnosticable implements FPopoverControl {
  final FPopoverController? controller;
  final FPopoverMotion? motion;
  final void Function(bool shown)? onChange;

  const Managed({this.controller, this.motion, this.onChange})
    : assert(
        controller == null || motion == null,
        'Cannot provide both controller and motion',
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('motion', motion))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          motion == other.motion &&
          onChange == other.onChange;

  @override
  int get hashCode => Object.hash(controller, motion, onChange);
}
