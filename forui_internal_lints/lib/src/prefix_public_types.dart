import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:collection/collection.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'prefix_public_types',
  problemMessage: 'Public types should be prefixed with F.',
);

const _checker = TypeChecker.fromName('internal', packageName: 'meta');

/// A lint rule that checks if a public type is prefixed with F.
class PrefixPublicTypesRule extends DartLintRule {
  /// Creates a new [PrefixPublicTypesRule].
  const PrefixPublicTypesRule() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    void check(NodeList<Annotation> annotations, Element? element) {
      if (element?.source?.fullName case final name? when name.contains('test/src')) {
        return;
      }

      if (annotations.map((a) => a.element).whereNotNull().any(_checker.isAssignableFrom)) {
        return;
      }

      if (element == null || element.isPrivate || element.isSynthetic) {
        return;
      }

      if (element.name case final name? when RegExp('^F[A-Z].*').matchAsPrefix(name) != null) {
        return;
      }

      reporter.atElement(element, _code);
    }

    context.registry
      ..addClassDeclaration((node) => check(node.metadata, node.declaredElement))
      ..addEnumDeclaration((node) => check(node.metadata, node.declaredElement))
      ..addMixinDeclaration((node) => check(node.metadata, node.declaredElement))
      ..addExtensionDeclaration((node) => check(node.metadata, node.declaredElement))
      ..addExtensionTypeDeclaration((node) => check(node.metadata, node.declaredElement))
      ..addTypeAlias((node) => check(node.metadata, node.declaredElement));
  }
}
