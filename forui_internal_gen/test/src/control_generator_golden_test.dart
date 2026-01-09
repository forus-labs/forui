import 'package:build_test/build_test.dart';
import 'package:forui_internal_gen/forui_internal_gen.dart';
import 'package:test/test.dart';

const _source = r'''
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'example.control.dart';

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
  FGoldenController createController(int children) => FGoldenController();

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
  FGoldenController createController(int children) => controller ?? FGoldenController();
}
''';

const _golden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'example.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFGoldenControl on FGoldenControl {
  FGoldenController create(VoidCallback callback, int children) => createController(children)..addListener(callback);

  (FGoldenController, bool) update(
    FGoldenControl old,
    FGoldenController controller,
    VoidCallback callback,
    int children,
  ) => _update(old, controller, callback, children);

  void dispose(FGoldenController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FGoldenControlMixin {
  /// Creates a [FGoldenController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FGoldenController createController(int children);
  void _dispose(FGoldenController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FGoldenController _default(FGoldenControl old, FGoldenController controller, VoidCallback callback, int children) =>
      controller;
}
mixin _$LiftedMixin on Diagnosticable, FGoldenControl {
  bool Function(int) get expanded;
  void Function(int, bool) get onChange;
  @override
  (FGoldenController, bool) _update(
    FGoldenControl old,
    FGoldenController controller,
    VoidCallback callback,
    int children,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, children), false);

      // Lifted (Value A) -> Lifted (Value B)
      case Lifted() when old.runtimeType == runtimeType:
        _updateController(controller, children);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case Lifted():
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      // External -> Lifted
      case Managed(controller: _?):
        controller.removeListener(callback);
        return (createController(children)..addListener(callback), true);

      // Internal -> Lifted
      case Managed():
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, children), false);
    }
  }

  void _updateController(FGoldenController controller, int children);
  @override
  void _dispose(FGoldenController controller, VoidCallback callback) {
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
      identical(this, other) ||
      (other is Lifted && runtimeType == other.runtimeType && expanded == other.expanded && onChange == other.onChange);

  @override
  int get hashCode => expanded.hashCode ^ onChange.hashCode;
}
mixin _$ManagedMixin on Diagnosticable, FGoldenControl {
  FGoldenController? get controller;
  int? get min;
  int? get max;
  @override
  (FGoldenController, bool) _update(
    FGoldenControl old,
    FGoldenController controller,
    VoidCallback callback,
    int children,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback, children), false);

      // External (Controller A) -> External (Controller B)
      case Managed(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController(children)..addListener(callback), true);

      // Internal -> External
      case Managed(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      // External -> Internal
      case Managed(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController(children)..addListener(callback), true);

      // Lifted -> Managed
      case Lifted():
        controller.dispose();
        return (createController(children)..addListener(callback), true);

      default:
        return (_default(old, controller, callback, children), false);
    }
  }

  @override
  void _dispose(FGoldenController controller, VoidCallback callback) {
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
      (other is Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          min == other.min &&
          max == other.max);

  @override
  int get hashCode => controller.hashCode ^ min.hashCode ^ max.hashCode;
}
''';

const _typeParametersSource = r'''
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'example.control.dart';

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
  FGenericController<T> createController() => FGenericController<T>();

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
  FGenericController<T> createController() => controller ?? FGenericController<T>();
}
''';

const _typeParametersGolden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'example.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFGenericControl<T> on FGenericControl<T> {
  FGenericController<T> create(VoidCallback callback) => createController()..addListener(callback);

  (FGenericController<T>, bool) update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    VoidCallback callback,
  ) => _update(old, controller, callback);

  void dispose(FGenericController<T> controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FGenericControlMixin<T> {
  /// Creates a [FGenericController<T>].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FGenericController<T> createController();
  void _dispose(FGenericController<T> controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FGenericController<T> _default(FGenericControl<T> old, FGenericController<T> controller, VoidCallback callback) =>
      controller;
}
mixin _$LiftedMixin<T> on Diagnosticable, FGenericControl<T> {
  T? get value;
  void Function(T?) get onChange;
  @override
  (FGenericController<T>, bool) _update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // Lifted (Value A) -> Lifted (Value B)
      case Lifted() when old.runtimeType == runtimeType:
        _updateController(controller);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Lifted
      case Managed(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case Managed():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FGenericController<T> controller);
  @override
  void _dispose(FGenericController<T> controller, VoidCallback callback) {
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
      identical(this, other) ||
      (other is Lifted<T> && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}
mixin _$ManagedMixin<T> on Diagnosticable, FGenericControl<T> {
  FGenericController<T>? get controller;
  T? get initialValue;
  @override
  (FGenericController<T>, bool) _update(
    FGenericControl<T> old,
    FGenericController<T> controller,
    VoidCallback callback,
  ) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case Managed(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case Managed(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case Managed(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FGenericController<T> controller, VoidCallback callback) {
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
      (other is Managed<T> &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initialValue == other.initialValue);

  @override
  int get hashCode => controller.hashCode ^ initialValue.hashCode;
}
''';

const _managedSubclassesSource = r'''
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'example.control.dart';

class FSubclassController {
  void addListener(void Function() callback) {}
  void removeListener(void Function() callback) {}
  void dispose() {}
}

sealed class FSubclassControl with Diagnosticable, _$FSubclassControlMixin {
  const factory FSubclassControl.lifted({
    required int value,
    required void Function(int) onChange,
  }) = Lifted;

  const factory FSubclassControl.normal({
    FSubclassController? controller,
    void Function(int)? onChange,
  }) = Normal;

  const factory FSubclassControl.cascade({
    FSubclassController? controller,
    void Function(int)? onChange,
  }) = Cascade;

  const FSubclassControl._();

  (FSubclassController, bool) _update(
    FSubclassControl old,
    FSubclassController controller,
    VoidCallback callback,
  );
}

@internal
class Lifted extends FSubclassControl with _$LiftedMixin {
  @override
  final int value;
  @override
  final void Function(int) onChange;

  const Lifted({required this.value, required this.onChange}) : super._();

  @override
  FSubclassController createController() => FSubclassController();

  @override
  void _updateController(FSubclassController controller) {}
}

@internal
abstract class Managed extends FSubclassControl with _$ManagedMixin {
  @override
  final FSubclassController? controller;
  @override
  final void Function(int)? onChange;

  const Managed({this.controller, this.onChange}) : super._();
}

@internal
class Normal extends Managed with _$NormalMixin {
  const Normal({super.controller, super.onChange});

  @override
  FSubclassController createController() => controller ?? FSubclassController();
}

@internal
class Cascade extends Managed with _$CascadeMixin {
  const Cascade({super.controller, super.onChange});

  @override
  FSubclassController createController() => controller ?? FSubclassController();
}
''';

const _managedSubclassesGolden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks

part of 'example.dart';

// **************************************************************************
// ControlGenerator
// **************************************************************************

@internal
extension InternalFSubclassControl on FSubclassControl {
  FSubclassController create(VoidCallback callback) => createController()..addListener(callback);

  (FSubclassController, bool) update(FSubclassControl old, FSubclassController controller, VoidCallback callback) =>
      _update(old, controller, callback);

  void dispose(FSubclassController controller, VoidCallback callback) => _dispose(controller, callback);
}

mixin _$FSubclassControlMixin {
  /// Creates a [FSubclassController].
  ///
  /// Overriding managed subclasses should always return `controller` if it is non-null, e.g. `return controller ?? MyController();`
  @visibleForOverriding
  FSubclassController createController();
  void _dispose(FSubclassController controller, VoidCallback callback);
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  FSubclassController _default(FSubclassControl old, FSubclassController controller, VoidCallback callback) =>
      controller;
}
mixin _$LiftedMixin on Diagnosticable, FSubclassControl {
  int get value;
  void Function(int) get onChange;
  @override
  (FSubclassController, bool) _update(FSubclassControl old, FSubclassController controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // Lifted (Value A) -> Lifted (Value B)
      case Lifted() when old.runtimeType == runtimeType:
        _updateController(controller);
        return (controller, true);

      // LiftedFoo -> LiftedBar
      case Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Lifted
      case Managed(controller: _?):
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> Lifted
      case Managed():
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  void _updateController(FSubclassController controller);
  @override
  void _dispose(FSubclassController controller, VoidCallback callback) {
    controller.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('value', value, level: .debug))
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lifted && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange);

  @override
  int get hashCode => value.hashCode ^ onChange.hashCode;
}
mixin _$ManagedMixin on Diagnosticable, FSubclassControl {
  FSubclassController? get controller;
  void Function(int)? get onChange;
  @override
  (FSubclassController, bool) _update(FSubclassControl old, FSubclassController controller, VoidCallback callback) {
    switch (old) {
      case _ when old == this:
        return (_default(old, controller, callback), false);

      // External (Controller A) -> External (Controller B)
      case Managed(controller: final old?) when this.controller != null && this.controller != old:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Internal -> External
      case Managed(controller: final old) when this.controller != null && old == null:
        controller.dispose();
        return (createController()..addListener(callback), true);

      // External -> Internal
      case Managed(controller: _?) when this.controller == null:
        controller.removeListener(callback);
        return (createController()..addListener(callback), true);

      // Lifted -> Managed
      case Lifted():
        controller.dispose();
        return (createController()..addListener(callback), true);

      // Internal -> Internal (different type, e.g. Normal -> Cascade)
      case final Managed old when old.runtimeType != runtimeType:
        controller.dispose();
        return (createController()..addListener(callback), true);

      default:
        return (_default(old, controller, callback), false);
    }
  }

  @override
  void _dispose(FSubclassController controller, VoidCallback callback) {
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
      ..add(DiagnosticsProperty('onChange', onChange, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ onChange.hashCode;
}
mixin _$NormalMixin on Diagnosticable, FSubclassControl {
  FSubclassController? get controller;
  void Function(int)? get onChange;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Normal &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ onChange.hashCode;
}
mixin _$CascadeMixin on Diagnosticable, FSubclassControl {
  FSubclassController? get controller;
  void Function(int)? get onChange;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cascade &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          onChange == other.onChange);

  @override
  int get hashCode => controller.hashCode ^ onChange.hashCode;
}
''';

void main() {
  late TestReaderWriter readerWriter;

  setUpAll(() async {
    readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();
  });

  test('no type parameters', () async {
    await testBuilder(
      controlBuilder(.empty),
      {'forui_internal_gen|test/src/example.dart': _source},
      outputs: {'forui_internal_gen|test/src/example.control.dart': _golden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));

  test('with type parameters', () async {
    await testBuilder(
      controlBuilder(.empty),
      {'forui_internal_gen|test/src/example.dart': _typeParametersSource},
      outputs: {'forui_internal_gen|test/src/example.control.dart': _typeParametersGolden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));

  test('with managed subclasses', () async {
    await testBuilder(
      controlBuilder(.empty),
      {'forui_internal_gen|test/src/example.dart': _managedSubclassesSource},
      outputs: {'forui_internal_gen|test/src/example.control.dart': _managedSubclassesGolden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
}
