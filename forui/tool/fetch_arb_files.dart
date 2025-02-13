// ignore_for_file: avoid_dynamic_calls, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

final pattern = RegExp(r'(widgets|material)_([\w_]+)\.arb');

/// Fetches the languages that Flutter supports natively. We try to maintain parity with that.
Future<void> main() async {
  final url = Uri.https(
    'api.github.com',
    '/repos/flutter/flutter/contents/packages/flutter_localizations/lib/src/l10n',
  );
  final response = await http.get(url);

  if (response.statusCode != 200) {
    print("Failed to fetch ARB files from Flutter's GitHub repository: ${response.statusCode}");
    return;
  }

  (json.decode(response.body) as List<dynamic>)
      .map((file) => file['name'] as String)
      .map((file) => pattern.firstMatch(file)?.group(2))
      .nonNulls
      .map((locale) => File('lib/l10n/f_$locale.arb'))
      .where((arb) => !arb.existsSync())
      .forEach((arb) {
        print('${arb.path} does not exist. Creating...');
        arb.writeAsString('{}');
      });
}
