import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../metadata/doc_linker.dart';
import '../main.dart';
import '../options.dart';
import '../snippet.dart';
import '../transformations.dart';
import 'argument_elision.dart';
import 'routes.dart';
import 'widgets.dart';

class Samples extends RecursiveAstVisitor<void> {
  static Future<Map<String, Snippet>> extract(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    List<String> paths,
  ) async {
    final main = p.join(samples, 'main.dart');

    var snippets = <String, Snippet>{};
    if (await session.getResolvedUnit(main) case final ResolvedUnitResult result) {
      snippets = RoutesVisitor.extract(result.unit);
    }

    for (final path in paths) {
      final dir = Directory(path);
      for (final file in dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'))) {
        if (await session.getResolvedUnit(file.path) case final ResolvedUnitResult result) {
          final visitor = Samples._(session, overlay, result, snippets, packages);
          result.unit.visitChildren(visitor);

          await Future.wait(visitor.tasks);
        }
      }
    }

    return snippets;
  }

  final List<Future<void>> tasks = [];
  final AnalysisSession _session;
  final OverlayResourceProvider _overlay;
  final ResolvedUnitResult _result;
  final Map<String, Snippet> _snippets;
  final List<Package> _packages;

  Samples._(this._session, this._overlay, this._result, this._snippets, this._packages);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.metadata.none((a) => a.name.name == 'RoutePage')) {
      return;
    }

    // We cannot make this async as the visitor pattern doesn't support async - visitChildren just calls each visitor
    // method and ignores the returned Future.
    tasks.add(_schedule(node));
  }

  Future<void> _schedule(ClassDeclaration node) async {
    final options = Options.extract(node);
    final snippet = _snippets[node.name.lexeme] ??= Snippet();

    // Assumptions:
    // * inline is always a class declaration.
    // * both the main and inlined widgets are in the same file.
    if (options.inline case final inline?) {
      final propagation = ConstantPropagation(inline)..visitClassDeclaration(node);
      final (result, declaration as ClassDeclaration) = (await _session.declaration(inline.element!))!;
      final widget = Widgets.extract(result, declaration, propagation.substitutions, full: options.include.isNotEmpty);
      final code = await _session.merge(_result, options.include, node, widget);
      snippet.code = formatter.format(await ArgumentElision.elide(code, _session, _overlay));
    } else {
      final widget = Widgets.extract(_result, node, const {}, full: options.include.isNotEmpty);
      snippet.code = formatter.format(await _session.merge(_result, options.include, node, widget));
    }

    snippet
      ..highlight()
      ..links.addAll(await DartDocLinker.link(_session, _overlay, _packages, snippet.code, snippet.importsLength))
      ..removeImports();
  }
}
