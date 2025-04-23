// ignore_for_file: deprecated_member_use - Wait for changes to stabilize before migrating.
// https://github.com/dart-lang/sdk/blob/main/pkg/analyzer/doc/element_model_migration_guide.md

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:sugar/sugar.dart';

import 'main.dart';

/// A constructor's code fragment.
class ConstructorFragment {
  /// Maps a matching constructor to a code fragment.
  static Map<String, ConstructorFragment> inline(RegExp pattern, Map<String, ConstructorMatch> matches) => {
    for (final MapEntry(:key, value: match) in matches.entries)
      key: ConstructorFragment(
        root: match.root,
        type: key,
        closure: _closure(key, matches),
        source: formatter.format(switch (match.constructor) {
          final constructor when constructor.factoryKeyword != null => _factory(key, pattern, match),
          final constructor when constructor.initializers.singleOrNull is RedirectingConstructorInvocation =>
            _redirecting(key, pattern, match),
          _ => _initializers(key, pattern, match),
        }),
      ),
  };

  static List<String> _closure(String key, Map<String, ConstructorMatch> matches) {
    final elements = <String>[];

    void dfs(String element) {
      elements.add(element);
      matches[element]?.nested.forEach(dfs);
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

  static String _factory(String type, RegExp pattern, ConstructorMatch match) => match.constructor
      .toSource()
      .replaceAll('factory $type.inherit', '$type ${type.substring(1).toCamelCase()}')
      .replaceAllMapped(pattern, (m) => '_${m.group(1)!.toCamelCase()}');

  static String _redirecting(String type, RegExp pattern, ConstructorMatch metadata) => metadata.constructor
      .toSource()
      .replaceAll('$type.inherit', '$type ${type.substring(1).toCamelCase()}')
      .replaceAll(' : this', ' => $type')
      .replaceAllMapped(pattern, (m) => '_${m.group(1)!.toCamelCase()}');

  static String _initializers(String type, RegExp pattern, ConstructorMatch match) {
    if (match.constructor.body.toSource() != ';') {
      throw UnsupportedError('Constructor bodies are not supported: ${match.constructor.toSource()}');
    }

    final parameters = <String>[];
    var abort = false;
    var constructorParameters = match.constructor.parameters.toSource();

    for (final parameter in match.constructor.parameters.parameters) {
      parameters.add('${parameter.name!.lexeme}: ${parameter.name!.lexeme},');

      if (parameter case final DefaultFormalParameter superParameter) {
        if (superParameter.parameter case final SuperFormalParameter superParameter) {
          abort = true;
          constructorParameters = constructorParameters.replaceAll(
            'super.${parameter.name!.lexeme}',
            '${superParameter.declaredElement?.type} ${parameter.name!.lexeme}',
          );
        } else if (parameter.parameter case final FieldFormalParameter parameter) {
          constructorParameters = constructorParameters.replaceAll(
            'this.${parameter.name.lexeme}',
            '${parameter.declaredElement?.type} ${parameter.name.lexeme}',
          );
        }
      }
    }

    for (final initializer in match.constructor.initializers) {
      if (initializer case final SuperConstructorInvocation _) {
        abort = true;
      }
    }

    if (abort) {
      // We give up inlining the inherit constructor if it calls super.inherit(...). Shit's hard.
      return '$type ${type.substring(1).toCamelCase()}$constructorParameters => $type.inherit(${parameters.join()});';
    }

    final arguments = match.constructor.initializers
        .whereType<ConstructorFieldInitializer>()
        .map((initializer) => '${initializer.fieldName}: ${initializer.expression.toSource()},')
        .toList()
        .join()
        .replaceAllMapped(pattern, (m) => '_${m.group(1)!.toCamelCase()}');

    return '$type ${type.substring(1).toCamelCase()}$constructorParameters => $type($arguments);';
  }

  final bool root;
  final String type;
  final List<String> closure;
  final String source;

  ConstructorFragment({required this.root, required this.type, required this.closure, required this.source});
}

class ConstructorMatch {
  /// Traverses the library and finds all matching constructors.
  static Future<Map<String, ConstructorMatch>> traverse(
    AnalysisContextCollection collection,
    RegExp type,
    RegExp constructor,
    Set<String> roots,
  ) async {
    final files =
        Directory(library)
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))
            .map((f) => f.path)
            .toList();

    final visitor = _Visitor(type, constructor, roots);
    for (final file in files) {
      if (await collection.contextFor(file).currentSession.getResolvedUnit(file) case final ResolvedUnitResult result) {
        result.unit.accept(visitor);
      }
    }

    return visitor.matches;
  }

  /// True if this is is part of a root class used in `FThemeData`.
  final bool root;

  /// The matching constructor.
  final ConstructorDeclaration constructor;

  /// The names of classes that are [ConstructorMatch]es and are created inside this [constructor].
  final Set<String> nested = {};

  ConstructorMatch({required this.root, required this.constructor});
}

class _Visitor extends RecursiveAstVisitor<void> {
  final Map<String, ConstructorMatch> matches = {};
  final RegExp _type;
  final RegExp _constructor;
  final Set<String> _roots;
  ClassDeclaration? _class;

  _Visitor(this._type, this._constructor, this._roots);

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.name.lexeme;
    if (_type.hasMatch(name)) {
      _class = declaration;
      super.visitClassDeclaration(declaration);
      _class = null;
    }
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration constructor) {
    if (constructor.name?.lexeme != 'inherit') {
      return;
    }

    matches[_class!.name.lexeme] = ConstructorMatch(
      root: _roots.contains(_class!.name.lexeme),
      constructor: constructor,
    );

    // Constructors typically consist of:
    // * Factory constructors
    // * Field initializers
    // * Redirecting constructors
    final nested = matches[_class!.name.lexeme]!.nested..addAll(_match(constructor.body.toSource()));
    for (final initializer in constructor.initializers) {
      nested.addAll(_match(initializer.toSource()));
    }

    super.visitConstructorDeclaration(constructor);
  }

  @override
  void visitRedirectingConstructorInvocation(RedirectingConstructorInvocation invocation) {
    // TODO: It will be nice to check for, and fail if there are external/private method invocations.
    matches[_class!.name.lexeme]!.nested.addAll(_match(invocation.argumentList.toSource()));
  }

  Set<String> _match(String source) => _constructor.allMatches(source).map((m) => m.group(1)!).toSet();
}
