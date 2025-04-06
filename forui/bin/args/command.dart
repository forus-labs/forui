import 'dart:collection';
import 'dart:math' as math;

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'utils.dart';

// The majority of this file is copied from the args package.
// We did so as they didn't support the printing of args in the usage message.

mixin _Usage {
  Never usageException(String message) => throw UsageException(_wrap(message), _usageWithoutDescription);

  String get usage => _wrap('$description\n\n') + _usageWithoutDescription;

  String _wrap(String text, {int? hangingIndent}) =>
      wrapText(text, length: argParser.usageLineLength, hangingIndent: hangingIndent);

  String get _usageWithoutDescription;

  String get description;

  ArgParser get argParser;
}

/// A runner that additionally supports:
/// * Usage information with aliases
class ForuiCommandRunner<T> extends CommandRunner<T> with _Usage {
  ForuiCommandRunner(super.executableName, super.description);

  @override
  String get _usageWithoutDescription {
    const usagePrefix = 'Usage:';
    final buffer =
        StringBuffer()
          ..writeln('$usagePrefix ${_wrap(invocation, hangingIndent: usagePrefix.length)}\n')
          ..writeln(_wrap('Global options:'))
          ..writeln('${argParser.usage}\n')
          ..writeln('${_getCommandUsage(commands, lineLength: argParser.usageLineLength)}\n')
          ..write(_wrap('Run "$executableName help <command>" for more information about a command.'));

    if (usageFooter != null) {
      buffer.write('\n${_wrap(usageFooter!)}');
    }
    return buffer.toString();
  }
}

/// A command that additionally supports:
/// * Custom invocation arguments
/// * Usage information with aliases
abstract class ForuiCommand extends Command with _Usage {
  @override
  String get invocation {
    final parents = [name];
    for (var command = parent; command != null; command = command.parent) {
      parents.add(command.name);
    }
    parents.add(runner!.executableName);

    final invocation = parents.reversed.join(' ');
    return (subcommands.isNotEmpty ? '$invocation <subcommand> $arguments' : '$invocation $arguments').trim();
  }

  String get arguments => '[arguments]';

  @override
  String get _usageWithoutDescription {
    final length = argParser.usageLineLength;
    const usagePrefix = 'Usage: ';
    final buffer =
        StringBuffer()
          ..writeln(usagePrefix + _wrap(invocation, hangingIndent: usagePrefix.length))
          ..writeln(argParser.usage);

    if (subcommands.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln(_getCommandUsage(subcommands, isSubcommand: true, lineLength: length));
    }

    buffer
      ..writeln()
      ..write(_wrap('Run "${runner!.executableName} help" to see global options.'));

    if (usageFooter != null) {
      buffer
        ..writeln()
        ..write(_wrap(usageFooter!));
    }

    return buffer.toString();
  }
}

String _getCommandUsage(Map<String, Command> commands, {bool isSubcommand = false, int? lineLength}) {
  // Don't include aliases.
  var names = commands.keys.where((name) => !commands[name]!.aliases.contains(name));

  // Filter out hidden ones, unless they are all hidden.
  final visible = names.where((name) => !commands[name]!.hidden);
  if (visible.isNotEmpty) {
    names = visible;
  }

  // Show the commands alphabetically.
  names = names.toList()..sort();

  // Group the commands by category.
  final commandsByCategory = SplayTreeMap<String, List<Command>>();
  for (final name in names) {
    final category = commands[name]!.category;
    commandsByCategory.putIfAbsent(category, () => []).add(commands[name]!);
  }
  final categories = commandsByCategory.keys.toList();

  final length = names.map((name) => [name, ...commands[name]!.aliases].join(', ').length).reduce(math.max);

  final buffer = StringBuffer('Available ${isSubcommand ? "sub" : ""}commands:');
  final columnStart = length + 5;
  for (final category in categories) {
    if (category != '') {
      buffer
        ..writeln()
        ..writeln()
        ..write(category);
    }
    for (final command in commandsByCategory[category]!) {
      final lines = wrapTextAsLines(command.summary, start: columnStart, length: lineLength);
      buffer
        ..writeln()
        ..write('  ${padRight([command.name, ...command.aliases].join(', '), length)}   ${lines.first}');

      for (final line in lines.skip(1)) {
        buffer
          ..writeln()
          ..write(' ' * columnStart)
          ..write(line);
      }
    }
  }

  return buffer.toString();
}
