import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:forui_internal_gen/forui_internal_gen.dart';
import 'package:test/test.dart';

const _source = r'''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

part 'sample.style.dart';

class FGoldenStyle with Diagnosticable, _$FGoldenStyleFunctions {
  /// This is a field's summary.
  ///
  /// This is more information about a field.
  final double someDouble;
  final Alignment alignment;
  final AlignmentGeometry alignmentGeometry;
  final BorderRadius borderRadius;
  final BorderRadiusGeometry borderRadiusGeometry;
  final BoxConstraints boxConstraints;
  final BoxDecoration boxDecoration;
  final Decoration decoration;
  final Color color;
  final EdgeInsets edgeInsets;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final IconThemeData iconThemeData;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadows;
  final List<Shadow> shadows;
  final FWidgetStateMap<BoxDecoration> boxDecorationMap;
  final FWidgetStateMap<BoxDecoration?> nullableBoxDecorationMap;
  final FWidgetStateMap<Color> colorMap;
  final FWidgetStateMap<Color?> nullableColorMap;
  final FWidgetStateMap<IconThemeData> iconThemeDataMap;
  final FWidgetStateMap<IconThemeData?> nullableIconThemeDataMap;
  final FWidgetStateMap<TextStyle> textStyleMap;
  final FWidgetStateMap<TextStyle?> nullableTextStyleMap;
  final FGoldenNestedStyle nestedStyle;
  final List<String> list;
  final Set<String> set;
  final Map<String, int> map;
  late final Color? _private;

  FGoldenStyle({
    required this.someDouble,
    required this.alignment,
    required this.alignmentGeometry,
    required this.borderRadius,
    required this.borderRadiusGeometry,
    required this.boxConstraints,
    required this.boxDecoration,
    required this.decoration,
    required this.color,
    required this.edgeInsets,
    required this.edgeInsetsDirectional,
    required this.edgeInsetsGeometry,
    required this.iconThemeData,
    required this.textStyle,
    required this.boxShadows,
    required this.shadows,
    required this.boxDecorationMap,
    required this.nullableBoxDecorationMap,
    required this.colorMap,
    required this.nullableColorMap,
    required this.iconThemeDataMap,
    required this.nullableIconThemeDataMap,
    required this.textStyleMap,
    required this.nullableTextStyleMap,
    required this.nestedStyle,
    required this.list,
    required this.set,
    required this.map,
  });
}

class FGoldenNestedStyle with Diagnosticable, _$FGoldenNestedStyleFunctions {}
''';

const _golden = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sample.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FGoldenStyleTransformations on FGoldenStyle {
  /// Returns a copy of this [FGoldenStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FGoldenStyle.someDouble] - This is a field's summary.
  /// * [FGoldenStyle.alignment]
  /// * [FGoldenStyle.alignmentGeometry]
  /// * [FGoldenStyle.borderRadius]
  /// * [FGoldenStyle.borderRadiusGeometry]
  /// * [FGoldenStyle.boxConstraints]
  /// * [FGoldenStyle.boxDecoration]
  /// * [FGoldenStyle.decoration]
  /// * [FGoldenStyle.color]
  /// * [FGoldenStyle.edgeInsets]
  /// * [FGoldenStyle.edgeInsetsDirectional]
  /// * [FGoldenStyle.edgeInsetsGeometry]
  /// * [FGoldenStyle.iconThemeData]
  /// * [FGoldenStyle.textStyle]
  /// * [FGoldenStyle.boxShadows]
  /// * [FGoldenStyle.shadows]
  /// * [FGoldenStyle.boxDecorationMap]
  /// * [FGoldenStyle.nullableBoxDecorationMap]
  /// * [FGoldenStyle.colorMap]
  /// * [FGoldenStyle.nullableColorMap]
  /// * [FGoldenStyle.iconThemeDataMap]
  /// * [FGoldenStyle.nullableIconThemeDataMap]
  /// * [FGoldenStyle.textStyleMap]
  /// * [FGoldenStyle.nullableTextStyleMap]
  /// * [FGoldenStyle.nestedStyle]
  /// * [FGoldenStyle.list]
  /// * [FGoldenStyle.set]
  /// * [FGoldenStyle.map]
  @useResult
  FGoldenStyle copyWith({
    double? someDouble,
    Alignment? alignment,
    AlignmentGeometry? alignmentGeometry,
    BorderRadius? borderRadius,
    BorderRadiusGeometry? borderRadiusGeometry,
    BoxConstraints? boxConstraints,
    BoxDecoration? boxDecoration,
    Decoration? decoration,
    Color? color,
    EdgeInsets? edgeInsets,
    EdgeInsetsDirectional? edgeInsetsDirectional,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    IconThemeData? iconThemeData,
    TextStyle? textStyle,
    List<BoxShadow>? boxShadows,
    List<Shadow>? shadows,
    FWidgetStateMap<BoxDecoration>? boxDecorationMap,
    FWidgetStateMap<BoxDecoration?>? nullableBoxDecorationMap,
    FWidgetStateMap<Color>? colorMap,
    FWidgetStateMap<Color?>? nullableColorMap,
    FWidgetStateMap<IconThemeData>? iconThemeDataMap,
    FWidgetStateMap<IconThemeData?>? nullableIconThemeDataMap,
    FWidgetStateMap<TextStyle>? textStyleMap,
    FWidgetStateMap<TextStyle?>? nullableTextStyleMap,
    FGoldenNestedStyle Function(FGoldenNestedStyle style)? nestedStyle,
    List<String>? list,
    Set<String>? set,
    Map<String, int>? map,
  }) => FGoldenStyle(
    someDouble: someDouble ?? this.someDouble,
    alignment: alignment ?? this.alignment,
    alignmentGeometry: alignmentGeometry ?? this.alignmentGeometry,
    borderRadius: borderRadius ?? this.borderRadius,
    borderRadiusGeometry: borderRadiusGeometry ?? this.borderRadiusGeometry,
    boxConstraints: boxConstraints ?? this.boxConstraints,
    boxDecoration: boxDecoration ?? this.boxDecoration,
    decoration: decoration ?? this.decoration,
    color: color ?? this.color,
    edgeInsets: edgeInsets ?? this.edgeInsets,
    edgeInsetsDirectional: edgeInsetsDirectional ?? this.edgeInsetsDirectional,
    edgeInsetsGeometry: edgeInsetsGeometry ?? this.edgeInsetsGeometry,
    iconThemeData: iconThemeData ?? this.iconThemeData,
    textStyle: textStyle ?? this.textStyle,
    boxShadows: boxShadows ?? this.boxShadows,
    shadows: shadows ?? this.shadows,
    boxDecorationMap: boxDecorationMap ?? this.boxDecorationMap,
    nullableBoxDecorationMap: nullableBoxDecorationMap ?? this.nullableBoxDecorationMap,
    colorMap: colorMap ?? this.colorMap,
    nullableColorMap: nullableColorMap ?? this.nullableColorMap,
    iconThemeDataMap: iconThemeDataMap ?? this.iconThemeDataMap,
    nullableIconThemeDataMap: nullableIconThemeDataMap ?? this.nullableIconThemeDataMap,
    textStyleMap: textStyleMap ?? this.textStyleMap,
    nullableTextStyleMap: nullableTextStyleMap ?? this.nullableTextStyleMap,
    nestedStyle: nestedStyle != null ? nestedStyle(this.nestedStyle) : this.nestedStyle,
    list: list ?? this.list,
    set: set ?? this.set,
    map: map ?? this.map,
  );

  /// Linearly interpolate between this and another [FGoldenStyle] using the given factor [t].
  @useResult
  FGoldenStyle lerp(FGoldenStyle other, double t) => FGoldenStyle(
    someDouble: lerpDouble(someDouble, other.someDouble, t) ?? someDouble,
    alignment: Alignment.lerp(alignment, other.alignment, t) ?? alignment,
    alignmentGeometry: AlignmentGeometry.lerp(alignmentGeometry, other.alignmentGeometry, t) ?? alignmentGeometry,
    borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    borderRadiusGeometry:
        BorderRadiusGeometry.lerp(borderRadiusGeometry, other.borderRadiusGeometry, t) ?? borderRadiusGeometry,
    boxConstraints: BoxConstraints.lerp(boxConstraints, other.boxConstraints, t) ?? boxConstraints,
    boxDecoration: BoxDecoration.lerp(boxDecoration, other.boxDecoration, t) ?? boxDecoration,
    decoration: Decoration.lerp(decoration, other.decoration, t) ?? decoration,
    color: Color.lerp(color, other.color, t) ?? color,
    edgeInsets: EdgeInsets.lerp(edgeInsets, other.edgeInsets, t) ?? edgeInsets,
    edgeInsetsDirectional:
        EdgeInsetsDirectional.lerp(edgeInsetsDirectional, other.edgeInsetsDirectional, t) ?? edgeInsetsDirectional,
    edgeInsetsGeometry: EdgeInsetsGeometry.lerp(edgeInsetsGeometry, other.edgeInsetsGeometry, t) ?? edgeInsetsGeometry,
    iconThemeData: IconThemeData.lerp(iconThemeData, other.iconThemeData, t),
    textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
    boxShadows: BoxShadow.lerpList(boxShadows, other.boxShadows, t) ?? boxShadows,
    shadows: Shadow.lerpList(shadows, other.shadows, t) ?? shadows,
    boxDecorationMap: FWidgetStateMap.lerpBoxDecoration(boxDecorationMap, other.boxDecorationMap, t),
    nullableBoxDecorationMap: FWidgetStateMap.lerpWhere(
      nullableBoxDecorationMap,
      other.nullableBoxDecorationMap,
      t,
      BoxDecoration.lerp,
    ),
    colorMap: FWidgetStateMap.lerpColor(colorMap, other.colorMap, t),
    nullableColorMap: FWidgetStateMap.lerpWhere(nullableColorMap, other.nullableColorMap, t, Color.lerp),
    iconThemeDataMap: FWidgetStateMap.lerpIconThemeData(iconThemeDataMap, other.iconThemeDataMap, t),
    nullableIconThemeDataMap: FWidgetStateMap.lerpWhere(
      nullableIconThemeDataMap,
      other.nullableIconThemeDataMap,
      t,
      IconThemeData.lerp,
    ),
    textStyleMap: FWidgetStateMap.lerpTextStyle(textStyleMap, other.textStyleMap, t),
    nullableTextStyleMap: FWidgetStateMap.lerpWhere(
      nullableTextStyleMap,
      other.nullableTextStyleMap,
      t,
      TextStyle.lerp,
    ),
    nestedStyle: nestedStyle.lerp(other.nestedStyle, t),
    list: t < 0.5 ? list : other.list,
    set: t < 0.5 ? set : other.set,
    map: t < 0.5 ? map : other.map,
  );
}

mixin _$FGoldenStyleFunctions on Diagnosticable {
  double get someDouble;
  Alignment get alignment;
  AlignmentGeometry get alignmentGeometry;
  BorderRadius get borderRadius;
  BorderRadiusGeometry get borderRadiusGeometry;
  BoxConstraints get boxConstraints;
  BoxDecoration get boxDecoration;
  Decoration get decoration;
  Color get color;
  EdgeInsets get edgeInsets;
  EdgeInsetsDirectional get edgeInsetsDirectional;
  EdgeInsetsGeometry get edgeInsetsGeometry;
  IconThemeData get iconThemeData;
  TextStyle get textStyle;
  List<BoxShadow> get boxShadows;
  List<Shadow> get shadows;
  FWidgetStateMap<BoxDecoration> get boxDecorationMap;
  FWidgetStateMap<BoxDecoration?> get nullableBoxDecorationMap;
  FWidgetStateMap<Color> get colorMap;
  FWidgetStateMap<Color?> get nullableColorMap;
  FWidgetStateMap<IconThemeData> get iconThemeDataMap;
  FWidgetStateMap<IconThemeData?> get nullableIconThemeDataMap;
  FWidgetStateMap<TextStyle> get textStyleMap;
  FWidgetStateMap<TextStyle?> get nullableTextStyleMap;
  FGoldenNestedStyle get nestedStyle;
  List<String> get list;
  Set<String> get set;
  Map<String, int> get map;

  /// Returns itself.
  ///
  /// Allows [FGoldenStyle] to replace functions that accept and return a [FGoldenStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FGoldenStyle Function(FGoldenStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FGoldenStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FGoldenStyle(...));
  /// ```
  @useResult
  FGoldenStyle call(Object? _) => this as FGoldenStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('someDouble', someDouble, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('alignment', alignment, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('alignmentGeometry', alignmentGeometry, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadiusGeometry', borderRadiusGeometry, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('boxConstraints', boxConstraints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('boxDecoration', boxDecoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(ColorProperty('color', color, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('edgeInsets', edgeInsets, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('edgeInsetsDirectional', edgeInsetsDirectional, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('edgeInsetsGeometry', edgeInsetsGeometry, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconThemeData', iconThemeData, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(IterableProperty('boxShadows', boxShadows, level: DiagnosticLevel.debug))
      ..add(IterableProperty('shadows', shadows, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('boxDecorationMap', boxDecorationMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('nullableBoxDecorationMap', nullableBoxDecorationMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('colorMap', colorMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('nullableColorMap', nullableColorMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconThemeDataMap', iconThemeDataMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('nullableIconThemeDataMap', nullableIconThemeDataMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyleMap', textStyleMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('nullableTextStyleMap', nullableTextStyleMap, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle, level: DiagnosticLevel.debug))
      ..add(IterableProperty('list', list, level: DiagnosticLevel.debug))
      ..add(IterableProperty('set', set, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('map', map, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FGoldenStyle &&
          someDouble == other.someDouble &&
          alignment == other.alignment &&
          alignmentGeometry == other.alignmentGeometry &&
          borderRadius == other.borderRadius &&
          borderRadiusGeometry == other.borderRadiusGeometry &&
          boxConstraints == other.boxConstraints &&
          boxDecoration == other.boxDecoration &&
          decoration == other.decoration &&
          color == other.color &&
          edgeInsets == other.edgeInsets &&
          edgeInsetsDirectional == other.edgeInsetsDirectional &&
          edgeInsetsGeometry == other.edgeInsetsGeometry &&
          iconThemeData == other.iconThemeData &&
          textStyle == other.textStyle &&
          listEquals(boxShadows, other.boxShadows) &&
          listEquals(shadows, other.shadows) &&
          boxDecorationMap == other.boxDecorationMap &&
          nullableBoxDecorationMap == other.nullableBoxDecorationMap &&
          colorMap == other.colorMap &&
          nullableColorMap == other.nullableColorMap &&
          iconThemeDataMap == other.iconThemeDataMap &&
          nullableIconThemeDataMap == other.nullableIconThemeDataMap &&
          textStyleMap == other.textStyleMap &&
          nullableTextStyleMap == other.nullableTextStyleMap &&
          nestedStyle == other.nestedStyle &&
          listEquals(list, other.list) &&
          setEquals(set, other.set) &&
          mapEquals(map, other.map));
  @override
  int get hashCode =>
      someDouble.hashCode ^
      alignment.hashCode ^
      alignmentGeometry.hashCode ^
      borderRadius.hashCode ^
      borderRadiusGeometry.hashCode ^
      boxConstraints.hashCode ^
      boxDecoration.hashCode ^
      decoration.hashCode ^
      color.hashCode ^
      edgeInsets.hashCode ^
      edgeInsetsDirectional.hashCode ^
      edgeInsetsGeometry.hashCode ^
      iconThemeData.hashCode ^
      textStyle.hashCode ^
      const ListEquality().hash(boxShadows) ^
      const ListEquality().hash(shadows) ^
      boxDecorationMap.hashCode ^
      nullableBoxDecorationMap.hashCode ^
      colorMap.hashCode ^
      nullableColorMap.hashCode ^
      iconThemeDataMap.hashCode ^
      nullableIconThemeDataMap.hashCode ^
      textStyleMap.hashCode ^
      nullableTextStyleMap.hashCode ^
      nestedStyle.hashCode ^
      const ListEquality().hash(list) ^
      const SetEquality().hash(set) ^
      const MapEquality().hash(map);
}

/// Provides [copyWith] and [lerp] methods.
extension $FGoldenNestedStyleTransformations on FGoldenNestedStyle {
  /// Returns a copy of this [FGoldenNestedStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  @useResult
  FGoldenNestedStyle copyWith() => FGoldenNestedStyle();

  /// Linearly interpolate between this and another [FGoldenNestedStyle] using the given factor [t].
  @useResult
  FGoldenNestedStyle lerp(FGoldenNestedStyle other, double t) => FGoldenNestedStyle();
}

mixin _$FGoldenNestedStyleFunctions on Diagnosticable {
  /// Returns itself.
  ///
  /// Allows [FGoldenNestedStyle] to replace functions that accept and return a [FGoldenNestedStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FGoldenNestedStyle Function(FGoldenNestedStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FGoldenNestedStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FGoldenNestedStyle(...));
  /// ```
  @useResult
  FGoldenNestedStyle call(Object? _) => this as FGoldenNestedStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || (other is FGoldenNestedStyle);
  @override
  int get hashCode => 0;
}
''';

void main() {
  test('style', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      styleBuilder(BuilderOptions.empty),
      {'forui_internal_gen|test/src/sample.dart': _source},
      outputs: {'forui_internal_gen|test/src/sample.style.dart': _golden},
      readerWriter: readerWriter,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
}
