import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

import 'transformations.dart';

class Widgets extends RecursiveAstVisitor<void> {
  static String generate(
    ResolvedUnitResult result,
    ClassDeclaration declaration,
    Map<String, String> substitutions, {
    required bool full,
  }) {
    switch (declaration.extendsClause?.superclass.name.lexeme) {
      case 'Example' || 'StatelessWidget' when full:
        final visitor = _StatelessWidgetClassVisitor(result.content, substitutions)..visitClassDeclaration(declaration);
        return visitor.transformations.apply();

      case 'Example' || 'StatelessWidget':
        final visitor = _StatelessWidgetMethodVisitor(result.content, substitutions)
          ..visitClassDeclaration(declaration);
        return visitor.transformations.apply();

      case 'StatefulExample' || 'StatefulWidget':
        // Assumes that the stateful widget and state are in the same compilation unit, e.g. file.
        final state = result.unit.declarations.whereType<ClassDeclaration>().firstWhere((d) {
          const states = {'State', 'StatefulExampleState'};
          if (d.extendsClause?.superclass case final supertype? when states.contains(supertype.name.lexeme)) {
            final typeArgument = supertype.typeArguments?.arguments.firstOrNull;
            return typeArgument is NamedType && typeArgument.name.lexeme == declaration.name.lexeme;
          }

          return false;
        });

        final widgetVisitor = _StatefulWidgetVisitor(result.content, substitutions)..visitClassDeclaration(declaration);
        final stateVisitor = _StateVisitor(result.content, substitutions)..visitClassDeclaration(state);

        return '${widgetVisitor.transformations.apply()}\n\n${stateVisitor.transformations.apply()}';

      default:
        throw UnimplementedError('Unsupported widget type: ${declaration.name.lexeme}');
    }
  }

  final Map<String, String> substitutions;
  final Transformations transformations;

  Widgets._(String code, this.substitutions) : transformations = Transformations(code);

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    /// Replaces properties where both parts are compile-time identifiers, e.g. `widget.property`.
    if (node.prefix.name == 'widget') {
      if (substitutions[node.identifier.name] case final replacement?) {
        transformations.replace(node, replacement);
      }
    }
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    // Replaces properties where the target is an expression.
    if (node.target case SimpleIdentifier(name: 'widget') || ThisExpression()) {
      if (substitutions[node.propertyName.name] case final replacement?) {
        transformations.replace(node, replacement);
      }
    }
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    // Replaces `property` without a target.
    if (node.element case FieldElement() || PropertyAccessorElement()) {
      if (substitutions[node.name] case final replacement?) {
        transformations.replace(node, replacement);
      }
    }
  }
}

/// A visitor for stateless widgets that transforms the entire class.
class _StatelessWidgetClassVisitor extends Widgets {
  _StatelessWidgetClassVisitor(super.code, super.substitutions) : super._();

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Replace `extends Example` with `extends StatelessWidget`.
    if (node.extendsClause!.superclass.name case final superclass when superclass.lexeme == 'Example') {
      transformations.replace(superclass, 'StatelessWidget');
    }

    transformations
      ..only(node)
      ..removeAll(node.metadata);

    // Replace `class SomePage` with `class SomeExample`.
    if (node.name case final name when name.lexeme.endsWith('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }

    super.visitClassDeclaration(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) => transformations.remove(node);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) => transformations.remove(node);

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    // Replace `Widget example(BuildContext context)` with `Widget build(BuildContext context)`.
    // We assume the class will never have both a build and example method. That's just silly.
    if (node.name.lexeme == 'example') {
      transformations.replace(node.name, 'build');
    }
    super.visitMethodDeclaration(node);
  }
}

// A visitor for stateless widgets that transforms only the build/example method.
class _StatelessWidgetMethodVisitor extends Widgets {
  _StatelessWidgetMethodVisitor(super.code, super.substitutions) : super._();

  // We don't bother checking whether the class extends Example. We assume the class will never have both a build and
  // example method. That's just silly.
  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    switch (node.name.lexeme) {
      case 'build':
        super.visitMethodDeclaration(node);
        transformations.only(node);
      case 'example':
        super.visitMethodDeclaration(node);
        transformations
          ..only(node)
          ..replace(node.name, 'build');
    }
  }
}

/// A visitor for stateful widgets that transforms the entire class.
class _StatefulWidgetVisitor extends Widgets {
  _StatefulWidgetVisitor(super.code, super.substitutions) : super._();

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Replace `extends StatefulExample` with `extends StatefulWidget`.
    if (node.extendsClause!.superclass.name case final superclass when superclass.lexeme == 'StatefulExample') {
      transformations.replace(superclass, 'StatefulWidget');
    }

    transformations
      ..only(node)
      ..removeAll(node.metadata);

    // Replace `class SomePage` with `class SomeExample`.
    if (node.name case final name when name.lexeme.endsWith('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }

    super.visitClassDeclaration(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) => transformations.remove(node);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) => transformations.remove(node);

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    // Replace return type, `_XPageState` with `_XExampleState`.
    if (node.name.lexeme == 'createState') {
      if (node.returnType case final returnType? when returnType.toSource().contains('Page')) {
        transformations.replace(returnType, returnType.toSource().replaceAll('Page', 'Example'));
      }
    }
    super.visitMethodDeclaration(node);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    // Rename constructor invocation, `_XPageState()` with `_XExampleState()`.
    if (node.constructorName.type.name case final name when name.lexeme.contains('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }
    super.visitInstanceCreationExpression(node);
  }
}

// A visitor for the State class of stateful widgets.
class _StateVisitor extends Widgets {
  _StateVisitor(super.code, super.substitutions) : super._();

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Replace `extends StatefulExampleState` with `extends State`.
    final superclass = node.extendsClause!.superclass;
    if (node.extendsClause!.superclass.name case final superclass when superclass.lexeme == 'StatefulExampleState') {
      transformations.replace(superclass, 'State');
    }

    // Replace type argument `SomePage` with `SomeExample`.
    if (superclass.typeArguments?.arguments.first case final argument? when argument.toSource().contains('Page')) {
      transformations.replace(argument, argument.toSource().replaceAll('Page', 'Example'));
    }

    transformations
      ..only(node)
      ..removeAll(node.metadata);

    if (node.name case final name when name.lexeme.contains('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }

    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    // Replace `Widget example(BuildContext context)` with `Widget build(BuildContext context)`.
    // We assume the class will never have both a build and example method. That's just silly.
    if (node.name.lexeme == 'example') {
      transformations.replace(node.name, 'build');
    }
    super.visitMethodDeclaration(node);
  }
}
