import 'dart:async';

import '../../flutter_test_config.dart';

const _kGoldenTestsThreshold = 1.04 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await configureGoldenTests(_kGoldenTestsThreshold);
  await testMain();
}
