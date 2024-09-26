import 'dart:async';

import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

import '../../flutter_test_config.dart';

const _kGoldenTestsThreshold = 2 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  LeakTesting.enable();
  await configureGoldenTests(_kGoldenTestsThreshold);
  await testMain();
}
