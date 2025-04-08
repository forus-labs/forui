import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:yaml/yaml.dart';

const defaults = '''
cli:
  # The default file or directory to output generated snippets.
  snippet-output: ${Configuration.defaultSnippet}

  # The default file or directory to output generated widget styles.
  style-output: ${Configuration.defaultStyle}
  
  # The default file or directory to output generated themes.
  theme-output: ${Configuration.defaultTheme}
''';

final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

class Configuration {
  static const defaultSnippet = 'lib';
  static const defaultStyle = 'lib/theme';
  static const defaultTheme = 'lib/theme/theme.dart';

  static Directory _findProjectRoot([Directory? directory]) {
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

  final Directory root;
  final String snippet;
  final String style;
  final String theme;

  factory Configuration.parse() {
    try {
      final root = _findProjectRoot();
      var configuration = File('${root.path}/forui.yaml');
      var extension = 'yaml';

      if (!configuration.existsSync()) {
        configuration = File('${root.path}/forui.yml');
        extension = 'yml';

        if (!configuration.existsSync()) {
          return Configuration(root: root);
        }
      }

      final yaml = loadYamlNode(configuration.readAsStringSync());
      if (yaml is! YamlMap) {
        return Configuration(root: root);
      }

      final cli = yaml.nodes['cli'];
      if (cli is! YamlMap) {
        return Configuration(root: root);
      }

      return Configuration(
        root: root,
        snippet: switch (cli.nodes['snippet-output']) {
          null => defaultSnippet,
          YamlScalar(:final value) when value is String => value,
          final node =>
            throw FormatException(
              'Could not read forui.$extension.\n\n${node.span.message('"snippet-output" must be a string.')}',
            ),
        },
        style: switch (cli.nodes['style-output']) {
          null => defaultStyle,
          YamlScalar(:final value) when value is String => value,
          final node =>
            throw FormatException(
              'Could not read forui.$extension.\n\n${node.span.message('"style-output" must be a string.')}',
            ),
        },
        theme: switch (cli.nodes['theme-output']) {
          null => defaultTheme,
          YamlScalar(:final value) when value is String => value,
          final node =>
            throw FormatException(
              'Could not read forui.$extension.\n\n${node.span.message('"theme-output" must be a string.')}',
            ),
        },
      );
    } on FormatException catch (e) {
      stdout.writeln(e.message);
      exit(2);
    }
  }

  Configuration({
    required this.root,
    this.snippet = defaultSnippet,
    this.style = defaultStyle,
    this.theme = defaultTheme,
  });
}
