import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:forui_internal_lints/src/always_call_super_dispose_last.dart';
import 'package:forui_internal_lints/src/always_provide_flag_property_parameter.dart';
import 'package:forui_internal_lints/src/avoid_record_diagnostics_properties.dart';

import 'package:forui_internal_lints/src/style_api.dart';
import 'package:forui_internal_lints/src/prefer_specific_diagnostics_properties.dart';
import 'package:forui_internal_lints/src/prefix_public_types.dart';

/// Creates a linter for Forui,
PluginBase createPlugin() => _ForuiLinter();

class _ForuiLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
        AlwaysCallSuperDisposeLast(),
        AlwaysProvideFlagPropertyArgument(),
        AvoidRecordDiagnosticsProperties(),
        StyleApiRule(),
        PreferSpecificDiagnosticsProperties(),
        PrefixPublicTypesRule(),
      ];
}
