import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import 'highlight.dart';
import 'main.dart';
import 'transformations.dart';
import 'widget_visitors.dart';

Future<Map<String, Sample>> transformSamples(AnalysisContextCollection collection, String samplesPath) async {
  final routesVisitor = RoutesVisitor();
  final main = p.join(samplesPath, 'main.dart');
  if (await collection.contextFor(main).currentSession.getResolvedUnit(main) case final ResolvedUnitResult result) {
    result.unit.visitChildren(routesVisitor);
  }

  final samples = routesVisitor.samples;

  for (final file in Directory(samplesPath).listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart')) {
      continue;
    }

    final session = collection.contextFor(file.path).currentSession;
    if (await session.getResolvedUnit(file.path) case final ResolvedUnitResult result) {
      final sampleVisitor = SampleVisitor(samples, result, session);
      result.unit.visitChildren(sampleVisitor);
    }
  }

  return samples;
}

class RoutesVisitor extends RecursiveAstVisitor<void> {
  /// The extracted routes as a map of page -> list of routes.
  final Map<String, Sample> samples = {};

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.metadata.any((a) => a.name.name == 'AutoRouterConfig')) {
      super.visitClassDeclaration(node);
    }
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.type.name.lexeme != 'AutoRoute') {
      super.visitInstanceCreationExpression(node);
      return;
    }

    String? path;
    String? page;
    for (final NamedExpression(:name, :expression) in node.argumentList.arguments.whereType<NamedExpression>()) {
      switch ((name.label.name, expression)) {
        case ('path', final StringLiteral expression):
          path = expression.stringValue;

        case ('page', final expression):
          // page: AccordionRoute.page -> extract 'AccordionPage'
          page = expression.toSource().replaceAll('Route.page', 'Page');
      }

      if (path != null && page != null) {
        (samples[page] ??= Sample()).routes.add(path);
      }
    }
  }
}

// Assumptions:
// * inline is always a class declaration.
// * both the main and inlined widgets are in the same file.
class SampleVisitor extends RecursiveAstVisitor<Future<void>> {
  final Map<String, Sample> _samples;
  final ResolvedUnitResult _result;
  final AnalysisSession _session;

  SampleVisitor(this._samples, this._result, this._session);

  @override
  Future<void> visitClassDeclaration(ClassDeclaration node) async {
    if (node.metadata.none((a) => a.name.name == 'RoutePage')) {
      return;
    }

    List<DartType> inclusions = const [];
    DartType? inline;
    bool full = false;
    if (node.metadata.firstWhereOrNull((a) => a.name.name == 'Options') case final annotation?) {
      final value = annotation.elementAnnotation!.computeConstantValue()!;
      inclusions = [for (final type in value.getField('include')?.toListValue() ?? <DartObject>[]) ?type.toTypeValue()];
      inline = value.getField('inline')?.toTypeValue();
      full = value.getField('full')?.toBoolValue() ?? false;
    }

    final sample = _samples[node.name.lexeme] ??= Sample();
    if (inline == null) {
      sample.source = await _include(
        _result,
        inclusions,
        node,
        visitWidget(_result, node, const {}, full: full),
      );
    } else {
      final InlineCallSiteVisitor(:inlines) = InlineCallSiteVisitor(inline)..visitClassDeclaration(node);
      final (result, type as ClassDeclaration) = (await _session.declaration(inline.element!))!;
      sample.source = await _include(
        result,
        inclusions,
        node,
        visitWidget(result, type, inlines, full: full),
      );
    }

    transformHighlights(sample);
  }

  Future<String> _include(
    ResolvedUnitResult result,
    List<DartType> inclusions,
    ClassDeclaration declaration,
    String widget,
  ) async {
    final parts = SplayTreeMap<int, String>()
      ..[0] = result.unit.directives.whereType<ImportDirective>().map((d) => d.toSource()).join('\n')
      ..[declaration.offset] = widget;

    for (final type in inclusions) {
      final (result, declaration) = (await _session.declaration(type.element!))!;
      parts[declaration.offset] = declaration.toSource();
    }

    return formatter.format(parts.values.join('\n\n'));
  }
}

class InlineCallSiteVisitor extends RecursiveAstVisitor<void> {
  final Map<String, String> inlines = {};
  final DartType _type;

  InlineCallSiteVisitor(this._type);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (_type.element != node.staticType?.element) {
      super.visitInstanceCreationExpression(node);
      return;
    }

    // We don't support M-1 inlines for now.
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
