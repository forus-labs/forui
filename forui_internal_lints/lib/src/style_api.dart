import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'style_api',
  problemMessage: 'Style(s) should conform to the Diagnosticable interface.',
);

const _suffixes = {'Style', 'Styles'};

const _checker = TypeChecker.fromName('Diagnosticable', packageName: 'flutter');

/// A lint rule that checks if a class ending with 'Style' or 'Styles' conforms to the required interface.
class StyleApiRule extends DartLintRule {
  /// Creates a new [StyleApiRule].
  const StyleApiRule() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addClassDeclaration((node) {
      final declared = node.declaredElement;
      if (declared == null) {
        return;
      }

      if (declared.name case final name when _suffixes.every((s) => !name.endsWith(s))) {
        return;
      }

      if (declared.isConstructable && !_checker.isAssignableFrom(declared)) {
        reporter.atElement(
          declared,
          LintCode(
            name: 'style_api',
            problemMessage: '${declared.name}, should be assignable to Diagnosticable.',
          ),
        );
      }

      if (!declared.isConstructable) {
        return;
      }

      final copyWith = declared.getMethod('copyWith');
      if (copyWith == null ||
          copyWith.isStatic ||
          copyWith.returnType != declared.thisType ||
          copyWith.parameters.isEmpty) {
        reporter.atElement(
          declared,
          LintCode(
            name: 'style_api',
            problemMessage: '${declared.name} does not provide a valid copyWith(...) method.',
          ),
        );
      }

      final equality = declared.getMethod('==');
      if (equality == null) {
        reporter.atElement(
          declared,
          LintCode(
            name: 'style_api',
            problemMessage: '${declared.name} does not provide a valid == operator.',
          ),
        );
      }

      final hashCode = declared.getGetter('hashCode');
      if (hashCode == null) {
        reporter.atElement(
          declared,
          LintCode(
            name: 'style_api',
            problemMessage: '${declared.name} does not provide a valid hashCode getter.',
          ),
        );
      }
    });
  }
}
