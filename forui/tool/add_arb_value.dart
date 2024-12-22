// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

final pattern = RegExp(r'material_([\w_]+)\.arb');

// Change this to add other keys.
const key = 'invalidDateFormatLabel';

void main() {
  // I usually just download all Material localization files into the .temp folder.
  for (final source in Directory('.temp').listSync().whereType<File>()) {
    final material = json.decode(source.readAsStringSync());
    if (!material.containsKey(key)) {
      continue;
    }

    final locale = pattern.firstMatch(source.path)?.group(1);
    if (locale == 'en') {
      continue;
    }

    final target = File('lib/l10n/f_$locale.arb');

    final forui = json.decode(target.readAsStringSync());
    forui[key] = material[key];

    target.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(forui));
  }
}
