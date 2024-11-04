import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

enum Notification { all, direct, nothing }

@RoutePage()
class SelectMenuTilePage extends StatefulSample {
  SelectMenuTilePage({
    @queryParam super.theme,
  });

  @override
  State<SelectMenuTilePage> createState() => _SelectMenuTilePageState();
}

class _SelectMenuTilePageState extends StatefulSampleState<SelectMenuTilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FRadioSelectGroupController<Notification> controller = FRadioSelectGroupController();

  @override
  Widget sample(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FSelectMenuTile(
          groupController: controller,
          autoHide: true,
          validator: (value) => value == null ? 'Select an item' : null,
          prefixIcon: FIcon(FAssets.icons.bell),
          title: const Text('Notifications'),
          details: ListenableBuilder(
            listenable: controller,
            builder: (context, _) => Text(switch (controller.values.firstOrNull) {
              Notification.all => 'All',
              Notification.direct => 'Direct Messages',
              null || Notification.nothing => 'None',
            }),
          ),
          menu: [
            FSelectTile(title: const Text('All'), value: Notification.all),
            FSelectTile(title: const Text('Direct Messages'), value: Notification.direct),
            FSelectTile(title: const Text('None'), value: Notification.nothing),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          label: const Text('Save'),
          onPress: () {
            if (!_formKey.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _formKey.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
