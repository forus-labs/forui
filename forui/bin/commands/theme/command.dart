import '../../args/command.dart';
import '../../configuration.dart';
import 'create_command.dart';
import 'ls_command.dart';
import 'theme.dart';

final registry = {for (final theme in Theme.values) theme.name: theme.source};

class ThemeCommand extends ForuiCommand {
  @override
  final name = 'theme';

  @override
  final aliases = ['t'];

  @override
  final description = 'Manage your Forui themes.';

  ThemeCommand(Configuration configuration) {
    addSubcommand(ThemeCreateCommand(configuration));
    addSubcommand(ThemeLsCommand());
  }
}
