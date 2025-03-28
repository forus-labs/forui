import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as path;

import 'emit.dart';
import 'map.dart';
import 'traversal.dart';

final library = path.join(Directory.current.parent.path, 'forui', 'lib');
final registry = path.join(Directory.current.parent.path, 'forui', 'bin', 'registry.dart');

Future<void> main() async {
  final collection = AnalysisContextCollection(
    includedPaths: [library],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  final constructors = await traverse(collection);
  final fragments = map(constructors);
  final code = emit(fragments);

  File(registry).writeAsStringSync(code);
}
