// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/style/command.dart';

Future<void> main(List<String> arguments) async {
  final runner = CommandRunner('forui', 'Manage your Forui development environment.');

  runner.argParser
    ..addFlag('color', help: 'Use terminal colors.', defaultsTo: _color())
    ..addFlag('no-input', help: 'Disable interactive prompts and assume default values.', negatable: false);

  runner.addCommand(StyleCommand());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(e);
    exit(127);
  }
}

bool _color() =>
    stdout.hasTerminal && !Platform.environment.containsKey('NO_COLOR') && Platform.environment['TERM'] != 'dumb';

/// print('\x1B[31mThis is red text\x1B[0m');
//   if (arguments.isEmpty || arguments.length < 2 || arguments[0] != 'style') {
//     printUsage();
//     exit(1);
//   }
//
//   Registry.values.asNameMap();
//
//   final styleName = arguments[1].toLowerCase();
//   final style = findStyle(styleName);
//
//   if (style != null) {
//     final file =
//         File('./lib/styles/$styleName.dart')
//           ..createSync(recursive: true)
//           ..writeAsStringSync("import 'package:forui/forui.dart';\nimport 'package:flutter/widgets.dart';\n\n");
//
//     for (final something in style.closure) {
//       final style = Registry.values.firstWhere((s) => s.name.toLowerCase() == something.toLowerCase());
//       final source =
//           something.toLowerCase() == styleName
//               ? style.source
//               : '${style.source.substring(0, style.position)}_${style.source.substring(style.position)}';
//
//       file.writeAsStringSync('$source\n', mode: FileMode.append);
//     }
//   } else {
//     print('Style "$styleName" not found in registry.');
//     printAvailableStyles();
//     exit(1);
//   }

// void printUsage() {
//   print('Usage: dart run forui style <name>');
//   print('Example: dart run forui style fButtonStyle');
// }
//
// void printAvailableStyles() {
//   print('\nAvailable styles:');
//   for (final style in Registry.values) {
//     print('  - ${style.name}');
//   }
// }
//
// Registry? findStyle(String styleName) {
//   try {
//     // Try to find an exact match first
//     final style = Registry.values.firstWhere((s) => s.name.toLowerCase() == styleName);
//
//     return style;
//   } catch (_) {
//     // Then try to find a partial match
//     try {
//       final style = Registry.values.firstWhere((s) => s.name.toLowerCase().contains(styleName));
//       return style;
//     } catch (_) {
//       return null;
//     }
//   }
// }
