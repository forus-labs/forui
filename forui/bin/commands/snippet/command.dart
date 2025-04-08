import '../../args/command.dart';
import '../../configuration.dart';
import 'create_command.dart';
import 'ls_command.dart';

class SnippetCommand extends ForuiCommand {
  @override
  final name = 'snippet';

  @override
  final aliases = ['sn'];

  @override
  final description = 'Manage your code snippets.';

  SnippetCommand(Configuration configuration) {
    addSubcommand(SnippetCreateCommand(configuration));
    addSubcommand(SnippetLsCommand());
  }
}
