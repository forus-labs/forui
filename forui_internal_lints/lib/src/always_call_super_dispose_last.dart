import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'always_call_super_dispose_last',
  problemMessage: 'Always call super.dispose() last.',
  errorSeverity: ErrorSeverity.ERROR,
);

/// A lint rule that checks if a DiagnosticsProperty is created with a type.
class AlwaysCallSuperDisposeLast extends DartLintRule {
  /// Creates a new [AlwaysCallSuperDisposeLast].
  const AlwaysCallSuperDisposeLast() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addMethodDeclaration((node) {
      final method = node.declaredElement;
      if (method is! MethodElement) {
        return;
      }

      if (method.isStatic ||
          method.isExternal ||
          method.isAbstract ||
          !method.hasOverride ||
          method.returnType is! VoidType ||
          method.name != 'dispose' ||
          method.parameters.isNotEmpty ||
          !(method.enclosingElement.accept(_Visitor(method.enclosingElement)) ?? false)) {
        return;
      }

      if (node.body case BlockFunctionBody(block: Block(:final statements)) when statements.isNotEmpty) {
        for (final statement in statements.reversed.skip(1)) {
          if (statement case ExpressionStatement(:final MethodInvocation expression)
              when expression.toSource() == 'super.dispose()') {
            reporter.atNode(expression, _code);
          }
        }
      }
    });
  }
}

class _Visitor extends SimpleElementVisitor<bool> {
  final Element? self;

  _Visitor(this.self);

  @override
  bool visitClassElement(ClassElement type) => _visitInterface(type);

  @override
  bool? visitMixinElement(MixinElement type) => _visitInterface(type);

  bool _visitInterface(InterfaceElement interface) {
    bool signature(MethodElement method) =>
        !method.isStatic &&
        method.hasMustCallSuper &&
        method.returnType is VoidType &&
        method.name == 'dispose' &&
        method.parameters.isEmpty;

    if (self != interface && interface.methods.any(signature)) {
      return true;
    }

    for (final supertype in interface.allSupertypes) {
      if (supertype.element.accept(this) ?? false) {
        return true;
      }
    }

    return false;
  }
}
