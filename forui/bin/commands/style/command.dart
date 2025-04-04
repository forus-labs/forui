import '../../args/command.dart';
import 'create/command.dart';
import 'list/command.dart';

class StyleCommand extends ForuiCommand {
  @override
  final name = 'style';

  @override
  final List<String> aliases = ['s'];

  @override
  final description = 'Manage your Forui widget styles.';

  StyleCommand() {
    addSubcommand(StyleCreateCommand());
    addSubcommand(StyleLsCommand());
  }
}
