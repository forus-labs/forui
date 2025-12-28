import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../annotation/doc_linker.dart';
import '../main.dart';
import '../options.dart';
import '../snippet.dart';
import 'routes.dart';
import 'widgets.dart';

class Samples extends RecursiveAstVisitor<void> {
  static Future<Map<String, Snippet>> extract(
    AnalysisContextCollection collection,
    List<String> paths,
    OverlayResourceProvider overlay,
  ) async {
    final main = p.join(samples, 'main.dart');
    var snippets = <String, Snippet>{};
    if (await collection.contextFor(main).currentSession.getResolvedUnit(main) case final ResolvedUnitResult result) {
      snippets = RoutesVisitor.extract(result.unit);
    }

    for (final file
        in paths
            .map(Directory.new)
            .expand((d) => d.listSync(recursive: true))
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))) {
      final session = collection.contextFor(file.path).currentSession;
      if (await session.getResolvedUnit(file.path) case final ResolvedUnitResult result) {
        final visitor = Samples._(snippets, result, session, overlay);
        result.unit.visitChildren(visitor);

        await Future.wait(visitor.tasks);
      }
    }

    return snippets;
  }

  final List<Future<void>> tasks = [];
  final Map<String, Snippet> _snippets;
  final ResolvedUnitResult _result;
  final AnalysisSession _session;
  final OverlayResourceProvider _overlay;

  Samples._(this._snippets, this._result, this._session, this._overlay);

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
      final visitor = _InlineCallSiteVisitor(inline)..visitClassDeclaration(node);
      final (result, declaration as ClassDeclaration) = (await _session.declaration(inline.element!))!;
      final widget = WidgetVisitor.extract(result, declaration, visitor.inlines, full: options.full);
      snippet.code = await _merge(_result, options.include, node, widget);
    } else {
      final widget = WidgetVisitor.extract(_result, node, const {}, full: options.full);
      snippet.code = await _merge(_result, options.include, node, widget);
    }

    snippet.highlight();
    await DartDocLinker.link(snippet, _session, _overlay);
    snippet.removeImports();
  }

  Future<String> _merge(
    ResolvedUnitResult result,
    List<DartType> include,
    ClassDeclaration declaration,
    String widget,
  ) async {
    final fragments = SplayTreeMap<int, String>()
      ..[0] = result.unit.directives.whereType<ImportDirective>().map((d) => d.toSource()).join('\n')
      ..[declaration.offset] = widget;

    for (final type in include) {
      final (result, declaration) = (await _session.declaration(type.element!))!;
      fragments[declaration.offset] = declaration.toSource();
    }

    return formatter.format(fragments.values.join('\n\n'));
  }
}

class _InlineCallSiteVisitor extends RecursiveAstVisitor<void> {
  final Map<String, String> inlines = {};
  final DartType _type;

  _InlineCallSiteVisitor(this._type);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (_type.element != node.staticType?.element) {
      super.visitInstanceCreationExpression(node);
      return;
    }

    // We don't support many to one inlines, i.e. many different constructor invocations, each with different arguments.
    final constructor = node.constructorName.element!;
    for (final (i, argument) in node.argumentList.arguments.indexed) {
      if (argument case NamedExpression(:final name, :final expression)) {
        inlines[name.label.name] = expression.toSource();
      } else {
        inlines[constructor.formalParameters[i].name!] = argument.toSource();
      }
    }
  }
}

extension Sessions on AnalysisSession {
  Future<(ResolvedUnitResult, Declaration)?> declaration(Element element) async {
    final path = switch (element) {
      InterfaceElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      TopLevelFunctionElement(:final firstFragment) => firstFragment.libraryFragment.source.fullName,
      _ => throw ArgumentError('Unsupported element type: ${element.runtimeType}'),
    };

    if (await getResolvedUnit(path) case final ResolvedUnitResult result) {
      final declaration = result.unit.declarations.firstWhereOrNull((d) => d.declaredFragment?.element == element);
      return declaration == null ? null : (result, declaration);
    }

    return null;
  }
}
