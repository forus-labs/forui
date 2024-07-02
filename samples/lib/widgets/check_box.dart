import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class CheckBoxPage extends SampleScaffold {
  final bool enabled;

  CheckBoxPage({
    @queryParam super.theme,
    @queryParam this.enabled = false,
  });

  @override
  Widget child(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: FCheckBox(
          enabled: enabled,
        ),
      ),
    ],
  );
}
