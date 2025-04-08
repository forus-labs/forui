import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:path/path.dart' as p;
import 'package:sugar/sugar.dart';

import 'main.dart';

String generateSnippets() {
  final directory = p.join(Directory.current.parent.path, 'forui', 'tool', 'cli_generator', 'snippets');
  final snippets = {
    for (final file in Directory(directory).listSync(recursive: true).whereType<File>())
      p.basenameWithoutExtension(file.path).toSnakeCase(): file.readAsStringSync(),
  };

  final sources = [for (final MapEntry(:key, value: source) in snippets.entries) "'$key': r'''$source'''"];

  final library =
      LibraryBuilder()
        ..comments.addAll([header])
        ..body.addAll([
          (FieldBuilder()
                ..docs.addAll(['/// All snippets. Generated by tool/cli_generator.'])
                ..name = 'snippets'
                ..modifier = FieldModifier.constant
                ..assignment = Code('{\n  ${sources.join(',\n  ')}\n}'))
              .build(),
        ]);

  return formatter.format(library.build().accept(emitter).toString());
}
