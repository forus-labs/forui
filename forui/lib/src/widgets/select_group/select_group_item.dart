import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// An item that represents a selection in a [FSelectGroup].
class FSelectGroupItem<T> with Diagnosticable {
  /// The value of the item.
  T value;

  /// The builder that creates the item's widget.
  Widget Function(BuildContext context, void Function(T value, bool selected) onChange, bool selected) builder;

  /// Creates a [FSelectGroupItem].
  FSelectGroupItem({
    required this.value,
    required this.builder,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(ObjectFlagProperty.has('builder', builder));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupItem && runtimeType == other.runtimeType && value == other.value && builder == other.builder;

  @override
  int get hashCode => value.hashCode ^ builder.hashCode;
}
