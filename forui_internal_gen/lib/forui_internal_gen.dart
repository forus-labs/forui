import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:forui_internal_gen/src/control_generator.dart';
import 'package:forui_internal_gen/src/design_generator.dart';
import 'package:source_gen/source_gen.dart';

const _controlHeader =
    '''
$defaultFileHeader

// dart format width=120
// coverage:ignore-file
// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: unrelated_type_equality_checks
''';

const _designHeader =
    '''
$defaultFileHeader

// dart format width=120
// coverage:ignore-file
''';

/// Builds generators for controller transformations.
Builder controlBuilder(BuilderOptions _) => PartBuilder(
  [ControlGenerator()],
  '.control.dart',
  header: _controlHeader,
  formatOutput: (generated, version) => DartFormatter(pageWidth: 120, languageVersion: version).format(generated),
);

/// Builds generators for design transformations.
Builder designBuilder(BuilderOptions _) => PartBuilder(
  [DesignGenerator()],
  '.design.dart',
  header: _designHeader,
  formatOutput: (generated, version) => DartFormatter(pageWidth: 120, languageVersion: version).format(generated),
);
