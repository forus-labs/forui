import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

import 'generate_snippets.dart';
import 'generate_styles.dart';
import 'generate_themes.dart';

final library = p.join(Directory.current.parent.path, 'forui', 'lib');
final _snippet = p.join(Directory.current.parent.path, 'forui', 'bin', 'commands', 'snippet', 'snippet.dart');
final _style = p.join(Directory.current.parent.path, 'forui', 'bin', 'commands', 'style', 'style.dart');
final _theme = p.join(Directory.current.parent.path, 'forui', 'bin', 'commands', 'theme', 'theme.dart');

final emitter = DartEmitter();
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

const header = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// 
// **************************************************************************
// forui
// **************************************************************************
//
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use

''';

Future<void> main() async {
  final collection = AnalysisContextCollection(
    includedPaths: [library],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  File(_snippet).writeAsStringSync(generateSnippets());

  final styles = mapStyles(await traverseStyles(collection));
  File(_style).writeAsStringSync(generateStyles(styles));

  final themes = mapThemes(await traverseThemes(collection));
  File(_theme).writeAsStringSync(generateThemes(themes));

  await traverseThemes(collection);
}
