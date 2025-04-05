import '../../args/command.dart';
import 'create/command.dart';
import 'ls/command.dart';

class ColorCommand extends ForuiCommand {
  @override
  final name = 'color';

  @override
  final List<String> aliases = ['c'];

  @override
  final description = 'Manage your Forui color schemes.';

  ColorCommand() {
    addSubcommand(ColorCreateCommand());
    addSubcommand(ColorLsCommand());
  }
}
