import 'package:args/command_runner.dart';

import 'create/command.dart';

class StyleCommand extends Command {
  @override
  final name = 'style';

  @override
  final description = 'Manage your Forui widget styles.';

  StyleCommand() {
    addSubcommand(StyleCreateCommand());
  }
}
