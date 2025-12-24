import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

import 'transformations.dart';

String visitWidget(
  ResolvedUnitResult result,
  ClassDeclaration declaration,
  Map<String, String> inlines, {
  required bool full,
}) {
  switch (declaration.extendsClause?.superclass.name.lexeme) {
    case 'Sample' || 'StatelessWidget' when full:
      final visitor = StatelessWidgetClassVisitor(result.content, inlines)..visitClassDeclaration(declaration);
      return visitor.transformations.transform();

    case 'Sample' || 'StatelessWidget':
      final visitor = StatelessWidgetMethodVisitor(result.content, inlines)..visitClassDeclaration(declaration);
      return visitor.transformations.transform();

    case 'StatefulSample' || 'StatefulWidget':
      final name = declaration.name.lexeme;
      final state = result.unit.declarations.whereType<ClassDeclaration>().firstWhere((d) {
        if (d.extendsClause?.superclass case final supertype?
            when const {'State', 'StatefulSampleState'}.contains(supertype.name.lexeme)) {
          final typeArgument = supertype.typeArguments?.arguments.firstOrNull;
          return typeArgument is NamedType && typeArgument.name.lexeme == name;
        }

        return false;
      });

      final widgetVisitor = StatefulWidgetVisitor(result.content, inlines)..visitClassDeclaration(declaration);
      final stateVisitor = StateVisitor(result.content)..visitClassDeclaration(state);

      return '${widgetVisitor.transformations.transform()}\n\n${stateVisitor.transformations.transform()}';

    default:
      throw UnimplementedError('Unsupported widget type: ${declaration.name.lexeme}');
  }
}

class StatelessWidgetClassVisitor extends InliningVisitor {
  late bool _sample;

  StatelessWidgetClassVisitor(super.source, super.inlines);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause!.superclass;
    _sample = superclass.name.lexeme == 'Sample';

    transformations
      ..only(node)
      ..deleteAll(node.metadata);

    if (node.name case final name when name.lexeme.endsWith('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }

    if (_sample) {
      transformations.replace(superclass.name, 'StatelessWidget');
    }

    super.visitClassDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) => transformations.delete(node);

  @override
  void visitFieldDeclaration(FieldDeclaration node) => transformations.delete(node);

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.lexeme == 'sample' && _sample) {
      transformations.replace(node.name, 'build');
    }
    super.visitMethodDeclaration(node);
  }
}

class StatelessWidgetMethodVisitor extends InliningVisitor {
  late bool _sample;

  StatelessWidgetMethodVisitor(super.source, super.inlines);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause!.superclass;
    _sample = superclass.name.lexeme == 'Sample';
    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final name = node.name;
    switch (name.lexeme) {
      case 'sample' when _sample:
        transformations
          ..only(node)
          ..deleteAll(node.sortedCommentAndAnnotations)
          ..replace(name, 'build');
        super.visitMethodDeclaration(node);
      case 'build' when !_sample:
        transformations
          ..only(node)
          ..deleteAll(node.sortedCommentAndAnnotations);
        super.visitMethodDeclaration(node);
    }
  }
}

class StatefulWidgetVisitor extends InliningVisitor {
  late bool _sample;

  StatefulWidgetVisitor(super.source, super.inlines);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause!.superclass;
    _sample = superclass.name.lexeme == 'StatefulSample';

    transformations
      ..only(node)
      ..deleteAll(node.metadata);

    if (node.name case final name when name.lexeme.endsWith('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }

    if (_sample) {
      transformations.replace(superclass.name, 'StatefulWidget');
    }

    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.lexeme == 'createState') {
      // Rename return type: _XPageState -> _XExampleState
      if (node.returnType case final returnType? when returnType.toSource().contains('Page')) {
        transformations.replace(returnType, returnType.toSource().replaceAll('Page', 'Example'));
      }
    }
    super.visitMethodDeclaration(node);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    // Rename in createState body: _XPageState() -> _XExampleState()
    final typeName = node.constructorName.type.name.lexeme;
    if (typeName.contains('Page')) {
      transformations.replace(node.constructorName.type.name, typeName.replaceAll('Page', 'Example'));
    }
    super.visitInstanceCreationExpression(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) => transformations.delete(node);

  @override
  void visitFieldDeclaration(FieldDeclaration node) => transformations.delete(node);
}

class StateVisitor extends RecursiveAstVisitor {
  final Transformations transformations;
  late bool _sample;

  StateVisitor(String source) : transformations = Transformations(source);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause!.superclass;
    _sample = superclass.name.lexeme == 'StatefulSampleState';

    transformations
      ..only(node)
      ..deleteAll(node.metadata);

    if (node.name case final name when name.lexeme.contains('Page')) {
      transformations.replace(name, name.lexeme.replaceAll('Page', 'Example'));
    }

    if (_sample) {
      transformations.replace(superclass.name, 'State');
    }

    if (superclass.typeArguments?.arguments.first case final arg? when arg.toSource().contains('Page')) {
      transformations.replace(arg, arg.toSource().replaceAll('Page', 'Example'));
    }

    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.name.lexeme == 'sample' && _sample) {
      transformations.replace(node.name, 'build');
    }
    super.visitMethodDeclaration(node);
  }
}

class InliningVisitor extends RecursiveAstVisitor<void> {
  final Map<String, String> inlines;
  final Transformations transformations;

  InliningVisitor(String source, this.inlines) : transformations = Transformations(source);

  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.target case SimpleIdentifier(name: 'widget') || ThisExpression()) {
      if (inlines[node.propertyName.name] case final replacement?) {
        transformations.replace(node, replacement);
      }
    }
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.element is FieldElement || node.element is PropertyAccessorElement) {
      if (inlines[node.name] case final replacement?) {
        transformations.replace(node, replacement);
      }
    }
  }
}
