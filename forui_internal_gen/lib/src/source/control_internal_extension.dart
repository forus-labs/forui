import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

/// Generates an `@internal` extension on a sealed control class that delegates
/// public methods to private implementations.
@internal
class ControlInternalExtension {
  /// The sealed parent class.
  final ClassElement supertype;

  /// The `_create` method from the sealed parent, if any.
  final MethodElement? create;

  /// The `_update` method from the sealed parent, if any.
  final MethodElement? update;

  /// The `_dispose` method from the sealed parent, if any.
  final MethodElement? dispose;

  /// Creates a new [ControlInternalExtension].
  ControlInternalExtension({
    required this.supertype,
    required this.create,
    required this.update,
    required this.dispose,
  });

  /// Generates the extension.
  Extension generate() =>
      (ExtensionBuilder()
            ..annotations.add(refer('internal'))
            ..name = 'Internal${supertype.name}'
            ..on = refer(supertype.name!)
            ..methods.addAll([
              if (create != null) _delegate(create!),
              if (update != null) _delegate(update!),
              if (dispose != null) _delegate(dispose!),
            ]))
          .build();

  /// Generates a method that delegates to a private method.
  Method _delegate(MethodElement method) {
    final paramNames = method.formalParameters.map((p) => p.name!).join(', ');

    return Method(
      (m) => m
        ..returns = refer(method.returnType.getDisplayString())
        ..name = method.name!.replaceFirst('_', '')
        ..requiredParameters.addAll([
          for (final parameter in method.formalParameters)
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(parameter.type.getDisplayString()),
            ),
        ])
        ..lambda = true
        ..body = Code('${method.name!}($paramNames)'),
    );
  }
}
