import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import 'main.dart';
import 'examples/transformations.dart';

/// Extracts argument values from constructor invocations for constant propagation.
///
/// Visits constructor calls matching a target type and captures:
/// 1. Call-site argument values (e.g., `image` from `FAvatar(image: myImage)`).
/// 2. Default parameter values for omitted optional named parameters.
///
/// In both cases, we assume that the arguments are constant expressions/expressions that remain valid in the lexical
/// scope where they will be substituted.
///
/// These substitutions are later used to replace field references with their constant values in the
/// extracted code snippet.
class ConstantPropagation extends RecursiveAstVisitor<void> {
  /// Maps parameter names to their values (call-site arguments or defaults).
  final Map<String, String> substitutions = {};

  final DartType _type;

  ConstantPropagation(this._type);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (_type.element != node.staticType?.element) {
      super.visitInstanceCreationExpression(node);
      return;
    }

    // Capture default parameter values.
    for (final parameter in node.constructorName.element!.formalParameters) {
      if (parameter case FormalParameterElement(
        :final name?,
        :final defaultValueCode,
        :final isOptionalNamed,
      ) when isOptionalNamed) {
        substitutions[name] = defaultValueCode ?? 'null';
      }
    }

    // Capture call-site argument values. We do not support many-to-one substitutions, i.e. many different constructor
    // invocations, each with different arguments.
    for (final argument in node.argumentList.arguments) {
      // We only support named arguments.
      if (argument case NamedExpression(:final name, :final expression)) {
        substitutions[name.label.name] = expression.toSource();
      }
    }
  }
}

/// Eliminates arguments that match their default values.
class ArgumentElision extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  /// Elides arguments matching defaults in the given code.
  ///
  /// Applies elision repeatedly until no more changes occur, handling nested constructor invocations where inner
  /// elisions may enable outer ones.
  static Future<String> elide(String code, AnalysisSession session, OverlayResourceProvider overlay) async {
    var current = code;

    while (true) {
      final syntheticPath = p.join(lib, 'elision_${_monotonic++}.dart');
      overlay.setOverlay(syntheticPath, content: current, modificationStamp: DateTime.now().millisecondsSinceEpoch);

      final result = await session.getResolvedUnit(syntheticPath) as ResolvedUnitResult;
      final visitor = ArgumentElision._(result.content);
      result.unit.visitChildren(visitor);

      final next = visitor._transformations.apply();
      if (next == current) {
        return current;
      }

      current = next;
    }
  }

  final Transformations _transformations;

  ArgumentElision._(String code) : _transformations = Transformations(code);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    if (node.constructorName.element case final constructor?) {
      _eliminate(node.argumentList, constructor);
    }
  }

  @override
  void visitDotShorthandConstructorInvocation(DotShorthandConstructorInvocation node) {
    super.visitDotShorthandConstructorInvocation(node);
    if (node.element case final constructor?) {
      _eliminate(node.argumentList, constructor);
    }
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);
    if (node.methodName.element case final FunctionTypedElement method) {
      _eliminate(node.argumentList, method);
    }
  }

  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    super.visitDotShorthandInvocation(node);
    if (node.memberName.element case final FunctionTypedElement method) {
      _eliminate(node.argumentList, method);
    }
  }

  void _eliminate(ArgumentList arguments, FunctionTypedElement element) {
    // This normalization isn't technically safe as `const` can affect semantics, However, for code snippets, this is
    // usually acceptable.
    String normalize(String source) => source.startsWith('const ') ? source.substring(6) : source;

    // Capture default parameter values.
    final defaults = <String, String>{};
    for (final parameter in element.formalParameters) {
      if (parameter case FormalParameterElement(
        :final name?,
        :final defaultValueCode,
        :final isOptionalNamed,
      ) when isOptionalNamed) {
        defaults[name] = defaultValueCode ?? 'null';
      }
    }

    // Remove arguments that match their defaults.
    for (final argument in arguments.arguments) {
      if (argument case NamedExpression(:final name, :final expression, :final endToken)) {
        if (normalize(defaults[name.label.name] ?? '') == normalize(expression.toSource())) {
          _transformations.removeWithComma(argument, endToken);
        }
      }
    }
  }
}
