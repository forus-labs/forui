import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

@RoutePage()
@Options(include: [Notification])
class SelectMenuTilePage extends Example {
  SelectMenuTilePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FSelectMenuTile<Notification>.fromMap(
    const {'All': .all, 'Direct Messages': .direct, 'None': .nothing},
    selectControl: const .managed(initial: {.all}),
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
@Options(include: [Notification])
class NoAutoHideSelectMenuTilePage extends Example {
  NoAutoHideSelectMenuTilePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FSelectMenuTile<Notification>.fromMap(
    const {'All': .all, 'Direct Messages': .direct, 'None': .nothing},
    selectControl: const .managed(initial: {.all}),
    // {@highlight}
    autoHide: false,
    // {@endhighlight}
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
@Options(include: [Notification])
class ScrollableSelectMenuTilePage extends Example {
  ScrollableSelectMenuTilePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FSelectMenuTile<Notification>(
    selectControl: const .managed(initial: {.all}),
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
class LazySelectMenuTilePage extends Example {
  LazySelectMenuTilePage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  Widget example(BuildContext _) => FSelectMenuTile.builder(
    selectControl: const .managed(initial: {1}),
    prefix: const Icon(FIcons.variable),
    title: const Text('Applicable values'),
    maxHeight: 200,
    // {@highlight}
    menuBuilder: (context, index) => .tile(title: Text('Tile $index'), value: index),
    // {@endhighlight}
  );
}

@RoutePage()
@Options(include: [Notification])
class SelectMenuTileFormPage extends StatefulExample {
  SelectMenuTileFormPage({@queryParam super.theme});

  @override
  State<SelectMenuTileFormPage> createState() => _SelectMenuTileFormPageState();
}

class _SelectMenuTileFormPageState extends StatefulExampleState<SelectMenuTileFormPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisSize: .min,
      spacing: 20,
      children: [
        FSelectMenuTile<Notification>(
          selectControl: const .managed(initial: {.all}),
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
