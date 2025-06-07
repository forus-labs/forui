import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart';

class AtlasFileComparator extends GoldenFileComparator {
  final Uri _directory;
  final Rectangle<int> _region;

  AtlasFileComparator(this._directory, this._region);

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) {
    final test = decodeImage(imageBytes);
  }

  @override
  Future<void> update(Uri golden, Uint8List imageBytes) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
