import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
extension Alignments on Alignment {
  Alignment flipX() => switch (this) {
        Alignment.topLeft => Alignment.topRight,
        Alignment.topRight => Alignment.topLeft,
        Alignment.centerLeft => Alignment.centerRight,
        Alignment.centerRight => Alignment.centerLeft,
        Alignment.bottomLeft => Alignment.bottomRight,
        Alignment.bottomRight => Alignment.bottomLeft,
        _ => this,
      };

  Alignment flipY() => switch (this) {
        Alignment.topLeft => Alignment.bottomLeft,
        Alignment.topCenter => Alignment.bottomCenter,
        Alignment.topRight => Alignment.bottomRight,
        Alignment.bottomLeft => Alignment.topLeft,
        Alignment.bottomCenter => Alignment.topCenter,
        Alignment.bottomRight => Alignment.topRight,
        _ => this,
      };

  Offset relative({required Size to, Offset origin = Offset.zero}) => switch (this) {
        Alignment.topCenter => to.topCenter(origin),
        Alignment.topRight => to.topRight(origin),
        Alignment.centerLeft => to.centerLeft(origin),
        Alignment.center => to.center(origin),
        Alignment.centerRight => to.centerRight(origin),
        Alignment.bottomLeft => to.bottomLeft(origin),
        Alignment.bottomCenter => to.bottomCenter(origin),
        Alignment.bottomRight => to.bottomRight(origin),
        _ => to.topLeft(origin),
      };
}
