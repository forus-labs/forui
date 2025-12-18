part of 'resizable_controller.dart';

/// A [FResizableControl] defines how a [FResizable] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FResizableControl with Diagnosticable, _$FResizableControlMixin {
  /// Creates a [FResizableControl] with a non-cascading controller.
  ///
  /// The [controller] is the controller. If not provided, an internal controller is created.
  /// The [onResizeUpdate] is called while resizing.
  /// The [onResizeEnd] is called after resizing completes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [controller] and [onResizeUpdate]/[onResizeEnd] are both provided.
  const factory FResizableControl.managed({
    FResizableController? controller,
    ValueChanged<List<FResizableRegionData>>? onResizeUpdate,
    ValueChanged<List<FResizableRegionData>>? onResizeEnd,
  }) = _Managed;

  /// Creates a [FResizableControl] with a cascading controller.
  ///
  /// Cascading allows shrinking a region below its minimum extent to propagate to its neighbors.
  ///
  /// The [controller] is the controller. If not provided, an internal controller is created.
  /// The [onResizeUpdate] is called while resizing.
  /// The [onResizeEnd] is called after resizing completes with all regions.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [controller] and [onResizeUpdate]/[onResizeEnd] are both provided.
  const factory FResizableControl.managedCascade({
    FResizableController? controller,
    ValueChanged<List<FResizableRegionData>>? onResizeUpdate,
    ValueChanged<UnmodifiableListView<FResizableRegionData>>? onResizeEnd,
  }) = _ManagedCascade;

  const FResizableControl._();

  (FResizableController, bool) _update(FResizableControl old, FResizableController controller, VoidCallback callback);
}

/// A [FResizableManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
abstract class FResizableManagedControl extends FResizableControl with _$FResizableManagedControlMixin {
  /// The controller.
  @override
  final FResizableController? controller;

  /// Called while a resizable region and its neighbours are being resized.
  @override
  final ValueChanged<List<FResizableRegionData>>? onResizeUpdate;

  /// Creates a [FResizableManagedControl].
  const FResizableManagedControl({this.controller, this.onResizeUpdate}) : super._();
}

class _Managed extends FResizableManagedControl {
  /// Called after a resizable region and its neighbours have been resized.
  final ValueChanged<List<FResizableRegionData>>? onResizeEnd;

  const _Managed({super.controller, super.onResizeUpdate, this.onResizeEnd})
    : assert(
        controller == null || onResizeUpdate == null,
        'Cannot provide both controller and onResizeUpdate. Pass onResizeUpdate to the controller instead.',
      ),
      assert(
        controller == null || onResizeEnd == null,
        'Cannot provide both controller and onResizeEnd. Pass onResizeEnd to the controller instead.',
      );

  @override
  FResizableController createController() =>
      controller ?? .new(onResizeUpdate: onResizeUpdate, onResizeEnd: onResizeEnd);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('onResizeEnd', onResizeEnd));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          onResizeUpdate == other.onResizeUpdate &&
          onResizeEnd == other.onResizeEnd);

  @override
  int get hashCode => Object.hash(controller, onResizeUpdate, onResizeEnd);
}

class _ManagedCascade extends FResizableManagedControl {
  /// Called after a resizable region and its neighbours have been resized.
  final ValueChanged<UnmodifiableListView<FResizableRegionData>>? onResizeEnd;

  const _ManagedCascade({super.controller, super.onResizeUpdate, this.onResizeEnd})
    : assert(
        controller == null || onResizeUpdate == null,
        'Cannot provide both controller and onResizeUpdate. Pass onResizeUpdate to the controller instead.',
      ),
      assert(
        controller == null || onResizeEnd == null,
        'Cannot provide both controller and onResizeEnd. Pass onResizeEnd to the controller instead.',
      );

  @override
  FResizableController createController() =>
      controller ?? .cascade(onResizeUpdate: onResizeUpdate, onResizeEnd: onResizeEnd);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('onResizeEnd', onResizeEnd));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _ManagedCascade &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          onResizeUpdate == other.onResizeUpdate &&
          onResizeEnd == other.onResizeEnd);

  @override
  int get hashCode => Object.hash(controller, onResizeUpdate, onResizeEnd);
}

// TODO: Add support for lifted resizable.
class _Lifted extends FResizableControl with _$_LiftedMixin {
  const _Lifted() : super._();

  @override
  FResizableController createController() => throw UnimplementedError();

  @override
  void _updateController(FResizableController _) {}
}
