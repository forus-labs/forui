import '../../args/command.dart';
import 'create/command.dart';
import 'ls/command.dart';

class StyleCommand extends ForuiCommand {
  @override
  final name = 'style';

  @override
  final aliases = ['s'];

  @override
  final description = 'Manage your Forui widget styles.';

  StyleCommand() {
    addSubcommand(StyleCreateCommand());
    addSubcommand(StyleLsCommand());
  }
}
