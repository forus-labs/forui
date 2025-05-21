import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:forui_internal_gen/src/style_generator.dart';
import 'package:source_gen/source_gen.dart';

const _header =
    '''
$defaultFileHeader

// dart format width=120
// coverage:ignore-file
''';

/// Builds generators for `build_runner` to run
Builder styleBuilder(BuilderOptions options) => PartBuilder(
  [StyleGenerator()],
  '.style.dart',
  header: _header,
  formatOutput: (generated, version) => DartFormatter(pageWidth: 120, languageVersion: version).format(generated),
);
