import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

import 'extraction/samples.dart';
import 'snippet.dart';

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

final samples = p.join(Directory.current.parent.path, 'samples', 'lib');
final _foundation = p.join(samples, 'foundation');
final _widgets = p.join(samples, 'widgets');

final _forui = p.join(Directory.current.parent.path, 'forui', 'lib');
final _foruiAssets = p.join(Directory.current.parent.path, 'forui_assets', 'lib');
final _foruiHooks = p.join(Directory.current.parent.path, 'forui_hooks', 'lib');

Future<void> main() async {
  final provider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);
  final collection = AnalysisContextCollection(
    includedPaths: [_forui, _foruiAssets, _foruiHooks, samples],
    resourceProvider: provider,
  );

  // Extract & annotate sample snippets.
  for (final snippet in (await Samples.extract(collection, [_foundation, _widgets], provider)).values) {
    final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
    for (final route in snippet.routes) {
      var normalized = route;
      if (normalized.startsWith('/')) {
        normalized = normalized.substring(1);
      }
      if (normalized.endsWith('/')) {
        normalized = normalized.substring(0, normalized.length - 1);
      }

      final file = File(p.join(output, '$normalized.json'));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(json);
    }
  }
}
