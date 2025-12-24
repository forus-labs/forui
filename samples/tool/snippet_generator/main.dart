import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

import 'doc_linker.dart';
import 'sample_visitor.dart';

final samples = p.join(Directory.current.parent.path, 'samples', 'lib');
final _forui = p.join(Directory.current.parent.path, 'forui', 'lib');

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

class Snippet {
  /// The routes which this sample is used in.
  final List<String> routes = [];

  /// The line ranges to highlight, inclusive.
  final List<(int start, int end)> highlights = [];

  /// The dartdoc links for forui types.
  final List<DartDocLink> links = [];

  /// The modified source code.
  String source = '';

  Iterable<String> get linkedSources sync* {
    for (final link in links) {
      final text = source.substring(link.offset, link.offset + link.length);
      yield '[$text](${link.url})';
    }
  }

  Map<String, dynamic> toJson() => {
    'highlights': [
      for (final h in highlights) {'start': h.$1, 'end': h.$2},
    ],
    'links': [for (final l in links) l.toJson()],
    'source': source,
  };
}

Future<void> main() async {
  final provider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);
  final collection = AnalysisContextCollection(includedPaths: [_forui, samples], resourceProvider: provider);

  final snippets = await transformSamples(collection, samples, provider);
  final output = p.join(Directory.current.path, 'output');

  for (final snippet in snippets.values) {
    final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
    for (final route in snippet.routes) {
      var normalized = route;
      if (normalized.startsWith('/')) {
        normalized = normalized.substring(1);
      }
      if (normalized.endsWith('/')) {
        normalized = normalized.substring(0, normalized.length - 1);
      }

      // TODO: Finalize output location.
      final file = File(p.join(output, '$normalized.json'));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(json);
    }
  }
}
