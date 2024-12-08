import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'prefer_specific_diagnostics_properties',
  problemMessage:
      'Prefer specific diagnostic properties for colors, enums, functions, iterables, primitives and icons.',
);

const _diagnosticsProperty = TypeChecker.fromName('DiagnosticsProperty', packageName: 'flutter');

const _bool = TypeChecker.fromName('bool');
const _double = TypeChecker.fromName('double');
const _iconData = TypeChecker.fromName('IconData', packageName: 'flutter');
const _int = TypeChecker.fromName('int');
const _string = TypeChecker.fromName('String');

const _enum = TypeChecker.fromName('Enum', packageName: 'dart:core');
const _color = TypeChecker.fromName('Color');
const _iterable = TypeChecker.fromName('Iterable');

/// A lint rule that checks if a DiagnosticsProperty is created with a type.
class PreferSpecificDiagnosticsProperties extends DartLintRule {
  /// Creates a new [PreferSpecificDiagnosticsProperties].
  const PreferSpecificDiagnosticsProperties() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.staticType case final type when type == null || !_diagnosticsProperty.isExactlyType(type)) {
        return;
      }

      if (node.argumentList.length < 2) {
        return;
      }

      final type = node.argumentList.arguments[1].staticType;
      if (type == null) {
        return;
      }

      final recommendation = switch (type) {
        _ when _bool.isAssignableFromType(type) => ('bools', 'FlagProperty'),
        _ when _double.isAssignableFromType(type) => ('doubles', 'DoubleProperty/PercentageProperty'),
        _ when _iconData.isAssignableFromType(type) => ('IconData', 'IconDataProperty'),
        _ when _int.isAssignableFromType(type) => ('ints', 'IntProperty'),
        _ when _string.isAssignableFromType(type) => ('strings', 'StringProperty'),
        _ when (type is InterfaceType) && type.allSupertypes.any(_enum.isExactlyType) => ('enums', 'EnumProperty'),
        _ when _color.isAssignableFromType(type) => ('colors', 'ColorProperty'),
        _ when _iterable.isAssignableFromType(type) => ('iterables', 'IterableProperty'),
        _ when type is FunctionType => ('functions', 'ObjectFlagProperty'),
        _ => null,
      };

      if (recommendation == null) {
        return;
      }

      reporter.atNode(
        node,
        LintCode(
          name: 'prefer_specific_diagnostics_properties',
          problemMessage: 'Prefer specific diagnostic properties, ${recommendation.$2}, for ${recommendation.$1}',
        ),
      );
    });
  }
}
