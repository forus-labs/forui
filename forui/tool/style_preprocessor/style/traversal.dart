import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../main.dart';
import 'package:path/path.dart' as path;

/// Traverses the library and finds all styles that have an inherit constructor.
Future<Map<String, Metadata>> traverse(AnalysisContextCollection collection) async {
  final rootStyles = await _findRootStyles(collection);
  final files =
      Directory(
        library,
      ).listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart')).map((f) => f.path).toList();

  final visitor = _TraverseVisitor(rootStyles);
  for (final file in files) {
    if (await collection.contextFor(file).currentSession.getResolvedUnit(file) case final ResolvedUnitResult result) {
      result.unit.accept(visitor);
    }
  }

  return visitor.styles;
}

class Metadata {
  final bool root;
  final ConstructorDeclaration constructor;
  final Set<String> nested = {};

  Metadata({required this.root, required this.constructor});
}

class _TraverseVisitor extends RecursiveAstVisitor<void> {
  static final _constructor = RegExp(r'(F[^ ]*?Styles?)\.inherit');

  static Set<String> _match(String source) => _constructor.allMatches(source).map((m) => m.group(1)!).toSet();

  final Map<String, Metadata> styles = {};
  final Set<String> _root;
  ClassDeclaration? _class;

  _TraverseVisitor(this._root);

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.name.lexeme;
    if (RegExp('F[^ ]*?Styles?').hasMatch(name)) {
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

    styles[_class!.name.lexeme] = Metadata(root: _root.contains(_class!.name.lexeme), constructor: constructor);

    // Constructors typically consist of:
    // * Factory constructors
    // * Field initializers
    // * Redirecting constructors

    final nested = styles[_class!.name.lexeme]!.nested..addAll(_match(constructor.body.toSource()));
    for (final initializer in constructor.initializers) {
      nested.addAll(_match(initializer.toSource()));
    }

    super.visitConstructorDeclaration(constructor);
  }

  @override
  void visitRedirectingConstructorInvocation(RedirectingConstructorInvocation invocation) {
    // TODO: It will be nice to check for, and fail if there are external/private method invocations.
    styles[_class!.name.lexeme]!.nested.addAll(_match(invocation.argumentList.toSource()));
  }
}

/// Finds the root styles in the theme data file.
Future<Set<String>> _findRootStyles(AnalysisContextCollection collection) async {
  const otherRoots = {
    'FFormFieldStyle', //
    'FFormFieldErrorStyle', //
    'FFocusedOutlineStyle', //
    'FTappableStyle', //
  };

  final theme = path.join(library, 'src', 'theme', 'theme_data.dart');
  if (await collection.contextFor(theme).currentSession.getResolvedUnit(theme) case final ResolvedUnitResult result) {
    final visitor = _RootVisitor();
    result.unit.accept(visitor);

    return {...visitor.root, ...otherRoots};
  }

  throw Exception('Failed to parse $theme');
}

class _RootVisitor extends RecursiveAstVisitor<void> {
  final Set<String> root = {};

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.name.lexeme;
    if (name == 'FThemeData') {
      super.visitClassDeclaration(declaration);
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration declaration) {
    final type = declaration.fields.type?.type?.getDisplayString() ?? '';
    if (!declaration.isStatic && RegExp('F[^ ]*?Styles?').hasMatch(type)) {
      root.add(type);
    }
  }
}
