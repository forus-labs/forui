import 'dart:io';

void main(List<String> args) {
  final currentPath = Directory.current.path;
  final [packageName, ...] = args;

  // Getting all the dart files for the project
  final files = dartFiles(currentPath)..remove('$currentPath/lib/generated_plugin_registrant.dart');

  // Sorting and writing to files
  for (final file in files.values) {
    final sortedFile = sortImports(file.readAsLinesSync(), packageName);
    file.writeAsStringSync(sortedFile);
  }

  stdout.write('Sorted files\n');
}

/// Get all the dart files for the project and the contents.
Map<String, File> dartFiles(String currentPath) {
  final dartFiles = <String, File>{};
  final allContents = [
    ..._readDir(currentPath, 'lib'),
    ..._readDir(currentPath, 'bin'),
    ..._readDir(currentPath, 'test'),
    ..._readDir(currentPath, 'tests'),
    ..._readDir(currentPath, 'test_driver'),
    ..._readDir(currentPath, 'integration_test'),
  ];

  for (final file in allContents.whereType<File>().where((file) => file.path.endsWith('.dart'))) {
    dartFiles[file.path] = file;
  }

  return dartFiles;
}

List<FileSystemEntity> _readDir(String currentPath, String name) {
  if (Directory('$currentPath/$name') case final directory when directory.existsSync()) {
    return directory.listSync(recursive: true);
  }
  return [];
}

/// Sort the imports.
String sortImports(List<String> lines, String packageName, {String? filePath}) {
  final beforeImportLines = <String>[];
  final afterImportLines = <String>[];

  final dartImports = <String>[];
  final flutterImports = <String>[];
  final packageImports = <String>[];
  final projectRelativeImports = <String>[];
  final projectImports = <String>[];

  bool noImports() =>
      dartImports.isEmpty &&
          flutterImports.isEmpty &&
          packageImports.isEmpty &&
          projectImports.isEmpty &&
          projectRelativeImports.isEmpty;

  var isMultiLineString = false;

  for (final line in lines) {
    // Check if line is in multiline string
    if (_timesContained(line, "'''") == 1 || _timesContained(line, '"""') == 1) {
      isMultiLineString = !isMultiLineString;
    }

    // If line is an import line
    if (line.startsWith('import ') && line.endsWith(';') && !isMultiLineString) {
      if (line.contains('dart:')) {
        dartImports.add(line);
      } else if (line.contains('package:flutter/')) {
        flutterImports.add(line);
      } else if (line.contains('package:$packageName/')) {
        projectImports.add(line);
      } else if (line.contains('package:')) {
        packageImports.add(line);
      } else {
        projectRelativeImports.add(line);
      }
    } else if (noImports()) {
      beforeImportLines.add(line);
    } else {
      afterImportLines.add(line);
    }
  }

  // If no imports return original string of lines
  if (noImports()) {
    var joinedLines = lines.join('\n');
    if (joinedLines.endsWith('\n') && !joinedLines.endsWith('\n\n')) {
      joinedLines += '\n';
    } else if (!joinedLines.endsWith('\n')) {
      joinedLines += '\n';
    }
    return joinedLines;
  }

  // Remove spaces
  if (beforeImportLines.isNotEmpty) {
    if (beforeImportLines.last.trim() == '') {
      beforeImportLines.removeLast();
    }
  }

  final sortedLines = [...beforeImportLines];

  // Adding content conditionally
  if (beforeImportLines.isNotEmpty) {
    sortedLines.add('');
  }
  if (dartImports.isNotEmpty) {
    dartImports.sort();
    sortedLines.addAll(dartImports);
  }
  if (flutterImports.isNotEmpty) {
    if (dartImports.isNotEmpty) sortedLines.add('');
    flutterImports.sort();
    sortedLines.addAll(flutterImports);
  }
  if (packageImports.isNotEmpty) {
    if (dartImports.isNotEmpty || flutterImports.isNotEmpty) {
      sortedLines.add('');
    }
    packageImports.sort();
    sortedLines.addAll(packageImports);
  }
  if (projectImports.isNotEmpty || projectRelativeImports.isNotEmpty) {
    if (dartImports.isNotEmpty || flutterImports.isNotEmpty || packageImports.isNotEmpty) {
      sortedLines.add('');
    }
    projectImports.sort();
    projectRelativeImports.sort();
    sortedLines.addAll(projectImports);
    sortedLines.addAll(projectRelativeImports);
  }

  sortedLines.add('');

  var addedCode = false;
  for (final line in afterImportLines) {
    if (line != '') {
      sortedLines.add(line);
      addedCode = true;
    }
    if (addedCode && line == '') {
      sortedLines.add(line);
    }
  }
  sortedLines.add('');

  final sortedFile = sortedLines.join('\n');

  return sortedFile;
}

/// Get the number of times a string contains another
/// string
int _timesContained(String string, String looking) => string.split(looking).length - 1;
