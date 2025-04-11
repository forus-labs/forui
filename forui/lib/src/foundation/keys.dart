import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@internal
class ListKey<T> extends LocalKey {
  final List<T> items;

  const ListKey(this.items);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ListKey<T> && listEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hashAll(items);

  @override
  String toString() => 'ListKey(${items.join(', ')})';
}

@internal
class SetKey<T> extends LocalKey {
  final Set<T> items;

  const SetKey(this.items);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SetKey<T> && setEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hashAll(items.toList()..sort((a, b) => a.hashCode.compareTo(b.hashCode)));

  @override
  String toString() => 'SetKey(${items.join(', ')})';
}

@internal
class MapKey<K, V> extends LocalKey {
  final Map<K, V> map;

  const MapKey(this.map);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MapKey<K, V> && mapEquals(other.map, map);
  }

  @override
  int get hashCode {
    final sortedKeys = map.keys.toList()..sort((a, b) => a.hashCode.compareTo(b.hashCode));
    return Object.hashAll(sortedKeys.map((k) => Object.hash(k, map[k])));
  }

  @override
  String toString() {
    final entries = map.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    return 'MapKey({$entries})';
  }
}
