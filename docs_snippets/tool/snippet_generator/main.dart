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

import 'examples/examples.dart';
import 'snippets/snippets.dart';
import 'usages/usages.dart';

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

/// The output directory for generated snippet JSON files.
///
/// TODO: Change this to your liking @Joe.
final output = p.join(Directory.current.path, 'output');

final lib = p.join(Directory.current.parent.path, 'docs_snippets', 'lib');
final _examples = p.join(lib, 'examples');
final _snippets = p.join(lib, 'snippets');
final _usages = p.join(lib, 'usages');

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
    includedPaths: [for (final path in paths) p.join(Directory.current.parent.path, path, 'lib'), lib],
    resourceProvider: provider,
  );
  final session = collection.contextFor(lib).currentSession;

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
  for (final (route, snippet) in (await Examples.generate(session, provider, packages, [_examples]))) {
    final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
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

  // Process snippets
  final snippets = await Snippets.generate(session, provider, packages, _snippets);
  for (final MapEntry(key: fileName, value: snippet) in snippets.entries) {
    final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
    final file = File(p.join(output, 'snippets', '$fileName.json'));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(json);
  }

  // Process usages
  final usages = await Usages.generate(session, provider, packages, _usages);
  for (final MapEntry(key: folder, value: snippets) in usages.entries) {
    for (final MapEntry(key: name, value: snippet) in snippets.entries) {
      final json = const JsonEncoder.withIndent('  ').convert(snippet.toJson());
      final file = File(p.join(output, 'usages', folder, '$name.json'));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(json);
    }
  }
}
