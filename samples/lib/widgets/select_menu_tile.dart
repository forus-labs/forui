import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

@RoutePage()
class SelectMenuTilePage extends Sample {
  final bool autoHide;

  SelectMenuTilePage({@queryParam super.theme, @queryParam String autoHide = 'true'})
    : autoHide = bool.tryParse(autoHide) ?? true;

  @override
  Widget sample(BuildContext context) => FSelectMenuTile(
    initialValue: Notification.all,
    autoHide: autoHide,
    validator: (value) => value == null ? 'Select an item' : null,
    prefix: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
      Notification.all => 'All',
      Notification.direct => 'Direct Messages',
      _ => 'None',
    }),
    menu: const [
      FSelectTile(title: Text('All'), value: Notification.all),
      FSelectTile(title: Text('Direct Messages'), value: Notification.direct),
      FSelectTile(title: Text('None'), value: Notification.nothing),
    ],
  );
}

@RoutePage()
class ScrollableSelectMenuTilePage extends Sample {
  final bool autoHide;

  ScrollableSelectMenuTilePage({@queryParam super.theme, @queryParam String autoHide = 'true'})
    : autoHide = bool.tryParse(autoHide) ?? true;

  @override
  Widget sample(BuildContext context) => FSelectMenuTile(
    initialValue: Notification.all,
    autoHide: autoHide,
    maxHeight: 150,
    validator: (value) => value == null ? 'Select an item' : null,
    prefix: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
      Notification.all => 'All',
      Notification.direct => 'Direct Messages',
      Notification.limitedTime => 'Limited Time',
      Notification.selectedApps => 'Selected Apps',
      Notification.timeSensitive => 'Time Sensitive',
      null || Notification.nothing => 'None',
    }),
    menu: const [
      FSelectTile(title: Text('All'), value: Notification.all),
      FSelectTile(title: Text('Direct Messages'), value: Notification.direct),
      FSelectTile(title: Text('Limited Time'), value: Notification.limitedTime),
      FSelectTile(title: Text('Selected Apps'), value: Notification.selectedApps),
      FSelectTile(title: Text('Time Sensitive'), value: Notification.timeSensitive),
      FSelectTile(title: Text('None'), value: Notification.nothing),
    ],
  );
}

@RoutePage()
class LazySelectMenuTilePage extends StatefulSample {
  LazySelectMenuTilePage({@queryParam super.theme});

  @override
  State<LazySelectMenuTilePage> createState() => _LazySelectMenuTilePageState();
}

class _LazySelectMenuTilePageState extends StatefulSampleState<LazySelectMenuTilePage> {
  final controller = FSelectMenuTileController(values: {1});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: FSelectMenuTile.builder(
          selectController: controller,
          prefix: const Icon(FIcons.variable),
          title: const Text('Applicable values'),
          maxHeight: 200,
          menuBuilder: (context, index) => FSelectTile(title: Text('Tile $index'), value: index),
        ),
      ),
    ],
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class SelectMenuTileFormPage extends StatefulSample {
  SelectMenuTileFormPage({@queryParam super.theme});

  @override
  State<SelectMenuTileFormPage> createState() => _SelectMenuTileFormPageState();
}

class _SelectMenuTileFormPageState extends StatefulSampleState<SelectMenuTileFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FSelectMenuTile(
          initialValue: Notification.all,
          validator: (value) => value == null ? 'Select an item' : null,
          prefix: const Icon(FIcons.bell),
          title: const Text('Notifications'),
          detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
            Notification.all => 'All',
            Notification.direct => 'Direct Messages',
            _ => 'None',
          }),
          menu: const [
            FSelectTile(title: Text('All'), value: Notification.all),
            FSelectTile(title: Text('Direct Messages'), value: Notification.direct),
            FSelectTile(title: Text('None'), value: Notification.nothing),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          child: const Text('Save'),
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
}
