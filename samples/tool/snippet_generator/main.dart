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

import 'transformation/samples.dart';
import 'snippet.dart';

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

final samples = p.join(Directory.current.parent.path, 'samples', 'lib');
final _foundation = p.join(samples, 'foundation');
final _widgets = p.join(samples, 'widgets');

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
    includedPaths: [for (final path in paths) p.join(Directory.current.parent.path, path, 'lib'), samples],
    resourceProvider: provider,
  );
  final session = collection.contextFor(samples).currentSession;

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

  // Extract & annotate sample snippets.
  for (final snippet in (await Samples.transform(session, provider, packages, [_foundation, _widgets])).values) {
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
