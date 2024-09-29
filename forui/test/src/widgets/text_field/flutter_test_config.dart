import 'dart:async';

import '../../flutter_test_config.dart';

const _kGoldenTestsThreshold = 5.4 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await configureGoldenTests(_kGoldenTestsThreshold);
  await testMain();
}
