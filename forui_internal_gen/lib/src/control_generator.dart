import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:collection/collection.dart';
import 'package:forui_internal_gen/src/source/control_functions_mixin.dart';
import 'package:source_gen/source_gen.dart';

final _control = RegExp(r'^F.*(Control)$');

/// Generates corresponding style/motion mixins and extensions that implement several commonly used operations.
class ControlGenerator extends Generator {
  final _emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

  @override
  Future<String?> generate(LibraryReader library, BuildStep step) async {
    final generated = <String>[];
    final types = <ClassElement, List<ClassElement>>{};

    for (final type in library.classes) {
      if (type.allSupertypes
              .firstWhereOrNull((t) => t.element.name != null && _control.hasMatch(t.element.name!))
              ?.element
          case final ClassElement supertype?) {
        (types[supertype] ??= []).add(type);
      }
    }

    for (final MapEntry(key: supertype, value: subtypes) in types.entries) {
      // Find _update method in the sealed class.
      final update = supertype.methods.firstWhereOrNull((m) => m.name == '_update');

      generated.addAll([
        for (final type in subtypes)
          _emitter
              .visitMixin(
                ControlFunctionsMixin(
                  element: type,
                  supertype: supertype,
                  update: update,
                  siblings: subtypes,
                ).generate(),
              )
              .toString(),
      ]);
    }

    return generated.join('\n');
  }
}
