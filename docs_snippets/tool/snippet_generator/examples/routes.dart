import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class RoutesVisitor extends RecursiveAstVisitor<void> {
  /// Extracts page to route from a `AutoRouterConfig` in the [unit].
  static Map<String, String> generate(CompilationUnit unit) {
    final visitor = RoutesVisitor();
    unit.visitChildren(visitor);

    return visitor._snippets;
  }

  /// The extracted routes as a `Map<Page Name, Snippet>`.
  final Map<String, String> _snippets = {};

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.metadata.any((a) => a.name.name == 'AutoRouterConfig')) {
      super.visitClassDeclaration(node);
    }
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.type.name.lexeme != 'AutoRoute') {
      super.visitInstanceCreationExpression(node);
      return;
    }

    String? path;
    String? page;
    for (final NamedExpression(:name, :expression) in node.argumentList.arguments.whereType<NamedExpression>()) {
      // Extract path & page from `AutoRoute(path: '/accordion/default', page: AccordionRoute.page)`,
      switch ((name.label.name, expression)) {
        case ('path', StringLiteral(:final stringValue)):
          path = stringValue;

        case ('page', final expression):
          // Transform 'AccordionRoute.page' -> 'AccordionPage'
          page = expression.toSource().replaceAll('Route.page', 'Page');
      }
    }

    if (path != null && page != null) {
      _snippets[page] = path;
    }
  }
}
