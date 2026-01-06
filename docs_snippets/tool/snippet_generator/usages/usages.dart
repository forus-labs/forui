import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import '../snippet.dart';
import '../tooltip_linker.dart';
import 'constructors.dart';

class Usage extends Snippet {
  final Map<String, List<Variant>> categories;

  Usage(super.text, this.categories);

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'categories': {
      for (final MapEntry(key: name, value: variants) in categories.entries)
        name: [for (final v in variants) v.toJson()],
    },
  };
}

/// A variant/option within a category (e.g., "managed" within "Control").
class Variant extends Snippet {
  final String name;
  final String description;

  Variant(this.name, this.description, [super.text]);

  @override
  Map<String, dynamic> toJson() => {'name': name, 'description': description, ...super.toJson()};
}

class Usages {
  static int _monotonic = 0;

  static Future<Map<String, Usage>> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String directory,
  ) async {
    final usages = <String, Usage>{};
    final dir = Directory(directory);

    for (final file in dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      final name = p.withoutExtension(p.relative(file.path, from: directory)).replaceAll(p.separator, '/');

      final path = p.join(lib, 'usage_${_monotonic++}.dart');
      overlay.setOverlay(
        path,
        content: formatter.format(file.readAsStringSync()),
        modificationStamp: DateTime.now().millisecondsSinceEpoch,
      );
      final result = await session.getResolvedUnit(path) as ResolvedUnitResult;

      usages[name] = await _process(session, overlay, packages, result);
    }

    return usages;
  }

  static Future<Usage> _process(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    ResolvedUnitResult result,
  ) async {
    final (links, tooltips) = await TooltipLinker.generate(session, overlay, packages, result.content);
    final spans = [...links, ...tooltips];

    final variants = Variants(result.content, spans);
    result.unit.visitChildren(variants);

    final constructors = Constructors(result.content, spans, variants.categories);
    result.unit.visitChildren(constructors);

    return constructors.usages.single;
  }
}
