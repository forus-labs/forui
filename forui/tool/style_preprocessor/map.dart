// ignore_for_file: avoid_positional_boolean_parameters

import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sugar/core.dart';

import 'traversal.dart';

final constructor = RegExp(r'F([^ ]*?Styles?)\.inherit');

final formatter = DartFormatter(languageVersion: Version(3, 7, 0), pageWidth: 120);

typedef Fragment = ({bool public, int position, String source, List<String> closure});

/// Maps a constructor declaration AST to a function.
Map<String, Fragment> map(Map<String, Metadata> metadatas) => {
  for (final MapEntry(:key, value: metadata) in metadatas.entries)
    key: (
      public: metadata.root,
      position: key.length + 1,
      source: formatter.format(switch (metadata.constructor) {
        final constructor when constructor.factoryKeyword != null => _factory(key, metadata),
        final constructor when constructor.initializers.singleOrNull is RedirectingConstructorInvocation =>
          _redirecting(key, metadata),
        _ => _initializers(key, metadata),
      }).trimLeft(),
      closure: closure(key, metadatas),
    ),
};

List<String> closure(String key, Map<String, Metadata> metadata) {
  final elements = <String>[];

  void dfs(String element) {
    elements.add(element);
    metadata[element]?.nested.forEach(dfs);
  }

  dfs(key);

  final seen = <String>{};
  final result = <String>[];
  for (final element in elements.reversed) {
    if (seen.add(element)) {
      result.add(element);
    }
  }

  return result.reversed.toList();
}

String _factory(String type, Metadata metadata) => metadata.constructor
    .toSource()
    .replaceAll('factory $type.inherit', '$type ${type.substring(1).toCamelCase()}')
    .replaceAllMapped(constructor, (match) => match.group(1)!.toCamelCase());

String _redirecting(String type, Metadata metadata) => metadata.constructor
    .toSource()
    .replaceAll('$type.inherit', '$type ${type.substring(1).toCamelCase()}')
    .replaceAll(' : this', ' => $type')
    .replaceAllMapped(constructor, (match) => match.group(1)!.toCamelCase());

String _initializers(String type, Metadata metadata) {
  if (metadata.constructor.body.toSource() != ';') {
    throw UnsupportedError(
      'style_preprocessor does not support constructor bodies: ${metadata.constructor.toSource()}',
    );
  }

  final arguments =
      metadata.constructor.initializers
          .whereType<ConstructorFieldInitializer>()
          .map((initializer) => '${initializer.fieldName}: ${initializer.expression.toSource()},')
          .toList()
          .join()
          .replaceAllMapped(constructor, (match) => match.group(1)!.toCamelCase());

  return '$type ${type.substring(1).toCamelCase()}${metadata.constructor.parameters.toSource()} => $type($arguments);';
}
