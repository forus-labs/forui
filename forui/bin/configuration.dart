import 'dart:io';

late final Directory root;
late String defaultDirectory;

void configure() {
  try {
    root = _findProjectRoot();
    defaultDirectory = '${root.path}${Platform.pathSeparator}lib${Platform.pathSeparator}theme';

  } on Exception catch (e) {
    stdout.writeln(e);
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
    throw Exception(
      'Could not find a Flutter project directory. Make sure you are running this inside a Flutter project.',
    );
  }

  // Recursively check parent directories
  return _findProjectRoot(parent);
}
