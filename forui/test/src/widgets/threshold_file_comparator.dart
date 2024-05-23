import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';


/// A [LocalFileComparator] that tolerances a [threshold] percentage of difference. Exceeding the threshold will result
/// in a test failure.
class ThresholdComparator extends LocalFileComparator {

  final double threshold;

  ThresholdComparator(super.testFile, this.threshold):
    assert(0 <= threshold && threshold <= 1, 'Threshold must be between 0 and 1.');

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(imageBytes, await getGoldenBytes(golden));

    switch (result.passed) {
      case true:
        return true;

      case false when result.diffPercent <= threshold:
        debugPrint(
          'A difference of ${result.diffPercent * 100}% was found, but it is '
              'acceptable since it is not greater than the threshold of '
              '${threshold * 100}%',
        );
        return true;

      case false:
        final error = await generateFailureOutput(result, golden, basedir);
        throw FlutterError(error);
    }
  }
}