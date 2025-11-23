import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

@RoutePage()
class SelectMenuTilePage extends Sample {
  final bool autoHide;

  SelectMenuTilePage({@queryParam super.theme, @queryParam this.autoHide = true});

  @override
  Widget sample(BuildContext context) => FSelectMenuTile<Notification>.fromMap(
    const {'All': .all, 'Direct Messages': .direct, 'None': .nothing},
    initialValue: .all,
    autoHide: autoHide,
    validator: (value) => value == null ? 'Select an item' : null,
    prefix: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
      .all => 'All',
      .direct => 'Direct Messages',
      _ => 'None',
    }),
  );
}

@RoutePage()
class ScrollableSelectMenuTilePage extends Sample {
  final bool autoHide;

  ScrollableSelectMenuTilePage({@queryParam super.theme, @queryParam this.autoHide = true});

  @override
  Widget sample(BuildContext context) => FSelectMenuTile<Notification>(
    initialValue: .all,
    autoHide: autoHide,
    maxHeight: 150,
    validator: (value) => value == null ? 'Select an item' : null,
    prefix: const Icon(FIcons.bell),
    title: const Text('Notifications'),
    detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
      .all => 'All',
      .direct => 'Direct Messages',
      .limitedTime => 'Limited Time',
      .selectedApps => 'Selected Apps',
      .timeSensitive => 'Time Sensitive',
      null || .nothing => 'None',
    }),
    menu: const [
      .tile(title: Text('All'), value: .all),
      .tile(title: Text('Direct Messages'), value: .direct),
      .tile(title: Text('Limited Time'), value: .limitedTime),
      .tile(title: Text('Selected Apps'), value: .selectedApps),
      .tile(title: Text('Time Sensitive'), value: .timeSensitive),
      .tile(title: Text('None'), value: .nothing),
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
  final controller = FSelectMenuTileController(value: {1});

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: FSelectMenuTile.builder(
          selectController: controller,
          prefix: const Icon(FIcons.variable),
          title: const Text('Applicable values'),
          maxHeight: 200,
          menuBuilder: (context, index) => .tile(title: Text('Tile $index'), value: index),
        ),
      ),
    ],
  );
}

@RoutePage()
class SelectMenuTileFormPage extends StatefulSample {
  SelectMenuTileFormPage({@queryParam super.theme});

  @override
  State<SelectMenuTileFormPage> createState() => _SelectMenuTileFormPageState();
}

class _SelectMenuTileFormPageState extends StatefulSampleState<SelectMenuTileFormPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisSize: .min,
      children: [
        FSelectMenuTile<Notification>(
          initialValue: .all,
          validator: (value) => value == null ? 'Select an item' : null,
          prefix: const Icon(FIcons.bell),
          title: const Text('Notifications'),
          detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
            .all => 'All',
            .direct => 'Direct Messages',
            _ => 'None',
          }),
          menu: const [
            .tile(title: Text('All'), value: .all),
            .tile(title: Text('Direct Messages'), value: .direct),
            .tile(title: Text('None'), value: .nothing),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          child: const Text('Save'),
          onPress: () {
            if (!_key.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _key.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );
}
