import 'dart:io';

import 'package:yaml/yaml.dart';

late final Directory root;
String defaultThemeOutput = 'lib/theme/theme.dart';
String defaultStyleOutput = 'lib/theme';

void configure() {
  try {
    root = _findProjectRoot();
    _configure();
  } on FormatException catch (e) {
    stdout.writeln(e.message);
    exit(2);
  }
}

Directory _findProjectRoot([Directory? directory]) {
  directory ??= Directory.current;

  final pubspec = File('${directory.path}/pubspec.yaml');
  if (pubspec.existsSync()) {
    return directory;
  }

  final parent = directory.parent;
  if (parent.path == directory.path) {
    throw const FormatException(
      'Could not find a Flutter project directory. Make sure you are running this inside a Flutter project.',
    );
  }

  return _findProjectRoot(parent);
}

void _configure() {
  var configuration = File('${root.path}/forui.yaml');
  var extension = 'yaml';

  if (!configuration.existsSync()) {
    configuration = File('${root.path}/forui.yml');
    extension = 'yml';

    if (!configuration.existsSync()) {
      return;
    }
  }

  final yaml = loadYamlNode(configuration.readAsStringSync());
  if (yaml is! YamlMap) {
    return;
  }

  final cli = yaml.nodes['cli'];
  if (cli is! YamlMap) {
    return;
  }

  switch (cli.nodes['theme-output']) {
    case null:
      break;

    case YamlScalar(:final value) when value is String:
      defaultThemeOutput = value;

    case final node:
      throw FormatException(
        'Could not read forui.$extension.\n\n${node.span.message('"theme-output" must be a string.')}',
      );
  }

  switch (cli.nodes['style-output']) {
    case null:
      break;

    case YamlScalar(:final value) when value is String:
      defaultStyleOutput = value;

    case final node:
      throw FormatException(
        'Could not read forui.$extension.\n\n${node.span.message('"style-output" must be a string.')}',
      );
  }
}
