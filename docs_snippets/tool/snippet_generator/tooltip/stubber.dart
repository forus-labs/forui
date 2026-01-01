import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import 'generator.dart';
import 'stub_linker.dart';

/// Tooltip code (e.g., `FButton({required this.child})`) is not valid Dart on its own. This class wraps it in a
/// stub declaration, formats it, resolves the AST to extract dartdoc links, then extracts the original declaration
/// with adjusted offsets.
class TooltipStubber extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  static Future<void> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String imports,
    Tooltip tooltip,
  ) async {
    final stubbed = switch (tooltip.target) {
      // Transform `Type name` to `late Type name;`
      .field => 'late ${tooltip.code};',
      // Transform `Type get name` to `Type get name => throw UnimplementedError();` or `Type name(params)` to
      // `Type name(params) => throw UnimplementedError();`
      .getter || .method => '${tooltip.code} => throw UnimplementedError();',
      // Transform `Type.ctr(params)` to `class Type { Type.ctr(params); }`
      TooltipTarget.constructor => 'class ${tooltip.container!.$1} { ${tooltip.code}; }',
      // Transform `Type param` to `void a(Type param) {}`
      TooltipTarget.formalParameter => 'void a(${tooltip.code}) {}',
    };
    final code = formatter.format(imports + stubbed);

    final syntheticPath = p.join(docsSnippets, 'tooltip_stub_${_monotonic++}.dart');
    overlay.setOverlay(syntheticPath, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(syntheticPath)) as ResolvedUnitResult;
    final linker = StubLinker(packages, imports.length);
    result.unit.visitChildren(linker);

    // Find the original declaration position in the formatted stub
    final visitor = TooltipStubber._(tooltip.target);
    result.unit.visitChildren(visitor);
    final (start, end) = visitor.result;

    var transformed = code.substring(start, end);
    final delta = start - imports.length;
    for (final link in linker.links) {
      link.offset -= delta;
    }

    // Constructor code is indented by 2 spaces inside the class wrapper - strip it and adjust link offsets
    if (tooltip.target == .constructor) {
      final lines = transformed.split('\n');
      final unindented = StringBuffer('${lines.first}\n'); // First line is never indented due to our AST extraction.

      final adjustments = [0]; // Sum of adjustments per line.
      final starts = [0]; // Offset of start of lines in original indented code.
      var previous = lines.first.length;

      for (final line in lines.skip(1)) {
        if (line.startsWith('  ')) {
          unindented.writeln(line.substring(2));
          adjustments.add(adjustments.last + 2);
        } else {
          unindented.writeln(line);
          adjustments.add(adjustments.last);
        }

        starts.add(starts.last + previous + 1);
        previous = line.length;
      }

      for (final link in linker.links) {
        // Find which line contains this offset (search from end)
        var line = 0;
        for (var i = starts.length - 1; i >= 0; i--) {
          if (starts[i] <= link.offset) {
            line = i;
            break;
          }
        }
        link.offset -= adjustments[line];
      }

      transformed = unindented.toString();
    }

    tooltip
      ..code = transformed
      ..links.addAll(linker.links.where((l) => l.offset >= 0 && l.offset < transformed.length));
  }

  final TooltipTarget target;
  (int start, int end) result = (0, 0);

  TooltipStubber._(this.target);

  /// Field: extracts "Type name" from "late Type name;".
  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    if (target == .field) {
      // We assume there's only one variable declared.
      final variable = node.variables.variables.single;
      result = (node.variables.type?.offset ?? variable.offset, variable.end);
    }
  }

  /// Constructor: extracts "ClassName(params)" from "class X { ClassName(); }".
  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    if (target == .constructor) {
      result = (node.returnType.offset, node.parameters.end);
    }
  }

  /// Getter/Method/FormalParameter: extracts signature from function declaration.
  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (target == .getter) {
      // "Type get name" - from return type to getter name end
      result = (node.returnType?.offset ?? node.name.offset, node.name.end);
    } else if (target == .method) {
      // "Type name(params)" - from return type to parameters end
      result = (node.returnType?.offset ?? node.name.offset, node.functionExpression.parameters?.end ?? node.name.end);
    } else if (node.functionExpression.parameters case final parameters? when target == .formalParameter) {
      // Extract parameter from "void a(Type param) {}"
      result = (parameters.leftParenthesis.next!.offset, parameters.rightParenthesis.previous!.end);
    }
  }
}
