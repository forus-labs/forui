import 'package:analyzer/error/error.dart';
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

const _exact = TypeChecker.any([
  _bool,
  _double,
  _iconData,
  _int,
  _string,
]);

const _color = TypeChecker.fromName('Color', packageName: 'flutter');
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

      if (_exact.isExactlyType(type) ||
          type.isDartCoreEnum ||
          type.isDartCoreFunction ||
          _color.isAssignableFromType(type) ||
          _iterable.isAssignableFromType(type)) {
        reporter.atNode(node, _code);
      }
    });
  }
}
