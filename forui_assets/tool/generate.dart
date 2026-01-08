import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:html/parser.dart' as html;
import 'package:sugar/core.dart';

const family = 'ForuiLucideIcons';
const package = 'forui_assets';

const directional = {
  'arrow-big-left-dash',
  'arrow-big-left',
  'arrow-big-right-dash',
  'arrow-big-right',
  'arrow-left-from-line',
  'arrow-left-to-line',
  'arrow-left',
  'arrow-right-from-line',
  'arrow-right-to-line',
  'arrow-right',
  'chevron-first',
  'chevron-last',
  'chevron-left',
  'chevron-right',
  'chevrons-left',
  'chevrons-right',
  'circle-arrow-left',
  'circle-arrow-right',
  'circle-chevron-left',
  'circle-chevron-right',
  'indent-decrease',
  'indent-increase',
  'square-arrow-left',
  'square-arrow-right',
  'square-chevrons-left',
  'square-chevrons-right',
};

const url = 'https://raw.githubusercontent.com/lucide-icons/lucide/refs/tags/0.562.0/icons';

void main() {
  // ignore: avoid_print
  print('Remember to update the version in the url constant when updating the font.');

  final file = File('./.dart_tool/lucide-font/lucide.ttf');
  if (file.existsSync()) {
    file.copySync('./assets/lucide.ttf');
  } else {
    throw StateError('Lucide font not found. Please download and unzip it into .dart_tool/lucide-font/');
  }

  generate(parse());
}

// This script assumes that .dart_tool/lucide-font exists. The archive is manually downloaded and unzipped from
// https://github.com/lucide-icons/lucide/releases/latest.
List<(String, String, String)> parse() => html
    .parse(File('./.dart_tool/lucide-font/unicode.html').readAsStringSync())
    .getElementsByClassName('unicode-icon')
    .map(
      (element) => (
        element.getElementsByTagName('h4').single.text.toCamelCase(),
        element.getElementsByTagName('h4').single.text,
        element.getElementsByClassName('unicode').single.text.replaceAll('&#', '').replaceAll(';', ''),
      ),
    )
    .toList();

const header =
    '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// 
// **************************************************************************
// $package
// **************************************************************************
//
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use
''';

void generate(List<(String, String, String)> icons) {
  final library = LibraryBuilder()
    ..directives.addAll([Directive.import('package:flutter/widgets.dart')])
    ..body
    ..comments.addAll([header])
    ..body.addAll([
      (ClassBuilder()
            ..docs.addAll([
              '/// The Lucide icons bundled with Forui.',
              '/// ',
              '/// Use with the [Icon] class to show specific icons. Icons are identified by their name as listed below, e.g. ',
              '/// [FIcons.armchair].',
              '/// ',
              '/// Search and find the perfect icon on the [Lucide Icons](https://lucide.dev/icons/) website.',
            ])
            ..annotations.add(refer('staticIconProvider'))
            ..name = 'FIcons'
            ..fields.addAll([
              for (final icon in icons)
                (FieldBuilder()
                      ..docs.addAll(['/// [![`${icon.$2}`]($url/${icon.$2}.svg)](https://lucide.dev/icons/${icon.$2})'])
                      ..static = true
                      ..modifier = FieldModifier.constant
                      ..type
                      ..name = icon.$1
                      ..assignment = refer('IconData')
                          .newInstance(
                            [literalNum(int.parse(icon.$3))],
                            {
                              'fontFamily': literalString(family),
                              'fontPackage': literalString(package),
                              if (directional.contains(icon.$2)) 'matchTextDirection': literalTrue,
                            },
                          )
                          .code)
                    .build(),
            ])
            ..constructors.add(
              (ConstructorBuilder()
                    ..name = '_'
                    ..constant = true)
                  .build(),
            ))
          .build(),
    ]);

  final code = DartFormatter(
    pageWidth: 120,
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format(DartEmitter(orderDirectives: true, useNullSafetySyntax: true).visitLibrary(library.build()).toString());

  File('./lib/src/assets.g.dart').writeAsStringSync(code);
}
