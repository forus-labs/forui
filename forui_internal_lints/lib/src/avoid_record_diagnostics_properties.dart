import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'avoid_record_diagnostics_properties',
  problemMessage: 'Avoid using records in DiagnosticsProperty. Convert it to a string via toString() first.',
  errorSeverity: ErrorSeverity.ERROR,
);

const _any = TypeChecker.any([
  TypeChecker.fromName('DiagnosticsProperty', packageName: 'flutter'),
  TypeChecker.fromName('ObjectFlagProperty', packageName: 'flutter'),
]);

/// A lint rule that checks if a DiagnosticsProperty is created with a type.
class AvoidRecordDiagnosticsProperties extends DartLintRule {
  /// Creates a new [AvoidRecordDiagnosticsProperties].
  const AvoidRecordDiagnosticsProperties() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.staticType case final type when type == null || !_any.isExactlyType(type)) {
        return;
      }

      if (node.argumentList.length < 2) {
        return;
      }

      final type = node.argumentList.arguments[1].staticType;
      if (type is RecordType) {
        reporter.atNode(node, _code);
      }
    });
  }
}
