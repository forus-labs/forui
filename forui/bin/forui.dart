// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/command_runner.dart';

import 'args/command.dart';
import 'commands/color/command.dart';
import 'commands/init/command.dart';
import 'commands/style/command.dart';
import 'commands/typography/command.dart';
import 'configuration.dart';

Future<void> main(List<String> arguments) async {
  configure();

  final runner =
      ForuiCommandRunner('forui', 'Manage your Forui development environment.')
        ..addCommand(ColorCommand())
        ..addCommand(InitCommand())
        ..addCommand(StyleCommand())
        ..addCommand(TypographyCommand());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(e);
    exit(127);
  }
}
