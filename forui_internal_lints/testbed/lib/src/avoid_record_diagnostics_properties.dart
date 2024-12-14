import 'package:flutter/foundation.dart';

final good = DiagnosticsProperty('good', Object());

// expect_lint: avoid_record_diagnostics_properties
final badDiagnostics = DiagnosticsProperty('bad', (1, 2));

// expect_lint: avoid_record_diagnostics_properties
final badFlag = ObjectFlagProperty('bad', (1, 2));

// expect_lint: avoid_record_diagnostics_properties
final badFlagHas = ObjectFlagProperty.has('bad', (1, ));