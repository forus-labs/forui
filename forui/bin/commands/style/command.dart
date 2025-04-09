import '../../args/command.dart';
import '../../configuration.dart';
import 'create/command.dart';
import 'ls_command.dart';

class StyleCommand extends ForuiCommand {
  @override
  final name = 'style';

  @override
  final aliases = ['st'];

  @override
  final description = 'Manage your Forui widget styles.';

  StyleCommand(Configuration configuration) {
    addSubcommand(StyleCreateCommand(configuration));
    addSubcommand(StyleLsCommand());
  }
}
