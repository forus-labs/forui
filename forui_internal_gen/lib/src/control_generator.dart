import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:collection/collection.dart';
import 'package:forui_internal_gen/src/source/control_internal_extension.dart';
import 'package:forui_internal_gen/src/source/control_mixin.dart';
import 'package:forui_internal_gen/src/source/control_parent_mixin.dart';
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
      final create = supertype.methods.firstWhereOrNull((m) => m.name == '_create');
      final update = supertype.methods.firstWhereOrNull((m) => m.name == '_update');
      final dispose = supertype.methods.firstWhereOrNull((m) => m.name == '_dispose');

      if (update == null) {
        continue;
      }

      final parentMixin = ControlParentMixin(supertype: supertype, create: create, update: update, dispose: dispose);
      final createMethod = parentMixin.createMethod;
      final disposeMethod = parentMixin.disposeMethod;
      final defaultMethod = parentMixin.defaultMethod;

      generated
        ..add(
          _emitter
              .visitExtension(
                ControlInternalExtension(
                  supertype: supertype,
                  update: update,
                  dispose: disposeMethod,
                  create: createMethod,
                ).generate(),
              )
              .toString(),
        )
        ..add(_emitter.visitMixin(parentMixin.generate()).toString())
        ..addAll([
          for (final type in subtypes)
            _emitter
                .visitMixin(
                  ControlMixin(
                    element: type,
                    supertype: supertype,
                    update: update,
                    create: createMethod,
                    dispose: disposeMethod,
                    default_: defaultMethod,
                    siblings: subtypes.whereNot((t) => t == type).toList(),
                  ).generate(),
                )
                .toString(),
        ]);
    }

    return generated.join('\n');
  }
}
