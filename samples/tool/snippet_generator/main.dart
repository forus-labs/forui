import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'extraction/samples.dart';
import 'snippet.dart';

/// The formatter used to format the generated code snippets.
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

final samples = p.join(Directory.current.parent.path, 'samples', 'lib');
final _foundation = p.join(samples, 'foundation');
final _widgets = p.join(samples, 'widgets');

/// Information about a Dart package.
class Package {
  static List<Package> find() {
    const names = ['forui', 'forui_assets', 'forui_hooks'];
    final root = Directory.current.parent.path;
    final packages = <Package>[];

    for (final name in names) {
      final pubspecPath = p.join(root, name, 'pubspec.yaml');
      final content = File(pubspecPath).readAsStringSync();
      final yaml = loadYaml(content) as Map;
      packages.add(Package(name: name, version: yaml['version'] as String, path: p.join(root, name, 'lib')));
    }

    return packages;
  }

  /// The name.
  final String name;

  /// The version.
  final String version;

  /// The path, relative to the repository root.
  final String path;

  Package({required this.name, required this.version, required this.path});
}

Future<void> main() async {
  final packages = Package.find();
  final provider = OverlayResourceProvider(PhysicalResourceProvider.INSTANCE);
  final collection = AnalysisContextCollection(
    includedPaths: [
      ...[for (final p in packages) p.path],
      samples,
    ],
    resourceProvider: provider,
  );

  // Extract & annotate sample snippets.
  for (final snippet in (await Samples.extract(collection, packages, [_foundation, _widgets], provider)).values) {
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
