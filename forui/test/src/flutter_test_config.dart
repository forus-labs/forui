import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

import 'test_scaffold.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  WidgetController.hitTestWarningShouldBeFatal = true;
  LeakTesting.enable();
  LeakTesting.settings = LeakTesting.settings.withIgnored(
    createdByTestHelpers: true,
    classes: ['Image', 'ImageInfo', 'ImageStreamCompleterHandle', '_CachedImage'],
  );

  final inter = FontLoader('packages/forui/Inter');
  for (final file in Directory('$relativePath/assets/fonts/inter/').listSync().whereType<File>()) {
    inter.addFont(rootBundle.load(file.path));
  }
  await inter.load();

  final lucide = FontLoader('packages/forui_assets/ForuiLucideIcons')
    ..addFont(rootBundle.load('packages/forui_assets/assets/lucide.ttf'));
  await lucide.load();

  if (goldenFileComparator is LocalFileComparator) {
    goldenFileComparator = LocalFileComparator(
      // flutter_test's LocalFileComparator expects the test's URI to be passed
      // as an argument, but it only uses it to parse the baseDir in order to
      // obtain the directory where the golden images will be placed.
      // As such, we use the default `testUrl`, which is only the `baseDir` and
      // append a generically named `test.dart` so that the `baseDir` is
      // properly extracted.
      Uri.parse('$relativePath/test/golden/${Platform.operatingSystem}/test.dart'),
    );
  }

  await testMain();
}
