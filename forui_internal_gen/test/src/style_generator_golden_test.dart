import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:forui_internal_gen/forui_internal_gen.dart';
import 'package:test/test.dart';

const _source = r'''
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

part 'sample.style.dart';

class FGoldenStyle with _$FGoldenStyleFunctions {
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
  FGoldenNestedStyle nestedStyle;

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
  });
}

class FGoldenNestedStyle with _$FGoldenNestedStyleFunctions {}
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
extension $FGoldenStyleNonVirtual on FGoldenStyle {
  /// Returns a copy of this [FGoldenStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/themes#customization).
  ///
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
    FGoldenNestedStyle Function(FGoldenNestedStyle)? nestedStyle,
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
  );
}

/// Provides [copyWith] and [lerp] methods.
extension $FGoldenNestedStyleNonVirtual on FGoldenNestedStyle {
  /// Returns a copy of this [FGoldenNestedStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/themes#customization).
  ///
  @useResult
  FGoldenNestedStyle copyWith() => FGoldenNestedStyle();

  /// Linearly interpolate between this and another [FGoldenNestedStyle] using the given factor [t].
  @useResult
  FGoldenNestedStyle lerp(FGoldenNestedStyle other, double t) => FGoldenNestedStyle();
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
      ..add(DoubleProperty('someDouble', someDouble))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('alignmentGeometry', alignmentGeometry))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('borderRadiusGeometry', borderRadiusGeometry))
      ..add(DiagnosticsProperty('boxConstraints', boxConstraints))
      ..add(DiagnosticsProperty('boxDecoration', boxDecoration))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty('edgeInsets', edgeInsets))
      ..add(DiagnosticsProperty('edgeInsetsDirectional', edgeInsetsDirectional))
      ..add(DiagnosticsProperty('edgeInsetsGeometry', edgeInsetsGeometry))
      ..add(DiagnosticsProperty('iconThemeData', iconThemeData))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(IterableProperty('boxShadows', boxShadows))
      ..add(IterableProperty('shadows', shadows))
      ..add(DiagnosticsProperty('boxDecorationMap', boxDecorationMap))
      ..add(DiagnosticsProperty('nullableBoxDecorationMap', nullableBoxDecorationMap))
      ..add(DiagnosticsProperty('colorMap', colorMap))
      ..add(DiagnosticsProperty('nullableColorMap', nullableColorMap))
      ..add(DiagnosticsProperty('iconThemeDataMap', iconThemeDataMap))
      ..add(DiagnosticsProperty('nullableIconThemeDataMap', nullableIconThemeDataMap))
      ..add(DiagnosticsProperty('textStyleMap', textStyleMap))
      ..add(DiagnosticsProperty('nullableTextStyleMap', nullableTextStyleMap))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle));
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
          nestedStyle == other.nestedStyle);
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
      nestedStyle.hashCode;
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
  test('StyleGenerator', () async {
    final readerWriter = TestReaderWriter(rootPackage: 'forui_internal_gen');
    await readerWriter.testing.loadIsolateSources();

    await testBuilder(
      styleBuilder(BuilderOptions.empty),
      {'forui_internal_gen|test/src/sample.dart': _source},
      outputs: {
        'forui_internal_gen|test/src/sample.style.dart': _golden,
      },
      readerWriter: readerWriter,
    );
  });
}
