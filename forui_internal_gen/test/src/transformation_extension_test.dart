import 'package:forui_internal_gen/src/source/transformations_extension.dart';
import 'package:test/test.dart';

void main() {
  group('TransformationsExtension.summarizeDocs(...)', () {
    for (final (i, (docs, expected)) in [
      (null, null),
      ('', null),
      ('///', null),
      ('/// ', null),
      ('///   ', null),
    ].indexed) {
      test('trivial -$i', () => expect(TransformationsExtension.summarizeDocs(docs), expected));
    }

    for (final (i, (docs, expected)) in [
      ('/// {@macro myMacro}', '\n /// {@macro myMacro}'),
      ('/// {@macro myMacro} extra text', '\n /// {@macro myMacro} extra text'),
      ('/// {@macro myMacro}\n/// More text.', '\n /// {@macro myMacro}'),
    ].indexed) {
      test('{@macro} - $i', () => expect(TransformationsExtension.summarizeDocs(docs), expected));
    }

    for (final (i, (docs, expected)) in [
      ('/// {@template myTemplate}', null),
      ('/// {@template myTemplate}\n/// Some content.', null),
      ('/// {@template myTemplate}\n/// Some content.\n/// {@endtemplate}', 'Some content.'),
    ].indexed) {
      test('{@template} - $i', () => expect(TransformationsExtension.summarizeDocs(docs), expected));
    }

    group('basic', () {
      test('single', () {
        expect(TransformationsExtension.summarizeDocs('/// This is a test.'), 'This is a test.');
      });

      test('multiple', () {
        expect(TransformationsExtension.summarizeDocs('/// First sentence. Second sentence.'), 'First sentence.');
      });

      test('spans multi-line', () {
        expect(
          TransformationsExtension.summarizeDocs('/// This is the first\n/// sentence. More text.'),
          'This is the first sentence.',
        );
      });

      test('no sentence ending', () {
        expect(TransformationsExtension.summarizeDocs('/// No ending here'), null);
      });
    });

    group('brackets', () {
      test("'.'", () {
        expect(
          TransformationsExtension.summarizeDocs('/// Sets [FButton.style] property.'),
          'Sets [FButton.style] property.',
        );
      });

      test('nested', () {
        expect(
          TransformationsExtension.summarizeDocs('/// See [[inner.value]] reference.'),
          'See [[inner.value]] reference.',
        );
      });

      test('multiple pairs', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Uses [Foo.bar] and [Baz.qux] together.'),
          'Uses [Foo.bar] and [Baz.qux] together.',
        );
      });

      test('unclosed', () {
        expect(TransformationsExtension.summarizeDocs('/// Sets [FButton.style property.'), null);
      });
    });

    group('parenthesis', () {
      test('.', () {
        expect(TransformationsExtension.summarizeDocs('/// Uses foo (1.5) value.'), 'Uses foo (1.5) value.');
      });

      test('nested', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Calls func((inner.value)) here.'),
          'Calls func((inner.value)) here.',
        );
      });

      test('multiple pairs', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Uses foo(1.5) and bar(2.5) together.'),
          'Uses foo(1.5) and bar(2.5) together.',
        );
      });
    });

    group('backtick', () {
      test('.', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Call `value.property` first.'),
          'Call `value.property` first.',
        );
      });

      test('multiple sections', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Use `foo.bar` and `baz.qux` here.'),
          'Use `foo.bar` and `baz.qux` here.',
        );
      });
    });

    group('decimal handling', () {
      test('dot followed by space', () {
        expect(TransformationsExtension.summarizeDocs('/// Value is 1.0. More text.'), 'Value is 1.0.');
      });

      test('multiple decimals', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Values 1.5 and 2.5 are used.'),
          'Values 1.5 and 2.5 are used.',
        );
      });

      test('semantic version', () {
        expect(TransformationsExtension.summarizeDocs('/// Version 2.0.1 is here.'), 'Version 2.0.1 is here.');
      });
    });

    group('abbreviation handling', () {
      test('i.e.', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Use the function, i.e. call it. More text.'),
          'Use the function, i.e. call it.',
        );
      });

      test('e.g.', () {
        expect(TransformationsExtension.summarizeDocs('/// Pass a value, e.g. 5. More text.'), 'Pass a value, e.g. 5.');
      });
    });

    group('complex combinations', () {
      test('brackets, parens, and backticks', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Sets [FButton.style] using `getStyle(0.5)` method.'),
          'Sets [FButton.style] using `getStyle(0.5)` method.',
        );
      });

      test('nested structures with dots', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Uses [Widget.of(context).theme.data] value.'),
          'Uses [Widget.of(context).theme.data] value.',
        );
      });

      test('brackets inside backticks inside parens', () {
        expect(
          TransformationsExtension.summarizeDocs('/// Calls func(`[value.prop]`, 1.5) here.'),
          'Calls func(`[value.prop]`, 1.5) here.',
        );
      });
    });
  });
}
