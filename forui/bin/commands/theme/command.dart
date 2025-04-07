import '../../args/command.dart';
import 'create/command.dart';
import 'ls/command.dart';

import 'theme.dart';

final registry = {for (final theme in Theme.values) theme.name: theme.source};

class ThemeCommand extends ForuiCommand {
  @override
  final name = 'theme';

  @override
  final aliases = ['t'];

  @override
  final description = 'Manage your Forui themes.';

  ThemeCommand() {
    addSubcommand(ThemeCreateCommand());
    addSubcommand(ThemeLsCommand());
  }
}
