// ignore_for_file: avoid_positional_boolean_parameters

import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_style/dart_style.dart';
import 'package:sugar/core.dart';

import 'traversal.dart';

final constructor = RegExp(r'F([^ ]*?Styles?)\.inherit');

final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion, pageWidth: 120);

typedef Fragment = ({int position, String source, List<String> closure});

/// Maps a constructor declaration AST to a function.
Map<String, Fragment> map(Map<String, Metadata> metadatas) => {
  for (final MapEntry(:key, value: metadata) in metadatas.entries)
    key: (
      position: key.length + 1,
      source: formatter.format(switch (metadata.constructor) {
        final constructor when constructor.factoryKeyword != null => _factory(key, metadata),
        final constructor when constructor.initializers.singleOrNull is RedirectingConstructorInvocation =>
          _redirecting(key, metadata),
        _ => _initializers(key, metadata),
      }),
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
    .replaceAllMapped(constructor, (match) => '_${match.group(1)!.toCamelCase()}');

String _redirecting(String type, Metadata metadata) => metadata.constructor
    .toSource()
    .replaceAll('$type.inherit', '$type ${type.substring(1).toCamelCase()}')
    .replaceAll(' : this', ' => $type')
    .replaceAllMapped(constructor, (match) => '_${match.group(1)!.toCamelCase()}');

String _initializers(String type, Metadata metadata) {
  if (metadata.constructor.body.toSource() != ';') {
    throw UnsupportedError(
      'style_preprocessor does not support constructor bodies: ${metadata.constructor.toSource()}',
    );
  }

  final parameters = <String>[];
  var superInherit = false;
  var constructorParameters = metadata.constructor.parameters.toSource();

  for (final parameter in metadata.constructor.parameters.parameters) {
    parameters.add('${parameter.name!.lexeme}: ${parameter.name!.lexeme},');

    if (parameter case final DefaultFormalParameter superParameter) {
      if (superParameter.parameter case final SuperFormalParameter superParameter) {
        superInherit = true;
        constructorParameters = constructorParameters.replaceAll(
          'super.${parameter.name!.lexeme}',
          '${superParameter.declaredElement?.type} ${parameter.name!.lexeme}',
        );
      }
    }
  }

  if (superInherit) {
    // We give up inlining the inherit constructor if it calls super.inherit(...). Shit's hard.
    return '$type ${type.substring(1).toCamelCase()}$constructorParameters => $type.inherit(${parameters.join()});';
  } else {
    final arguments = metadata.constructor.initializers
        .whereType<ConstructorFieldInitializer>()
        .map((initializer) => '${initializer.fieldName}: ${initializer.expression.toSource()},')
        .toList()
        .join()
        .replaceAllMapped(constructor, (match) => '_${match.group(1)!.toCamelCase()}');

    return '$type ${type.substring(1).toCamelCase()}$constructorParameters => $type($arguments);';
  }
}
