import 'dart:io';
import 'registry.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.length < 2 || arguments[0] != 'style') {
    printUsage();
    exit(1);
  }

  final styleName = arguments[1].toLowerCase();
  final style = findStyle(styleName);

  if (style != null) {
    final file =
        File('./lib/styles/$styleName.dart')
          ..createSync(recursive: true)
          ..writeAsStringSync("import 'package:forui/forui.dart';\nimport 'package:flutter/widgets.dart';\n\n");

    for (final something in style.closure) {
      final style = Registry.values.firstWhere((s) => s.name.toLowerCase() == something.toLowerCase());
      final source =
          something.toLowerCase() == styleName
              ? style.source
              : '${style.source.substring(0, style.position)}_${style.source.substring(style.position)}';

      file.writeAsStringSync('$source\n', mode: FileMode.append);
    }
  } else {
    print('Style "$styleName" not found in registry.');
    printAvailableStyles();
    exit(1);
  }
}

void printUsage() {
  print('Usage: dart run forui style <name>');
  print('Example: dart run forui style fButtonStyle');
}

void printAvailableStyles() {
  print('\nAvailable styles:');
  for (final style in Registry.values) {
    print('  - ${style.name}');
  }
}

Registry? findStyle(String styleName) {
  try {
    // Try to find an exact match first
    final style = Registry.values.firstWhere((s) => s.name.toLowerCase() == styleName);

    return style;
  } catch (_) {
    // Then try to find a partial match
    try {
      final style = Registry.values.firstWhere((s) => s.name.toLowerCase().contains(styleName));
      return style;
    } catch (_) {
      return null;
    }
  }
}
