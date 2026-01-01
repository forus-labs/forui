import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'usages/usages.dart';
import 'examples/examples.dart';
import 'snippet.dart';

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

final docsSnippets = p.join(Directory.current.parent.path, 'docs_snippets', 'lib');
final _examples = p.join(docsSnippets, 'examples');

/// Information about a Dart package.
class Package {
  /// The name.
  final String name;

  /// The version.
  final String version;

  /// The library element.
  final LibraryElement library;

  Package({required this.name, required this.version, required this.library});
}

Future<void> main() async {
  const paths = ['forui', 'forui_assets', 'forui_hooks'];
  final provider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);
  final collection = AnalysisContextCollection(
    includedPaths: [for (final path in paths) p.join(Directory.current.parent.path, path, 'lib'), docsSnippets],
    resourceProvider: provider,
  );
  final session = collection.contextFor(docsSnippets).currentSession;

  final packages = <Package>[];
  for (final path in paths) {
    final pubspec = loadYaml(File(p.join(Directory.current.parent.path, path, 'pubspec.yaml')).readAsStringSync());
    final {'name': String name, 'version': String version} = (pubspec as Map);
    packages.add(
      Package(
        name: name,
        version: version,
        library: (await session.getLibraryByUri('package:$name/$name.dart') as LibraryElementResult).element,
      ),
    );
  }

  // Process examples.
  for (final snippet in (await Examples.transform(session, provider, packages, [_examples])).values) {
    final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
    for (final route in snippet.routes) {
      var normalized = route;
      if (normalized.startsWith('/')) {
        normalized = normalized.substring(1);
      }
      if (normalized.endsWith('/')) {
        normalized = normalized.substring(0, normalized.length - 1);
      }

      final file = File(p.join(output, 'examples', '$normalized.json'));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(json);
    }
  }

  // Process usages
  final usages = await Usages.transform(session, provider, packages, p.join(docsSnippets, 'usages'));
  for (final MapEntry(key: fileName, value: fileSnippets) in usages.entries) {
    for (final MapEntry(key: varName, value: snippet) in fileSnippets.entries) {
      final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
      final file = File(p.join(output, 'usages', fileName, '$varName.json'));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(json);
    }
  }
}
