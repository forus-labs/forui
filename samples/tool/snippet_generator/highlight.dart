import 'main.dart';

// Nested highlighting isn't supported. That's just silly.
void transformHighlights(Sample sample) {
  final lines = <String>[];
  int? start;
  var lineNumber = 0;

  for (final line in sample.source.split('\n')) {
    final trimmed = line.trim();

    if (trimmed == '// {@highlight}') {
      start = lineNumber + 1;
      continue;
    }

    if (trimmed == '// {@endhighlight}') {
      sample.highlights.add((start!, lineNumber));
      start = null;
      continue;
    }

    lines.add(line);
    lineNumber++;
  }

  sample.source = lines.join('\n');
}
