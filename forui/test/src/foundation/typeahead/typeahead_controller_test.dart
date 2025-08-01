import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

const initial = ['apple', 'banana', 'cherry'];

void main() {
  late FTypeaheadController controller;

  setUp(() {
    controller = FTypeaheadController(
      textStyles: (context) => (const TextStyle(), const TextStyle(), const TextStyle()),
      text: 'm',
      suggestions: initial,
    );
  });

  tearDown(() {
    controller.dispose();
  });

  group('complete(...)', () {
    test('has suggestion', () {
      var notificationCount = 0;
      controller
        ..text = 'ap'
        ..addListener(() => notificationCount++)
        ..complete();

      expect(controller.text, 'apple');
      expect(controller.current, null);
      expect(controller.selection, const TextSelection.collapsed(offset: 5));
      expect(notificationCount, 1);
    });

    test('has no suggestion', () {
      var notificationCount = 0;
      controller
        ..text = 'xyz'
        ..addListener(() => notificationCount++)
        ..complete();

      expect(controller.text, 'xyz');
      expect(controller.current, null);
      expect(notificationCount, 0);
    });
  });

  group('findCompletion(...)', () {
    test('empty text', () {
      controller.text = '';

      expect(controller.current, null);
    });

    test('exact prefix match', () {
      controller.text = 'ap';

      expect(controller.current, (completion: 'ple', replacement: 'apple'));
    });

    test('case-insensitive prefix match', () {
      controller.text = 'AP';

      expect(controller.current, (completion: 'ple', replacement: 'apple'));
    });

    test('multiple matches', () {
      controller
        ..loadSuggestions(['apple', 'apricot', 'avocado'])
        ..text = 'a';

      expect(controller.current, (completion: 'pple', replacement: 'apple'));
    });

    test('no matches', () {
      controller
        ..loadSuggestions(['apple', 'apricot', 'avocado'])
        ..text = 'a'
        ..text = 'xyz';

      expect(controller.current, null);
    });

    test('text is longer than suggestion', () {
      controller.text = 'appletree';

      expect(controller.current, null);
    });

    test('exact match', () {
      controller.text = 'cherry';

      expect(controller.current, (completion: '', replacement: 'cherry'));
    });

    test('explicit text parameter', () {
      controller
        ..text = 'original'
        ..findCompletion('ap');

      expect(controller.text, 'original');
      expect(controller.current, (completion: 'ple', replacement: 'apple'));
    });
  });

  group('loadSuggestions(...)', () {
    const suggestions = ['orange', 'grape', 'mango'];

    test('loads suggestions from sync iterable', () async {
      unawaited(controller.loadSuggestions(suggestions));

      expect(controller.current, (completion: 'ango', replacement: 'mango'));
      expect(controller.suggestions, suggestions);
    });

    test('loads suggestions from async iterable', () async {
      await controller.loadSuggestions(Future.value(suggestions));

      expect(controller.suggestions, suggestions);
      expect(controller.current, (completion: 'ango', replacement: 'mango'));
    });

    test('ignores async iterable when disposed', () async {
      final controller = FTypeaheadController(
        textStyles: (context) => (const TextStyle(), const TextStyle(), const TextStyle()),
        text: 'm',
        suggestions: initial,
      );
      final completer = Completer<List<String>>();

      final future = controller.loadSuggestions(completer.future);
      controller.dispose();
      completer.complete(suggestions);

      await future;

      expect(controller.suggestions, initial);
      expect(controller.current, null);
    });

    test('ignores stale async iterables', () async {
      final firstSuggestions = ['kiwi', 'pear'];
      final secondSuggestions = ['orange', 'grape', 'mango'];

      final firstCompleter = Completer<List<String>>();
      final secondCompleter = Completer<List<String>>();

      final firstFuture = controller.loadSuggestions(firstCompleter.future);
      final secondFuture = controller.loadSuggestions(secondCompleter.future);

      secondCompleter.complete(secondSuggestions);
      await secondFuture;

      firstCompleter.complete(firstSuggestions);
      await firstFuture;

      expect(controller.suggestions, secondSuggestions);
      expect(controller.current, (completion: 'ango', replacement: 'mango'));
    });

    test('updates suggestions and notifies listeners', () async {
      var notificationCount = 0;
      controller.addListener(() => notificationCount++);

      final suggestions = ['orange', 'grape', 'mango'];

      await controller.loadSuggestions(suggestions);

      expect(controller.suggestions, suggestions);
      expect(controller.current, (completion: 'ango', replacement: 'mango'));
      expect(notificationCount, 1);
    });

    test('does not notify listeners when suggestions are identical', () async {
      var notificationCount = 0;
      controller.addListener(() => notificationCount++);

      // We don't use the same reference to initial to avoid identity equality comparisons.
      final same = ['apple', 'banana', 'cherry'];

      await controller.loadSuggestions(same);

      expect(controller.suggestions, same);
      expect(controller.current, null);
      expect(notificationCount, 0);
    });

    test('handles empty suggestions', () async {
      controller.text = 'ap';

      await controller.loadSuggestions(<String>[]);

      expect(controller.suggestions, []);
      expect(controller.current, null);
    });
  });

  group('text', () {
    test('different text', () {
      controller.text = 'hello';

      expect(controller.text, 'hello');
      expect(controller.selection, const TextSelection.collapsed(offset: 5));
    });

    test('same text', () {
      controller.text = 'm';

      expect(controller.text, 'm');
    });

    test('updates completion', () {
      controller.text = 'ap';
      expect(controller.current, (completion: 'ple', replacement: 'apple'));
    });

    test('clears completion', () {
      controller.text = 'ap';
      expect(controller.current, (completion: 'ple', replacement: 'apple'));

      controller.text = 'xyz';
      expect(controller.current, null);
    });
  });

  group('value', () {
    test('updates completion', () {
      controller.value = const TextEditingValue(text: 'ap', selection: TextSelection.collapsed(offset: 2));
      expect(controller.current, (completion: 'ple', replacement: 'apple'));
    });

    test('empty text', () {
      controller.text = 'ap';
      expect(controller.current, (completion: 'ple', replacement: 'apple'));

      controller.value = const TextEditingValue(selection: TextSelection.collapsed(offset: 0));

      expect(controller.current, null);
    });
  });
}
