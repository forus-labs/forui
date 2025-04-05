import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import 'style/emit.dart';
import 'style/map.dart';
import 'style/traversal.dart';
import 'typography/emit.dart';

final library = path.join(Directory.current.parent.path, 'forui', 'lib');
final registry = path.join(Directory.current.parent.path, 'forui', 'bin', 'style_registry.dart');
final typography = path.join(Directory.current.parent.path, 'forui', 'bin', 'typography.dart');


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

  final fragments = map(await traverse(collection));
  File(registry).writeAsStringSync(emitStyles(fragments));

  final constructor = mapTypography(await findTypography(collection));
  File(typography).writeAsStringSync(emitTypography(constructor));
}
