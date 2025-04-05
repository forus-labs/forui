import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import 'color_scheme/emit.dart';
import 'style/emit.dart';
import 'style/map.dart';
import 'style/traverse.dart';
import 'typography/emit.dart';

final library = path.join(Directory.current.parent.path, 'forui', 'lib');
final _colors = path.join(Directory.current.parent.path, 'forui', 'bin', 'color_registry.dart');
final _styles = path.join(Directory.current.parent.path, 'forui', 'bin', 'style_registry.dart');
final _typography = path.join(Directory.current.parent.path, 'forui', 'bin', 'typography.dart');


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

  final colors = mapColors(await traverseColors(collection));
  File(_colors).writeAsStringSync(emitColors(colors));

  final styles = mapStyles(await traverseStyles(collection));
  File(_styles).writeAsStringSync(emitStyles(styles));

  final typography = mapTypography(await traverseTypography(collection));
  File(_typography).writeAsStringSync(emitTypography(typography));
}
