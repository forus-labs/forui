import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

import '../main.dart';

Map<String, LibraryElement?> _cache = {};

/// Returns the URL for [element], or null if it shouldn't be linked.
String? dartDocUrl(List<Package> packages, Element element) {
  final n = element.library?.uri.pathSegments.first;
  if (packages.firstWhereOrNull((p) => p.name == n) case Package(name: final package, :final version)) {
    final type = switch (element) {
      FieldElement(:final enclosingElement) => enclosingElement.name,
      PropertyAccessorElement(:final enclosingElement) => enclosingElement.name,
      ConstructorElement(:final enclosingElement) => enclosingElement.name,
      MethodElement(:final enclosingElement?) => enclosingElement.name,
      _ => element.name,
    };

    var baseUrl = '';
    for (final Package(:library) in packages) {
      if (_barrel(library, type!)?.name case final name?) {
        baseUrl = 'https://pub.dev/documentation/$package/$version/${name.isEmpty ? package : name}';
        break;
      }
    }

    assert(baseUrl.isNotEmpty, 'Could not find barrel library for type "$type" in package "$package".');

    return switch (element) {
      TopLevelFunctionElement(:final name) => '$baseUrl/$name.html',
      EnumElement(:final name) => '$baseUrl/$name.html',
      ExtensionElement(:final name) => '$baseUrl/$name.html',
      MixinElement(:final name) => '$baseUrl/$name-mixin.html',
      ClassElement(:final name) || InterfaceElement(:final name) => '$baseUrl/$name-class.html',
      FieldElement(:final enclosingElement, :final name, :final isEnumConstant) when isEnumConstant =>
      '$baseUrl/${enclosingElement.name}.html#$name',
      FieldElement(:final enclosingElement, :final name, :final isConst) when isConst =>
      '$baseUrl/${enclosingElement.name}/$name-constant.html',
      FieldElement(:final enclosingElement, :final name) => '$baseUrl/${enclosingElement.name}/$name.html',
      PropertyAccessorElement(:final enclosingElement, :final name) => '$baseUrl/${enclosingElement.name}/$name.html',
      ConstructorElement(:final enclosingElement, :final name?) =>
      '$baseUrl/${enclosingElement.name}/${enclosingElement.name}${name == 'new' ? '' : '.$name'}.html',
      MethodElement(:final enclosingElement?, :final name) => '$baseUrl/${enclosingElement.name}/$name.html',
      _ => null,
    };
  }

  return null;
}

/// Returns the deepest barrel library that exports [type].
LibraryElement? _barrel(LibraryElement library, String type) {
  LibraryElement? barrel(LibraryElement library, String type) {
    if (library.exportNamespace.get2(type) == null) {
      return null;
    }

    for (final lib in library.exportedLibraries.where((l) => !l.uri.pathSegments.contains('src'))) {
      if (lib.exportNamespace.get2(type) != null) {
        return barrel(lib, type);
      }
    }

    return library;
  }

  if (_cache.containsKey(type)) {
    return _cache[type];
  }

  return _cache[type] = barrel(library, type);
}
