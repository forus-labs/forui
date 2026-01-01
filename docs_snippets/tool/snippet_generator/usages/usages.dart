import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../dart_doc_linker.dart';
import '../main.dart';
import '../snippet.dart';
import '../tooltip/generator.dart';

class Usages extends RecursiveAstVisitor<void> {
  /// Transforms all usage files in [path] and returns a map of { fileName: { varName: Snippet } }.
  static Future<Map<String, Map<String, Snippet>>> transform(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String path,
  ) async {
    final snippets = <String, Map<String, Snippet>>{};
    final dir = Directory(path);

    for (final file in dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      if (await session.getResolvedUnit(file.path) case final ResolvedUnitResult result) {
        final imports = result.content
            .split('\n')
            .takeWhile((l) => l.startsWith('import ') || l.trim().isEmpty)
            .toList()
            .join('\n');

        final (links, tooltips) = await TooltipGenerator.generate(
          session,
          overlay,
          packages,
          result.content,
          imports.length,
        );

        final visitor = Usages._(
          result,
          snippets[p.basenameWithoutExtension(file.path)] = <String, Snippet>{},
          links,
          tooltips,
          imports.length,
        );
        result.unit.visitChildren(visitor);
        await Future.wait(visitor.tasks);
      }
    }

    return snippets;
  }

  final List<Future<void>> tasks = [];
  final ResolvedUnitResult _result;
  final Map<String, Snippet> _snippets;
  final List<DartDocLink> _links;
  final List<Tooltip> _tooltips;
  final int _importsLength;

  Usages._(this._result, this._snippets, this._links, this._tooltips, this._importsLength);

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    for (final variable in node.variables.variables) {
      if (variable.initializer != null) {
        tasks.add(_schedule(variable));
      }
    }
  }

  Future<void> _schedule(VariableDeclaration variable) async {
    final initializer = variable.initializer!;
    final start = initializer.offset - _importsLength;
    final end = initializer.end - _importsLength;

    _snippets[variable.name.lexeme] = Snippet()
      ..code = _result.content.substring(initializer.offset, initializer.end)
      ..links.addAll([
        for (final link in _links)
          if (link.offset >= start && link.offset + link.length <= end)
            link..offset = link.offset - start,
      ])
      ..tooltips.addAll([
        for (final tooltip in _tooltips)
          if (tooltip.offset >= start && tooltip.offset + tooltip.length <= end)
            tooltip..offset = tooltip.offset - start,
      ]);
  }
}
