import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'prefer_widgets_library',
  problemMessage: 'Prefer "flutter/widgets.dart" instead of "flutter/material.dart" and/or "flutter/cupertino.dart".',
  errorSeverity: ErrorSeverity.ERROR,
);

/// A lint rule that prefers importing "flutter/widgets.dart" instead of "flutter/material.dart" and/or
/// "flutter/cupertino.dart".
///
/// This rule is not enabled by default due to its performance implications.
class PreferWidgetsLibrary extends DartLintRule {
  static final _random = Random();

  /// Creates a new [PreferWidgetsLibrary].
  const PreferWidgetsLibrary() : super(code: _code);

  @override
  Future<void> run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) async {
    final analysis = AnalysisContextCollection(includedPaths: [resolver.path]).contextFor(resolver.path);
    final result = await analysis.currentSession.getErrors(resolver.path);

    // Files with part of/part declarations are current not supported. They're a major PITA to support.
    if (result case final ErrorsResult result when result.errors.isEmpty) {
      final temp = File(resolver.path).parent.file('temp_file_${_random.nextInt(100000000)}.dart');
      final original = File.fromUri(resolver.source.uri).readAsStringSync();

      for (final import in ['package:flutter/material.dart', 'package:flutter/cupertino.dart']) {
        final offset = original.indexOf(import);
        if (offset == -1) {
          continue;
        }

        try {
          temp.writeAsStringSync(original.replaceAll(import, 'package:flutter/widgets.dart'));
          if (await analysis.currentSession.getErrors(temp.path) case final ErrorsResult r when r.errors.isEmpty) {
            reporter.atOffset(
              offset: offset,
              length: import.length,
              errorCode: LintCode(
                name: 'prefer_widgets_library',
                problemMessage: 'Prefer package:flutter/widgets.dart instead of $import.',
              ),
            );
          }
        } finally {
          if (temp.existsSync()) {
            unawaited(temp.delete());
          }
        }
      }
    }
  }
}
