import 'package:analyzer/dart/element/element2.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

// ignore_for_file: public_member_api_docs

const boolType = TypeChecker.typeNamed(bool, inSdk: true);
const intType = TypeChecker.typeNamed(int, inSdk: true);
const doubleType = TypeChecker.typeNamed(double, inSdk: true);
const string = TypeChecker.typeNamed(String, inSdk: true);
const enumeration = TypeChecker.typeNamed(Enum, inSdk: true);

const iterable = TypeChecker.typeNamed(Iterable, inSdk: true);
const list = TypeChecker.typeNamed(List, inSdk: true);
const set = TypeChecker.typeNamed(Set, inSdk: true);
const map = TypeChecker.typeNamed(Map, inSdk: true);

const color = TypeChecker.fromUrl('dart:ui#Color');

const alignment = TypeChecker.fromUrl('package:flutter/src/painting/alignment.dart#Alignment');
const alignmentGeometry = TypeChecker.fromUrl('package:flutter/src/painting/alignment.dart#AlignmentGeometry');
const borderRadius = TypeChecker.fromUrl('package:flutter/src/painting/border_radius.dart#BorderRadius');
const borderRadiusGeometry = TypeChecker.fromUrl(
  'package:flutter/src/painting/border_radius.dart#BorderRadiusGeometry',
);
const boxConstraints = TypeChecker.fromUrl('package:flutter/src/rendering/box.dart#BoxConstraints');
const boxDecoration = TypeChecker.fromUrl('package:flutter/src/painting/box_decoration.dart#BoxDecoration');
const decoration = TypeChecker.fromUrl('package:flutter/src/painting/decoration.dart#Decoration');
const edgeInsets = TypeChecker.fromUrl('package:flutter/src/painting/edge_insets.dart#EdgeInsets');
const edgeInsetsDirectional = TypeChecker.fromUrl(
  'package:flutter/src/painting/edge_insets.dart#EdgeInsetsDirectional',
);
const edgeInsetsGeometry = TypeChecker.fromUrl('package:flutter/src/painting/edge_insets.dart#EdgeInsetsGeometry');
const iconData = TypeChecker.fromUrl('package:flutter/src/widgets/icon_theme.dart#IconData');
const iconThemeData = TypeChecker.fromUrl('package:flutter/src/widgets/icon_theme_data.dart#IconThemeData');
const textStyle = TypeChecker.fromUrl('package:flutter/src/painting/text_style.dart#TextStyle');
const boxShadow = TypeChecker.fromUrl('package:flutter/src/painting/box_shadow.dart#BoxShadow');
const shadow = TypeChecker.fromUrl('dart:ui#Shadow');

const fWidgetStateMap = TypeChecker.fromUrl('package:forui/src/theme/widget_state_map.dart#FWidgetStateMap');

/// Returns the instance fields for the given [element].
List<FieldElement2> instanceFields(ClassElement2 element) {
  final fields = <FieldElement2>[];

  void addFieldsFromType(ClassElement2 element) {
    fields.addAll(
      element.fields2.where(
        (f) =>
            !(f.getter2?.isAbstract ?? false) &&
            !f.isStatic &&
            f.isPublic &&
            f.name3 != 'runtimeType' &&
            f.name3 != 'hashCode',
      ),
    );

    if (element.supertype?.element3 case final ClassElement2 supertype) {
      addFieldsFromType(supertype);
    }
  }

  addFieldsFromType(element);

  // Remove duplicates (in case a field is overridden)
  return fields.toSet().toList();
}
