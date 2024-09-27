import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

@internal
extension RenderBoxes on RenderBox {
  BoxParentData get data => parentData! as BoxParentData;
}
