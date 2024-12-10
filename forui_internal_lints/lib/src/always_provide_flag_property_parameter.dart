import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'always_provide_flag_property_parameter',
  problemMessage: 'Provide `ifTrue` and/or `ifFalse` parameter',
);

const _flagProperty = TypeChecker.fromName('FlagProperty', packageName: 'flutter');

/// A lint rule that ensures flag property provides `ifTrue` and/or `ifFalse` parameter.
class AlwaysProvideFlagPropertyArgument extends DartLintRule {
  /// Creates a new [AlwaysProvideFlagPropertyArgument].
  const AlwaysProvideFlagPropertyArgument() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.staticType case final type when type == null || !_flagProperty.isExactlyType(type)) {
        return;
      }

      if (node.argumentList.length < 2) {
        return;
      }

      if (node.argumentList.arguments
          .whereType<NamedExpression>()
          .any((expression) => expression.element?.name == 'ifTrue' || expression.element?.name == 'ifFalse')) {
        return;
      }

      reporter.atNode(node, _code);
    });
  }
}
