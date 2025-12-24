import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

import 'sample_visitor.dart';

final _forui = p.join(Directory.current.parent.path, 'forui', 'lib');
final _samples = p.join(Directory.current.parent.path, 'samples', 'lib');

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

class Sample {
  /// The routes which this sample is used in.
  final List<String> routes = [];
  /// The line ranges to highlight, inclusive.
  final List<(int start, int end)> highlights = [];
  /// The modified source code.
  String source = '';
}

Future<void> main() async {
  final provider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);
  final collection = AnalysisContextCollection(includedPaths: [_forui, _samples], resourceProvider: provider);

  final samples = await transformSamples(collection, _samples);
  for (final sample in samples.values) {
    print(sample.source);
    print('highlights: ${sample.highlights}');
  }
}

