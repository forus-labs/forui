import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../metadata/doc_linker.dart';
import '../main.dart';
import '../options.dart';
import '../snippet.dart';
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
          final visitor = Samples._(
            session,
            overlay,
            result,
            snippets,
            packages,
          );
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
      snippet.code = await _merge(_result, options.include, node, widget);
    } else {
      final widget = Widgets.extract(_result, node, const {}, full: options.include.isNotEmpty);
      snippet.code = await _merge(_result, options.include, node, widget);
    }

    snippet.highlight();
    snippet.links.addAll(await DartDocLinker.link( _session, _overlay, _packages, snippet.code, snippet.importsLength));
    snippet.removeImports();
  }

  Future<String> _merge(
    ResolvedUnitResult result,
    List<Element> include,
    ClassDeclaration declaration,
    String widget,
  ) async {
    final fragments = SplayTreeMap<int, String>()
      ..[0] = result.unit.directives.whereType<ImportDirective>().map((d) => d.toSource()).join('\n')
      ..[declaration.offset] = widget;

    for (final element in include) {
      final (result, declaration) = (await _session.declaration(element))!;
      fragments[declaration.offset] = declaration.toSource();
    }

    return formatter.format(await ArgumentElision.elide(fragments.values.join('\n\n'), _session, _overlay));
  }
}

extension Sessions on AnalysisSession {
  Future<(ResolvedUnitResult, Declaration)?> declaration(Element element) async {
    final path = switch (element) {
      InterfaceElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      TopLevelFunctionElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      TopLevelVariableElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      _ => throw ArgumentError('Unsupported element type: ${element.runtimeType}'),
    };

    if (await getResolvedUnit(path) case final ResolvedUnitResult result) {
      for (final declaration in result.unit.declarations) {
        // TopLevelVariableDeclaration contains a list of variables, check each one.
        if (declaration case TopLevelVariableDeclaration(variables: VariableDeclarationList(:final variables))) {
          for (final variable in variables) {
            if (variable.declaredFragment?.element == element) {
              return (result, declaration);
            }
          }
        } else if (declaration.declaredFragment?.element == element) {
          return (result, declaration);
        }
      }
    }

    return null;
  }
}
