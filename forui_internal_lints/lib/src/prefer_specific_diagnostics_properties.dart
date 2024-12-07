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

  @override
  List<DartFix> getFixes() => [_Fix()];
}

class _Fix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!node.sourceRange.intersects(analysisError.sourceRange)) {
        return;
      }

      final type = node.staticType; // DiagnosticsProperty.lazy is not supported.
      if (type == null || node.constructorName.name != null) {
        return;
      }

      reporter
          .createChangeBuilder(message: 'Use specific DiagnosticsProperties.', priority: 100)
          .addDartFileEdit((builder) {
        switch (type) {
          // FlagProperty (bool) is not supported.
          case _ when _double.isExactlyType(type):
            // It may be more appropriate to use a PercentageProperty but there is no simple way to infer that.
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'DoubleProperty');
          case _ when _int.isExactlyType(type):
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'IntProperty');
          case _ when _string.isExactlyType(type):
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'StringProperty');
          case _ when _iconData.isExactlyType(type):
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'IconDataProperty');

          case _ when type.isDartCoreEnum:
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'EnumProperty');
          case _ when type.isDartCoreFunction:
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'ObjectFlagProperty.has');

          case _ when _color.isAssignableFromType(type):
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'ColorProperty');
          case _ when _iterable.isAssignableFromType(type):
            builder.addSimpleReplacement(node.constructorName.sourceRange, 'IterableProperty');
        }
      });
    });
  }
}
