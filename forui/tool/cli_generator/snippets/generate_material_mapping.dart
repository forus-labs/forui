import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../main.dart';

const materialThemeMapping = 'material-mapping';

String mapMaterialThemeMapping(String method) => fragmentFormatter.format('''
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

extension CustomMaterialTheme on FThemeData {
  // Modify this method to customize how FThemeData is mapped to Material ThemeData.
  // 
  // To use this method:
  // ```dart
  // final theme = FTheme.zinc.light;
  //
  // MaterialApp(
  //   theme: theme.toCustomMaterialTheme(),
  // );
  // ```
  ${method.replaceAll('toApproximateMaterialTheme', 'toCustomMaterialTheme').replaceAll('@experimental', '')}
}
''');

class ToApproximateMaterialThemeFinder extends RecursiveAstVisitor<void> {
  String? snippet;

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.name.lexeme;
    if (name == 'FThemeData') {
      super.visitClassDeclaration(declaration);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration declaration) {
    if (declaration.name.lexeme == 'toApproximateMaterialTheme') {
      snippet = declaration.toSource();
    }
  }
}
