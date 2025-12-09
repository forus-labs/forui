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

sealed class FGoldenControl with Diagnosticable, _$FGoldenControlMixin {
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

  (FGoldenController, bool) _update(
    FGoldenControl old,
    FGoldenController controller,
    VoidCallback callback,
    int children,
  );
}

@internal
final class Lifted extends FGoldenControl with _$LiftedMixin {
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
final class Managed extends FGoldenControl with _$ManagedMixin {
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
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters

part of 'sample.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFGoldenControl on FGoldenControl {
  FGoldenController create(void Function() callback, int children) => _create(callback, children);

  (FGoldenController, bool) update(
    FGoldenControl old,
    FGoldenController controller,
    void Function() callback,
    int children,
  ) => _update(old, controller, callback, children);

  void dispose(FGoldenController controller, void Function() callback) => _dispose(controller, callback);
}

mixin _$FGoldenControlMixin {
  FGoldenController _create(void Function() callback, int children);
  void _dispose(FGoldenController controller, void Function() callback);
  FGoldenController _default(
    FGoldenControl old,
    FGoldenController controller,
    void Function() callback,
    int children,
  ) => controller;
}
mixin _$LiftedMixin on Diagnosticable implements FGoldenControl {
  bool Function(int) get expanded;
  void Function(int, bool) get onChange;
  @override
  (FGoldenController, bool) _update(
    FGoldenControl old,
    FGoldenController controller,
    void Function() callback,
    int children,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, children), false);

      // Lifted (Value A) -> Lifted (Value B)
      case Lifted():
        _updateController(controller, children);
        return (controller, true);

      // External -> Lifted
      case Managed(controller: _?):
        controller.removeListener(callback);
        return (_create(callback, children), true);

      // Internal -> Lifted
      case Managed():
        controller.dispose();
        return (_create(callback, children), true);

      default:
        return (_default(old, controller, callback, children), false);
    }
  }

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
mixin _$ManagedMixin on Diagnosticable implements FGoldenControl {
  FGoldenController? get controller;
  int? get min;
  int? get max;
  @override
  (FGoldenController, bool) _update(
    FGoldenControl old,
    FGoldenController controller,
    void Function() callback,
    int children,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, children), false);

      // External (Controller A) -> External (Controller B)
      case Managed(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (_create(callback, children), true);

      // Internal -> External
      case Managed(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (_create(callback, children), true);

      // External -> Internal
      case Managed(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (_create(callback, children), true);

      // Lifted -> Managed
      case Lifted():
        controller.dispose();
        return (_create(callback, children), true);

      default:
        return (_default(old, controller, callback, children), false);
    }
  }

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

const _typeParametersSource = r'''
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'sample.control.dart';

class FGenericController<T> {
  void addListener(void Function() callback) {}
  void removeListener(void Function() callback) {}
  void dispose() {}
}

sealed class FGenericControl<T> with Diagnosticable, _$FGenericControlMixin<T> {
  const factory FGenericControl.lifted({
    required T? value,
    required void Function(T?) onChange,
  }) = Lifted<T>;

  const factory FGenericControl.managed({
    FGenericController<T>? controller,
    T? initialValue,
  }) = Managed<T>;

  const FGenericControl._();

  (FGenericController<T>, bool) _update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    VoidCallback callback,
  );
}

@internal
final class Lifted<T> extends FGenericControl<T> with _$LiftedMixin<T> {
  @override
  final T? value;
  @override
  final void Function(T?) onChange;

  const Lifted({required this.value, required this.onChange}) : super._();

  @override
  FGenericController<T> _create(VoidCallback _) => FGenericController<T>();

  @override
  void _updateController(FGenericController<T> controller) {}
}

@internal
final class Managed<T> extends FGenericControl<T> with _$ManagedMixin<T> {
  @override
  final FGenericController<T>? controller;
  @override
  final T? initialValue;

  const Managed({this.controller, this.initialValue}) : super._();

  @override
  FGenericController<T> _create(VoidCallback callback) =>
      (controller ?? FGenericController<T>())..addListener(callback);
}
''';

const _typeParametersGolden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters

part of 'sample.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFGenericControl<T> on FGenericControl<T> {
  FGenericController<T> create(void Function() callback) => _create(callback);

  (FGenericController<T>, bool) update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    void Function() callback,
  ) => _update(old, controller, callback);

  void dispose(FGenericController<T> controller, void Function() callback) => _dispose(controller, callback);
}

mixin _$FGenericControlMixin<T> {
  FGenericController<T> _create(void Function() callback);
  void _dispose(FGenericController<T> controller, void Function() callback);
  FGenericController<T> _default(FGenericControl<T> old, FGenericController<T> controller, void Function() callback) =>
      controller;
}
mixin _$LiftedMixin<T> on Diagnosticable implements FGenericControl<T> {
  T? get value;
  void Function(T?) get onChange;
  @override
  (FGenericController<T>, bool) _update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    void Function() callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // Lifted (Value A) -> Lifted (Value B)
      case Lifted():
        _updateController(controller);
        return (controller, true);

      // External -> Lifted
      case Managed(controller: _?):
        controller.removeListener(callback);
        return (_create(callback), true);

      // Internal -> Lifted
      case Managed():
        controller.dispose();
        return (_create(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FGenericController<T> controller);
  @override
  void _dispose(FGenericController<T> controller, void Function() callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Lifted<T> && value == other.value && onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}
mixin _$ManagedMixin<T> on Diagnosticable implements FGenericControl<T> {
  FGenericController<T>? get controller;
  T? get initialValue;
  @override
  (FGenericController<T>, bool) _update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    void Function() callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case Managed(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (_create(callback), true);

      // Internal -> External
      case Managed(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (_create(callback), true);

      // External -> Internal
      case Managed(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (_create(callback), true);

      // Lifted -> Managed
      case Lifted():
        controller.dispose();
        return (_create(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FGenericController<T> controller, void Function() callback) {
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
      ..add(DiagnosticsProperty('initialValue', initialValue, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Managed<T> && controller == other.controller && initialValue == other.initialValue);

  @override
  int get hashCode => controller.hashCode ^ initialValue.hashCode;
}
''';

void main() {
  test('no type parameters', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      controlBuilder(.empty),
      {'forui_internal_gen|test/src/sample.dart': _source},
      outputs: {'forui_internal_gen|test/src/sample.control.dart': _golden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));

  test('with type parameters', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      controlBuilder(.empty),
      {'forui_internal_gen|test/src/sample.dart': _typeParametersSource},
      outputs: {'forui_internal_gen|test/src/sample.control.dart': _typeParametersGolden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
}
