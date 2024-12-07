import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'package:forui_internal_lints/src/diagnosticable_styles.dart';
import 'package:forui_internal_lints/src/prefer_specific_diagnostics_properties.dart';
import 'package:forui_internal_lints/src/prefix_public_types.dart';

/// Creates a linter for Forui,
PluginBase createPlugin() => _ForuiLinter();

class _ForuiLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
        DiagnosticableStylesRule(),
        PreferSpecificDiagnosticsProperties(),
        PrefixPublicTypesRule(),
      ];
}
