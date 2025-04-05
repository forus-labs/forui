import '../../args/command.dart';
import 'create/command.dart';

class TypographyCommand extends ForuiCommand {
  @override
  final name = 'typography';

  @override
  final List<String> aliases = ['typo', 't'];

  @override
  final description = 'Manage your Forui typographies.';

  TypographyCommand() {
    addSubcommand(TypographyCreateCommand());
  }
}
