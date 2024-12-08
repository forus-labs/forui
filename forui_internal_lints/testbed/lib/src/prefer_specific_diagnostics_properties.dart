import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final valid = DiagnosticsProperty('valid', Object());

// expect_lint: prefer_specific_diagnostics_properties
final bool = DiagnosticsProperty('bool', true);

// expect_lint: prefer_specific_diagnostics_properties
final double = DiagnosticsProperty('double', 10.0);

// expect_lint: prefer_specific_diagnostics_properties
final iconData = DiagnosticsProperty('IconData', Icons.ac_unit);

// expect_lint: prefer_specific_diagnostics_properties
final int = DiagnosticsProperty('int', 42);

// expect_lint: prefer_specific_diagnostics_properties
final string = DiagnosticsProperty('string', 'value');

// expect_lint: prefer_specific_diagnostics_properties
final color = DiagnosticsProperty('Color', const Color(0xFF000000));

// expect_lint: prefer_specific_diagnostics_properties
final cupertinoColor = DiagnosticsProperty('CupertinoColor', CupertinoColors.systemRed);

// expect_lint: prefer_specific_diagnostics_properties
final iterable = DiagnosticsProperty('Iterable', [1, 2, 3]);

// expect_lint: prefer_specific_diagnostics_properties
final enumValue = DiagnosticsProperty('Enum', WidgetState.hovered);

// expect_lint: prefer_specific_diagnostics_properties
final function = DiagnosticsProperty('Function', () => print('Hello'));
