import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'prefer_widgets_library',
  problemMessage:
      'Prefer importing "flutter/widgets.dart" instead of "flutter/material.dart" and/or "flutter/cupertino.dart".',
  errorSeverity: ErrorSeverity.ERROR,
);

const _material = 'package:flutter/material.dart';

const _cupertino = 'package:flutter/cupertino.dart';

/// A lint rule that checks if a DiagnosticsProperty is created with a type.
class PreferWidgetsLibrary extends DartLintRule {
  /// Creates a new [PreferWidgetsLibrary].
  const PreferWidgetsLibrary() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addImportDirective((import) {
      import.root.accept(_Visitor());
      // switch ((import.uri.stringValue, import.element?.importedLibrary)) {
      //   case ('package:flutter/material.dart', final library?):
      //     final elements = _elements(context, _material, library.exportedLibraries);
      //
      //
      //   case ('package:flutter/cupertino.dart', final library?):
      //   default:
      //     return;
      // }
    });
  }

  Set<LibraryElement> _elements(CustomLintContext context, String key, List<LibraryElement> exported) {
    var libraries = context.sharedState as Set<LibraryElement>?;
    if (libraries == null) {
      libraries = exported
          .where((l) => l.identifier.contains('material') || l.identifier.contains('cupertino'))
          .toSet();

      context.sharedState[key] = libraries;

    }

    return libraries;
  }
}

class _Visitor extends GeneralizingAstVisitor<bool> {
  final Set<LibraryElement> libraries;

  _Visitor(this.libraries);

  @override
  bool? visitAnnotation(Annotation annotation) {
    if (libraries.contains(annotation.elementAnnotation?.library)) {
      return true;
    }
    
    return visitNode(annotation);
  }

  @override
  bool? visitCatchClauseParameter(CatchClauseParameter parameter) {
    if (libraries.contains(parameter.declaredElement?.library)) {
      return true;
    }

    return super.visitCatchClauseParameter(parameter);
  }

  @override
  bool? visitDartPattern(DartPattern pattern) {
    if (libraries.contains(pattern.matchedValueType?.element?.library)) {
      return true;
    }

    return super.visitDartPattern(pattern);
  }

  @override
  bool? visitExpression(Expression expression) {
    if (libraries.contains(expression.staticType?.element?.library)) {
      return true;
    }

    return super.visitExpression(expression);
  }

  @override
  bool? visitFunctionExpressionInvocation(FunctionExpressionInvocation invocation) {
    if (libraries.contains(invocation.staticElement?.declaration.library)) {
      return true;
    }

    return super.visitFunctionExpressionInvocation(invocation);
  }
}
