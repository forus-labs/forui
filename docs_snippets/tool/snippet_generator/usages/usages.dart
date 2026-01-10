import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import '../snippet.dart';
import '../tooltip_linker.dart';
import 'verification.dart';

final _prefix = RegExp(r'^///\s*');
final _category = RegExp(r'([ \t]*)// \{@category "([^"]+)"\}\n([\s\S]*?\n)[ \t]*// \{@endcategory\}\n');
final _variant = RegExp(r'^// \{@category "([^"]+)" "([^"]+)"\}$');
final _label = RegExp(r'^\s*(\w+):');

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

/// Finds top-level variable declarations WITHOUT `// {@control}` and extracts categorized arguments.
class Usages extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  static Future<Map<String, Map<String, Usage>>> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String directory,
  ) async {
    final usages = <String, Map<String, Usage>>{};
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

  static Future<Map<String, Usage>> _process(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    ResolvedUnitResult result,
  ) async {
    final (links, tooltips) = await TooltipLinker.generate(session, overlay, packages, result.content);
    final spans = [...links, ...tooltips];

    final variants = Variants(result.content, spans);
    result.unit.visitChildren(variants);

    final constructors = Usages(result.content, spans, variants.categories);
    result.unit.visitChildren(constructors);

    Verifier.verify(result);

    return constructors.usages;
  }

  final Map<String, Usage> usages = {};
  final String _text;
  final List<Span> _spans;
  final Map<String, List<Variant>> _categories;

  Usages(this._text, this._spans, this._categories);

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    // Skip if has // {@category "..." "..."} comment - those are handled by Variants
    final comment = node.firstTokenAfterCommentAndMetadata.precedingComments?.lexeme.trim();
    if (comment != null && _variant.hasMatch(comment)) {
      return;
    }

    final VariableDeclaration(:name, initializer: Expression(:offset, :end)!) = node.variables.variables.single;
    final usage = Usage(_text.substring(offset, end), {})
      ..spans.addAll([
        for (final span in _spans)
          if (offset <= span.offset && span.end <= end) span.copyWith(offset: span.offset - offset),
      ]);

    // Process matches in reverse order so adjustments don't affect earlier match positions
    for (final match in _category.allMatches(usage.text).toList().reversed) {
      final indent = match.group(1)!;
      final name = match.group(2)!;
      final category = match.group(3)!;

      // Calculate content boundaries for span adjustment.
      final start = match.start + indent.length + '// {@category "$name"}\n'.length;
      final end = start + category.length;

      final placeholder = '{{$name}}';
      // We don't directly initialize usage's categories to preserve insertion ordering.
      if (_categories.containsKey(name)) {
        final label = _label.firstMatch(category)!.group(1)!;

        final spans = usage.adjustSpans(start, end, -(match.end - match.start - placeholder.length))
          ..removeWhere((s) => label.length <= s.offset);

        // We create a copy of each variant with adjusted spans to prevent multiple constructors in the same file
        // causing duplicate labels.
        usage.categories[name] = [
          for (final variant in _categories[name]!)
            Variant(variant.name, variant.description, '$indent$label: ${variant.text},\n')
              ..spans.addAll([
                for (final span in variant.spans) span.copyWith(offset: indent.length + span.offset + label.length + 2),
                ...spans,
              ]),
        ];
      } else {
        final spans = usage.adjustSpans(start, end, -(match.end - match.start - placeholder.length));
        usage.categories[name] = [Variant(name, '', category)..spans.addAll(spans)];
      }

      usage.text = usage.text.substring(0, match.start) + placeholder + usage.text.substring(match.end);
    }

    final sorted = Map.fromEntries(usage.categories.entries.toList().reversed);
    usage.categories
      ..clear()
      ..addAll(sorted);

    usages[name.lexeme] = usage;
  }
}

extension on Usage {
  List<Span> adjustSpans(int start, int end, int shift) {
    final spans = <Span>[];
    this.spans.removeWhere((span) {
      if (start <= span.offset && span.end <= end) {
        spans.add(span.copyWith(offset: span.offset - start));
        return true;
      }

      if (end <= span.offset) {
        span.adjust(shift);
      }

      return false;
    });
    return spans;
  }
}

/// Finds `// {@category "<category>" "<name>"}` annotated variable declarations and extracts the initializer.
class Variants extends RecursiveAstVisitor<void> {
  /// The categories with their variants.
  final Map<String, List<Variant>> categories = {};

  final String _text;
  final List<Span> _spans;

  Variants(this._text, this._spans);

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    final comment = node.firstTokenAfterCommentAndMetadata.precedingComments?.lexeme.trim();
    if (comment == null) {
      return;
    }

    final match = _variant.firstMatch(comment);
    if (match == null) {
      return;
    }

    final category = match.group(1)!;
    final name = match.group(2)!;
    final description =
        node.documentationComment?.tokens.map((t) => t.lexeme.replaceFirst(_prefix, '')).join(' ') ?? '';
    final Expression(:offset, :end) = node.variables.variables.single.initializer!;

    final variant = Variant(name, description, _text.substring(offset, end))
      ..spans.addAll([
        for (final span in _spans)
          if (offset <= span.offset && span.end <= end) span.copyWith(offset: span.offset - offset),
      ])
      ..indent(2, firstLine: false);

    (categories[category] ??= []).add(variant);
  }
}
