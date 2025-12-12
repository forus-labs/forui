import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates an `@internal` extension on a sealed control class that delegates
/// public methods to private implementations.
@internal
class ControlInternalExtension {
  /// The sealed parent class.
  final ClassElement supertype;

  /// The `_update` method.
  final MethodElement update;

  /// The `create` method.
  final Method createController;

  /// The `_dispose` method.
  final Method dispose;

  /// Creates a new [ControlInternalExtension].
  ControlInternalExtension({
    required this.supertype,
    required this.update,
    required this.createController,
    required this.dispose,
  });

  /// Generates the extension.
  Extension generate() {
    final typeParameters = supertype.typeParameters.isEmpty
        ? ''
        : '<${supertype.typeParameters.map((t) => t.name).join(', ')}>';

    return (ExtensionBuilder()
          ..annotations.add(refer('internal'))
          ..name = 'Internal${supertype.name}'
          ..types.addAll([for (final t in supertype.typeParameters) refer(t.name!)])
          ..on = refer('${supertype.name}$typeParameters')
          ..methods.addAll([
            (createController.toBuilder()
                  ..annotations.clear()
                  ..docs.clear()
                  ..name = 'create'
                  ..lambda = true
                  ..requiredParameters.insert(
                    0,
                    Parameter(
                      (p) => p
                        ..name = 'callback'
                        ..type = refer('VoidCallback'),
                    ),
                  )
                  ..body = Code('''
                    createController(${createController.requiredParameters.map((p) => p.name).join(', ')})
                    ..addListener(callback)
            '''))
                .build(),
            _update,
            (dispose.toBuilder()
                  ..name = dispose.name!.replaceFirst('_', '')
                  ..lambda = true
                  ..body = Code('''
                    ${dispose.name!}(${dispose.requiredParameters.map((p) => p.name).join(', ')})
            '''))
                .build(),
          ]))
        .build();
  }

  Method get _update {
    final paramNames = update.formalParameters.map((p) => p.name!).join(', ');

    return Method(
      (m) => m
        ..returns = refer(update.returnType.getDisplayString())
        ..name = update.name!.replaceFirst('_', '')
        ..requiredParameters.addAll([
          for (final parameter in update.formalParameters)
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(aliasAwareType(parameter.type)),
            ),
        ])
        ..lambda = true
        ..body = Code('${update.name!}($paramNames)'),
    );
  }
}
