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

import '../main.dart';
import '../options.dart';
import '../snippet.dart';
import '../tooltip_linker.dart';
import '../argument_elision.dart';
import 'routes.dart';
import 'widgets.dart';

class Examples extends RecursiveAstVisitor<void> {
  static Future<List<(String, Snippet)>> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    List<String> paths,
  ) async {
    final main = p.join(lib, 'main.dart');

    var routes = <String, String>{};
    if (await session.getResolvedUnit(main) case final ResolvedUnitResult result) {
      routes = RoutesVisitor.generate(result.unit);
    }

    final snippets = <(String, Snippet)>[];
    for (final path in paths) {
      final dir = Directory(path);
      for (final file in dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'))) {
        if (await session.getResolvedUnit(file.path) case final ResolvedUnitResult result) {
          final visitor = Examples._(session, overlay, result, routes, snippets, packages);
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
  final Map<String, String> _routes;
  final List<(String, Snippet)> _snippets;
  final List<Package> _packages;

  Examples._(this._session, this._overlay, this._result, this._routes, this._snippets, this._packages);

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
    final route = _routes[node.name.lexeme]!;

    // Assumptions:
    // * inline is always a class declaration.
    // * both the main and inlined widgets are in the same file.
    Snippet snippet;
    if (options.inline case final inline?) {
      final propagation = ConstantPropagation(inline)..visitClassDeclaration(node);
      final (result, declaration as ClassDeclaration) = (await _session.declaration(inline.element!))!;
      final widget = Widgets.generate(result, declaration, propagation.substitutions, full: options.include.isNotEmpty);
      final code = await merge(result, options.include, node, widget);
      snippet = Snippet(formatter.format(await ArgumentElision.elide(code, _session, _overlay)));
    } else {
      final widget = Widgets.generate(_result, node, const {}, full: options.include.isNotEmpty);
      snippet = Snippet(formatter.format(await merge(_result, options.include, node, widget)));
    }

    snippet.highlight();
    final (links, tooltips) = await TooltipLinker.generate(_session, _overlay, _packages, snippet.text);
    snippet
      ..spans.addAll(links)
      ..spans.addAll(tooltips)
      ..unimport();

    _snippets.add((route, snippet));
  }

  /// Merges the [declaration] with the [elements] into a single Dart code string.
  Future<String> merge(ResolvedUnitResult result, List<Element> elements, Declaration declaration, String code) async {
    final fragments = SplayTreeMap<int, String>()
      ..[0] = result.unit.directives.whereType<ImportDirective>().map((d) => d.toSource()).join('\n')
      ..[declaration.offset] = code;

    for (final element in elements) {
      final declaration = (await _session.declaration(element))!.$2;
      fragments[declaration.offset] = declaration.toSource();
    }

    return fragments.values.join('\n\n');
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
