import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:code_builder/code_builder.dart';

import '../main.dart';

const iconMapping = 'icon-mapping';

String mapIconMapping(List<String> icons) {
  final library = LibraryBuilder()
    ..comments.addAll([header])
    ..body.addAll([
      (EnumBuilder()
            ..docs.addAll([
              '/// Provides a mapping for [FIcons] which can be iterated over using [EnumByName].',
              '///',
              '/// ## Note',
              '/// This enum may prevent [FIcons] from being tree-shaken and result in larger bundle sizes.',
            ])
            ..name = 'FIconMapping'
            ..values.addAll([
              for (final icon in icons)
                (EnumValueBuilder()
                      ..name = icon
                      ..arguments.addAll([refer('FIcons.$icon')]))
                    .build(),
            ])
            ..fields.addAll([
              (FieldBuilder()
                    ..docs.addAll(['/// The icon data.'])
                    ..name = 'icon'
                    ..type = refer('IconData')
                    ..modifier = FieldModifier.final$)
                  .build(),
            ])
            ..constructors.add(
              (ConstructorBuilder()
                    ..constant = true
                    ..requiredParameters.addAll([Parameter((p) => p..name = 'this.icon')]))
                  .build(),
            ))
          .build(),
    ]);

  final code =
      '''
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

${library.build().accept(emitter)}
''';
  return fragmentFormatter.format(code);
}

/// A visitor that finds all static const fields in a class.
class IconsFinder extends RecursiveAstVisitor<void> {
  final List<String> icons = [];

  @override
  void visitClassDeclaration(ClassDeclaration declaration) {
    final name = declaration.name.lexeme;
    if (name == 'FIcons') {
      super.visitClassDeclaration(declaration);
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration declaration) {
    if (declaration.isStatic && declaration.fields.isConst) {
      for (final variable in declaration.fields.variables) {
        icons.add(variable.name.lexeme);
      }
    }
    super.visitFieldDeclaration(declaration);
  }
}
