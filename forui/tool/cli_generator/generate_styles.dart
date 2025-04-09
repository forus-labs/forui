import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;

import 'constructors.dart';
import 'main.dart';

final _type = RegExp('F[^ ]+?Styles?');
final _mapConstructor = RegExp(r'F([^ ]*?Styles?)\.inherit');
final _traverseConstructor = RegExp(r'(F[^ ]*?Styles?)\.inherit');

String generateStyles(Map<String, ConstructorFragment> fragments) {
  final registry =
      LibraryBuilder()
        ..comments.addAll([header])
        ..body.addAll([
          (EnumBuilder()
                ..docs.addAll(['/// All styles in Forui. Generated by tool/cli_generator.'])
                ..name = 'Style'
                ..values.addAll([
                  for (final fragment in fragments.values.toList()..sort((a, b) => a.type.compareTo(b.type)))
                    (EnumValueBuilder()
                          ..name = fragment.type.toLowerCase()
                          ..arguments.addAll([
                            literalString(fragment.type),
                            literalList([
                              if (fragment.root) ...[
                                fragment.type.replaceAll(RegExp('Styles?'), ''),
                                fragment.type.replaceAll(RegExp('Styles?'), '').substring(1),
                              ],
                            ], refer('String')),
                            literalList(fragment.closure, refer('String')),
                            literalString(fragment.source),
                          ]))
                        .build(),
                ])
                ..fields.addAll([
                  (FieldBuilder()
                        ..docs.addAll(['/// The type name.'])
                        ..name = 'type'
                        ..type = refer('String')
                        ..modifier = FieldModifier.final$)
                      .build(),
                  (FieldBuilder()
                        ..docs.addAll(['/// The aliases.'])
                        ..name = 'aliases'
                        ..type = refer('List<String>')
                        ..modifier = FieldModifier.final$)
                      .build(),
                  (FieldBuilder()
                        ..docs.addAll([
                          '/// The functions, including itself, needed to generate a fully compilable style.',
                        ])
                        ..name = 'closure'
                        ..type = refer('List<String>')
                        ..modifier = FieldModifier.final$)
                      .build(),
                  (FieldBuilder()
                        ..docs.addAll(['/// The function to generate.'])
                        ..name = 'source'
                        ..type = refer('String')
                        ..modifier = FieldModifier.final$)
                      .build(),
                ])
                ..constructors.add(
                  (ConstructorBuilder()
                        ..constant = true
                        ..requiredParameters.addAll([
                          Parameter((p) => p..name = 'this.type'),
                          Parameter((p) => p..name = 'this.aliases'),
                          Parameter((p) => p..name = 'this.closure'),
                          Parameter((p) => p..name = 'this.source'),
                        ]))
                      .build(),
                ))
              .build(),
        ]);

  return formatter.format(registry.build().accept(emitter).toString());
}

Map<String, ConstructorFragment> mapStyles(Map<String, ConstructorMatch> matches) =>
    ConstructorFragment.inline(_mapConstructor, matches);

/// Traverses the library and finds all styles that have an inherit constructor.
Future<Map<String, ConstructorMatch>> traverseStyles(AnalysisContextCollection collection) async =>
    ConstructorMatch.traverse(collection, _type, _traverseConstructor, await _roots(collection));

/// Returns the root styles in Forui.
Future<Set<String>> _roots(AnalysisContextCollection collection) async {
  /// The root styles outside of FThemeData.
  const others = {
    'FFormFieldStyle', //
    'FFormFieldErrorStyle', //
    'FFocusedOutlineStyle', //
    'FTappableStyle', //
  };

  final theme = p.join(library, 'src', 'theme', 'theme_data.dart');
  if (await collection.contextFor(theme).currentSession.getResolvedUnit(theme) case final ResolvedUnitResult result) {
    final visitor = _Visitor();
    result.unit.accept(visitor);

    return {...visitor.roots, ...others};
  }

  throw Exception('Failed to parse $theme');
}

class _Visitor extends RecursiveAstVisitor<void> {
  final Set<String> roots = {};

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.name.lexeme;
    if (name == 'FThemeData') {
      super.visitClassDeclaration(declaration);
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration declaration) {
    final type = declaration.fields.type?.type?.getDisplayString() ?? '';
    if (!declaration.isStatic && _type.hasMatch(type)) {
      roots.add(type);
    }
  }
}
