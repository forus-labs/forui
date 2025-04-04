// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/command_runner.dart';

import 'args/command.dart';
import 'commands/style/command.dart';

Future<void> main(List<String> arguments) async {
  final runner = ForuiCommandRunner('forui', 'Manage your Forui development environment.');

  runner.argParser
    ..addFlag('color', help: 'Use terminal colors.', defaultsTo: _color())
    ..addFlag('no-input', help: 'Disable interactive prompts and assume default values.', negatable: false);

  runner.addCommand(StyleCommand());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(e);
    exit(127);
  }
}

bool _color() =>
    stdout.hasTerminal && !Platform.environment.containsKey('NO_COLOR') && Platform.environment['TERM'] != 'dumb';
