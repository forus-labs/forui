import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
class ControlPartialMixin extends FunctionsMixin {
  /// The sealed parent class.
  final ClassElement supertype;

  /// Creates a new [ControlPartialMixin].
  ControlPartialMixin({required ClassElement type, required this.supertype}) : super(type);

  @override
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name}Mixin'
            ..types.addAll([for (final t in supertype.typeParameters) refer(t.name!)])
            ..on = refer('Diagnosticable, ${supertype.displayName}$_typeParameters')
            ..methods.addAll([...getters, if (fields.isNotEmpty) debugFillProperties, equals, hash]))
          .build();

  String get _typeParameters =>
      supertype.typeParameters.isEmpty ? '' : '<${supertype.typeParameters.map((t) => t.name).join(', ')}>';
}
