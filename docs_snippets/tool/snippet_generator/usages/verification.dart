import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class Verifier extends RecursiveAstVisitor<void> {
  static final _categoryComment = RegExp(r'// \{@category');

  /// Verifies that usage files include all constructor parameters.
  static void verify(ResolvedUnitResult result) {
    final visitor = Verifier();
    result.unit.visitChildren(visitor);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    // Skip if has {@category comment (these are variants, not main constructors)
    final comment = node.firstTokenAfterCommentAndMetadata.precedingComments?.lexeme;
    if (comment != null && _categoryComment.hasMatch(comment)) {
      return;
    }

    final VariableDeclaration(:name, :initializer!) = node.variables.variables.single;
    if (initializer case InstanceCreationExpression(:final constructorName, :final argumentList)) {
      _verify(constructorName, constructorName.element!, argumentList);
    } else if (initializer case MethodInvocation(:final methodName, :final argumentList)) {
      _verify(methodName, methodName.element! as ExecutableElement, argumentList);
    }
  }

  void _verify(AstNode name, ExecutableElement element, ArgumentList arguments) {
    final declaredNamed = {
      for (final p in element.formalParameters)
        if (p.isNamed && p.name != null) p.name!,
    };
    final providedNamed = {
      for (final arg in arguments.arguments)
        if (arg is NamedExpression) arg.name.label.name,
    };

    final declaredPositional = [
      for (final p in element.formalParameters)
        if (p.isPositional && p.name != null) p.name!,
    ];
    final providedPositionalCount = arguments.arguments.where((arg) => arg is! NamedExpression).length;

    final missing = [...declaredNamed.difference(providedNamed), ...declaredPositional.skip(providedPositionalCount)]
      ..remove('key');

    if (missing.isNotEmpty) {
      // ignore: avoid_print
      print('[WARNING] Usage of $name has the following missing parameter(s):');
      for (final parameter in missing) {
        // ignore: avoid_print
        print('          - $parameter');
      }
    }
  }
}
