import 'package:build_test/build_test.dart';
import 'package:forui_internal_gen/forui_internal_gen.dart';
import 'package:test/test.dart';

const _source = r'''
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'sample.control.dart';

class FGoldenController {
  void addListener(void Function() callback) {}
  void removeListener(void Function() callback) {}
  void dispose() {}
}

sealed class FGoldenControl with Diagnosticable {
  const factory FGoldenControl.lifted({
    required bool Function(int) expanded,
    required void Function(int, bool) onChange,
  }) = Lifted;

  const factory FGoldenControl.managed({
    FGoldenController? controller,
    int? min,
    int? max,
  }) = Managed;

  const FGoldenControl._();

  FGoldenController _create(VoidCallback callback, int children);

  FGoldenController _update(
    FGoldenControl old,
    FGoldenController controller,
    VoidCallback callback,
    int children,
  );

  void _dispose(FGoldenController controller, VoidCallback callback);
}

@internal
final class Lifted extends FGoldenControl with _$LiftedFunctions {
  @override
  final bool Function(int) expanded;
  @override
  final void Function(int, bool) onChange;

  const Lifted({required this.expanded, required this.onChange}) : super._();

  @override
  FGoldenController _create(VoidCallback _, int children) => FGoldenController();

  @override
  void _updateController(FGoldenController controller, int children) {}
}

@internal
final class Managed extends FGoldenControl with _$ManagedFunctions {
  @override
  final FGoldenController? controller;
  @override
  final int? min;
  @override
  final int? max;

  const Managed({this.controller, this.min, this.max}) : super._();

  @override
  FGoldenController _create(VoidCallback callback, int children) =>
      (controller ?? FGoldenController())..addListener(callback);
}
''';

const _golden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: avoid_positional_boolean_parameters

part of 'sample.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFGoldenControl on FGoldenControl {
  FGoldenController create(void Function() callback, int children) => _create(callback, children);

  FGoldenController update(FGoldenControl old, FGoldenController controller, void Function() callback, int children) =>
      _update(old, controller, callback, children);

  void dispose(FGoldenController controller, void Function() callback) => _dispose(controller, callback);
}

mixin _$LiftedFunctions on Diagnosticable implements FGoldenControl {
  bool Function(int) get expanded;
  void Function(int, bool) get onChange;
  @override
  FGoldenController _update(FGoldenControl old, FGoldenController controller, void Function() callback, int children) {
    switch (old) {
      case _ when old == this:
        return controller;

      // Lifted (Value A) -> Lifted (Value B)
      case Lifted():
        _updateController(controller, children);
        return controller;

      // External -> Lifted
      case Managed(controller: _?):
        controller.removeListener(callback);
        return _createController(callback, children);

      // Internal -> Lifted
      case Managed():
        controller.dispose();
        return _createController(callback, children);

      default:
        return controller;
    }
  }

  FGoldenController _createController(void Function() callback, int children) => _create(callback, children);

  void _updateController(FGoldenController controller, int children);
  @override
  void _dispose(FGoldenController controller, void Function() callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expanded', expanded, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Lifted && expanded == other.expanded && onChange == other.onChange);

  @override
  int get hashCode => expanded.hashCode ^ onChange.hashCode;
}
mixin _$ManagedFunctions on Diagnosticable implements FGoldenControl {
  FGoldenController? get controller;
  int? get min;
  int? get max;
  @override
  FGoldenController _update(FGoldenControl old, FGoldenController controller, void Function() callback, int children) {
    switch (old) {
      case _ when old == this:
        return controller;

      // External (Controller A) -> External (Controller B)
      case Managed(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return _createController(callback, children);

      // Internal -> External
      case Managed(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return _createController(callback, children);

      // External -> Internal
      case Managed(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return _createController(callback, children);

      // Lifted -> Managed
      case Lifted():
        controller.dispose();
        return _createController(callback, children);

      default:
        return controller;
    }
  }

  FGoldenController _createController(void Function() callback, int children) => _create(callback, children);

  @override
  void _dispose(FGoldenController controller, void Function() callback) {
    if (this.controller != null) {
      controller.removeListener(callback);
    } else {
      controller.dispose();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller, level: .debug))
      ..add(IntProperty('min', min, level: .debug))
      ..add(IntProperty('max', max, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Managed && controller == other.controller && min == other.min && max == other.max);

  @override
  int get hashCode => controller.hashCode ^ min.hashCode ^ max.hashCode;
}
''';

void main() {
  test('control', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      controlBuilder(.empty),
      {'forui_internal_gen|test/src/sample.dart': _source},
      outputs: {'forui_internal_gen|test/src/sample.control.dart': _golden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
}
