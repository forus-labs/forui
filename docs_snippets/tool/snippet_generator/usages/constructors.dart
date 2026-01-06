import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../snippet.dart';
import 'usages.dart';

final _prefix = RegExp(r'^///\s*');
final _category = RegExp(r'// \{@category "([^"]+)"\}\n([\s\S]*?)\n\s*// \{@endcategory\}');
final _variant = RegExp(r'^// \{@category "([^"]+)" "([^"]+)"\}$');
final _label = RegExp(r'^\s*(\w+):');

/// Finds top-level variable declarations WITHOUT `// {@control}` and extracts categorized arguments.
class Constructors extends RecursiveAstVisitor<void> {
  final List<Usage> usages = [];
  final String _text;
  final List<Span> _spans;
  final Map<String, List<Variant>> _categories;

  Constructors(this._text, this._spans, this._categories);

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    // Skip if has // {@category "..." "..."} comment - those are handled by Variants
    final comment = node.firstTokenAfterCommentAndMetadata.precedingComments?.lexeme.trim();
    if (comment != null && _variant.hasMatch(comment)) {
      return;
    }

    final Expression(:offset, :end) = node.variables.variables.single.initializer!;
    final usage = Usage(_text.substring(offset, end), {..._categories})
      ..spans.addAll([
        for (final span in _spans)
          if (offset <= span.offset && span.end <= end) span.copyWith(offset: span.offset - offset),
      ]);

    // Process matches in reverse order so adjustments don't affect earlier match positions
    for (final match in _category.allMatches(usage.text).toList().reversed) {
      final name = match.group(1)!;
      final category = match.group(2)!;

      // We add 2 to remove the prefixing indentation, and use trim().length since trimRight().length includes the
      // leading spaces we already skipped.
      final start = match.start + '// {@category "$name"}\n'.length + 2;
      final end = start + category.trim().length;

      final String placeholder;
      if (usage.categories.containsKey(name)) {
        // We replace only the value if the category already exists.
        final label = _label.firstMatch(category)!.group(1)!;
        placeholder = '$label: {{$name}},';

        usage.adjustSpans(start + label.length, end, -(match.end - match.start - placeholder.length));

        // Adjust the label's spans to the new position.
        for (final span in usage.spans) {
          if (start <= span.offset && span.offset < start + label.length) {
            span.adjust(match.start - start);
          }
        }
      } else {
        placeholder = '{{$name}}';

        final spans = usage.adjustSpans(start, end, -(match.end - match.start - placeholder.length));
        usage.categories[name] = [Variant(name, '', category.trim())..spans.addAll(spans)];
      }

      usage.text = usage.text.substring(0, match.start) + placeholder + usage.text.substring(match.end);
    }

    final sorted = Map.fromEntries(usage.categories.entries.toList().reversed);
    usage.categories
      ..clear()
      ..addAll(sorted);

    usages.add(usage);
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
