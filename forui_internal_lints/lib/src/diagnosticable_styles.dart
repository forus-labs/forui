import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'diagnosticable_styles',
  problemMessage: 'Style(s) should be assignable to Diagnosticable.',
);

const _suffixes = {'Style', 'Styles'};

const _checker = TypeChecker.fromName('Diagnosticable', packageName: 'flutter');

/// A lint rule that checks if a class ending with 'Style' or 'Styles' is assignable to Diagnosticable.
class DiagnosticableStylesRule extends DartLintRule {
  /// Creates a new [DiagnosticableStylesRule].
  const DiagnosticableStylesRule() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addClassDeclaration((node) {
      final declared = node.declaredElement;

      if (declared?.name case final name? when _suffixes.every((s) => !name.endsWith(s))) {
        return;
      }

      if (declared case final declared? when declared.isConstructable && !_checker.isAssignableFrom(declared)) {
        reporter.atElement(declared, _code);
      }
    });
  }
}
