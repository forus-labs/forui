// ignore_for_file: avoid_print, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'main.dart';

/// Quicky & dirty script that validates that all URLs in samples/output JSON files don't return 404.
///
/// Usage: dart run tool/link_validator.dart
Future<void> main() async {
  final out = Directory(output);
  final urls = <String>{};

  void extractUrls(Map<String, dynamic> snippet) {
    for (final link in snippet['links'] as List<dynamic>? ?? []) {
      if (link['url'] case final String url) {
        urls.add(url);
      }
    }
    if (snippet['container'] case {'url': final String url}) {
      urls.add(url);
    }
    for (final tooltip in snippet['tooltips'] as List<dynamic>? ?? []) {
      if (tooltip['snippet'] case final Map<String, dynamic> nested) {
        extractUrls(nested);
      }
    }
  }

  for (final file in out.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.json'))) {
    final content = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    extractUrls(content);
  }

  print('Found ${urls.length} unique URLs to validate...\n');

  final client = HttpClient();
  final broken = <String, int>{};
  var checked = 0;

  for (final url in urls) {
    final uri = Uri.parse(url);
    final request = await client.headUrl(uri);
    final response = await request.close();

    if (response.statusCode >= 400) {
      broken[url] = response.statusCode;
    }

    checked++;
    stdout.write('\rChecking $checked/${urls.length}...');
  }

  client.close();
  print('');

  if (broken.isNotEmpty) {
    print('\n✗ Found ${broken.length} broken URLs:\n');
    for (final MapEntry(key: link, value: status) in broken.entries) {
      print('  [$status] $link');
    }
    exit(1);
  }

  print('\n✓ All ${urls.length} URLs are valid.');
}
