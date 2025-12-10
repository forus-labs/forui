import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
class DesignFunctionsMixin extends FunctionsMixin {
  /// The generated call function's docs.
  @protected
  final List<String> callDocs;

  /// Creates a new [DesignFunctionsMixin].
  DesignFunctionsMixin(super.element, this.callDocs);

  /// Generates a mixin.
  @override
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name}Functions'
            ..on = refer('Diagnosticable')
            ..methods.addAll([...getters, _call, if (fields.isNotEmpty) debugFillProperties, equals, hash]))
          .build();

  /// Generates a special `call` method that allows styles to be used directly.
  Method get _call => Method(
    (m) => m
      ..docs.addAll(callDocs)
      ..annotations.add(refer('useResult'))
      ..returns = refer(element.name!)
      ..name = 'call'
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..type = refer('Object?')
            ..name = '_',
        ),
      )
      ..lambda = true
      ..body = Code('this as ${element.name}'),
  );
}
