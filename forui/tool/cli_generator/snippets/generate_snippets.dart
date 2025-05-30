import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;
import 'package:sugar/sugar.dart';

import '../main.dart';
import 'generate_icon_mapping.dart';
import 'generate_material_mapping.dart';

String generateSnippets(Map<String, String> mapped) {
  final sources = [
    for (final MapEntry(:key, value: source) in [...mapped.entries]) "'$key': r'''$source'''",
  ];

  final library = LibraryBuilder()
    ..comments.addAll([header])
    ..body.addAll([
      (FieldBuilder()
            ..docs.addAll(['/// All snippets. Generated by tool/cli_generator.'])
            ..name = 'snippets'
            ..modifier = FieldModifier.constant
            ..assignment = Code('{\n  ${sources.join(',\n  ')}\n}'))
          .build(),
    ]);

  return formatter.format(library.build().accept(emitter).toString());
}

/// Traverses & maps the library and finds all targets to convert into snippets.
Future<Map<String, String>> mapSnippets(AnalysisContextCollection collection) async {
  final directory = p.join(Directory.current.parent.path, 'forui', 'tool', 'cli_generator', 'snippets', 'literals');
  final staticSnippets = {
    for (final file in Directory(directory).listSync(recursive: true).whereType<File>())
      p.basenameWithoutExtension(file.path).toSnakeCase(): file.readAsStringSync(),
  };

  final files = Directory(
    library,
  ).listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart')).map((f) => f.path).toList();

  final approximateMaterialThemeFinder = ToApproximateMaterialThemeFinder();
  for (final file in files) {
    if (await collection.contextFor(file).currentSession.getResolvedUnit(file) case final ResolvedUnitResult result) {
      result.unit.accept(approximateMaterialThemeFinder);
    }
  }

  final assetFiles = Directory(
    assetsLibrary,
  ).listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart')).map((f) => f.path).toList();

  final iconFinder = IconsFinder();
  for (final file in assetFiles) {
    if (await collection.contextFor(file).currentSession.getResolvedUnit(file) case final ResolvedUnitResult result) {
      result.unit.accept(iconFinder);
    }
  }

  return {
    ...staticSnippets,
    materialThemeMapping: mapMaterialThemeMapping(approximateMaterialThemeFinder.snippet!),
    iconMapping: mapIconMapping(iconFinder.icons),
  };
}
