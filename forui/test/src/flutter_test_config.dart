import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

import 'threshold_file_comparator.dart';

const _kGoldenTestsThreshold = 0.5 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  LeakTesting.enable();
  await configureGoldenTests(_kGoldenTestsThreshold);
  await testMain();
}

Future<void> configureGoldenTests(double threshold) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fontLoader = FontLoader('packages/forui/Inter');
  final directory = Directory('./assets/fonts/inter/');
  for (final file in directory.listSync().whereType<File>().where((e) => e.path.endsWith('.ttf'))) {
    fontLoader.addFont(rootBundle.load(file.path));
  }

  await fontLoader.load();

  if (goldenFileComparator case final LocalFileComparator _) {
    goldenFileComparator = ThresholdComparator(
      // flutter_test's LocalFileComparator expects the test's URI to be passed
      // as an argument, but it only uses it to parse the baseDir in order to
      // obtain the directory where the golden images will be placed.
      // As such, we use the default `testUrl`, which is only the `baseDir` and
      // append a generically named `test.dart` so that the `baseDir` is
      // properly extracted.
      Uri.parse('./test/golden/test.dart'),
      threshold,
    );
  }
}
