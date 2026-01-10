import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
@Options(include: [Sidebar])
class SelectTileGroupPage extends Example {
  SelectTileGroupPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  Widget example(BuildContext _) => FSelectTileGroup<Sidebar>(
    control: const .managed(initial: {.recents}),
    label: const Text('Sidebar'),
    description: const Text('These will be shown in the sidebar.'),
    children: const [
      .tile(title: Text('Recents'), suffix: Icon(FIcons.timer), value: .recents),
      .tile(title: Text('Home'), suffix: Icon(FIcons.house), value: .home),
      .tile(title: Text('Applications'), suffix: Icon(FIcons.appWindowMac), value: .applications),
    ],
  );
}

@RoutePage()
@Options(include: [Sidebar])
class ScrollableSelectTileGroupPage extends Example {
  ScrollableSelectTileGroupPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  Widget example(BuildContext _) => FSelectTileGroup<Sidebar>(
    control: const .managed(initial: {.recents}),
    label: const Text('Sidebar'),
    description: const Text('These will be shown in the sidebar.'),
    maxHeight: 100,
    children: const [
      .tile(title: Text('Recents'), suffix: Icon(FIcons.timer), value: .recents),
      .tile(title: Text('Home'), suffix: Icon(FIcons.house), value: .home),
      .tile(title: Text('Applications'), suffix: Icon(FIcons.appWindowMac), value: .applications),
    ],
  );
}

@RoutePage()
class LazySelectTileGroupPage extends Example {
  LazySelectTileGroupPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  Widget example(BuildContext _) => FSelectTileGroup.builder(
    control: const .managed(initial: {1}),
    label: const Text('Applicable values'),
    maxHeight: 200,
    // {@highlight}
    tileBuilder: (context, index) => .tile(title: Text('Tile $index'), value: index),
    // {@endhighlight}
  );
}

@RoutePage()
@Options(include: [Language])
class SelectTileGroupMultiValuePage extends StatefulExample {
  SelectTileGroupMultiValuePage({@queryParam super.theme});

  @override
  State<SelectTileGroupMultiValuePage> createState() => _SelectTileGroupMultiValuePageState();
}

class _SelectTileGroupMultiValuePageState extends StatefulExampleState<SelectTileGroupMultiValuePage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext _) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      spacing: 20,
      children: [
        FSelectTileGroup<Language>(
          label: const Text('Favorite Languages'),
          description: const Text('Your favorite language.'),
          validator: (values) => (values?.isEmpty ?? true) ? 'Please select at least one language.' : null,
          children: const [
            .tile(title: Text('Dart'), value: .dart),
            .tile(title: Text('Java'), value: .java),
            .tile(title: Text('Rust'), value: .rust),
            .tile(title: Text('Python'), value: .python),
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

@RoutePage()
@Options(include: [Notification])
class SelectTileGroupRadioPage extends StatefulExample {
  SelectTileGroupRadioPage({@queryParam super.theme});

  @override
  State<SelectTileGroupRadioPage> createState() => _SelectTileGroupRadioPageState();
}

class _SelectTileGroupRadioPageState extends StatefulExampleState<SelectTileGroupRadioPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext _) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      spacing: 20,
      children: [
        FSelectTileGroup<Notification>(
          // {@highlight}
          control: const .managedRadio(),
          // {@endhighlight}
          label: const Text('Notifications'),
          description: const Text('Select the notifications.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
          children: const [
            .tile(title: Text('All new messages'), value: .all),
            .tile(title: Text('Direct messages and mentions'), value: .direct),
            .tile(title: Text('Nothing'), value: .nothing),
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

@RoutePage()
class SelectTileGroupSuffixPage extends StatefulExample {
  SelectTileGroupSuffixPage({@queryParam super.theme}) : super(maxWidth: 300);

  @override
  State<SelectTileGroupSuffixPage> createState() => _SelectTileGroupSuffixPageState();
}

class _SelectTileGroupSuffixPageState extends StatefulExampleState<SelectTileGroupSuffixPage> {
  @override
  Widget example(BuildContext _) => FSelectTileGroup<String>(
    control: const .managedRadio(),
    label: const Text('Settings'),
    children: const [
      // {@highlight}
      FSelectTile.suffix(prefix: Icon(FIcons.list), title: Text('List View'), value: 'List'),
      FSelectTile.suffix(prefix: Icon(FIcons.layoutGrid), title: Text('Grid View'), value: 'Grid'),
      // {@endhighlight}
    ],
  );
}

@RoutePage()
@Options(include: [Sidebar])
class FullDividerSelectTileGroupPage extends Example {
  FullDividerSelectTileGroupPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  Widget example(BuildContext _) => FSelectTileGroup<Sidebar>(
    control: const .managed(initial: {.recents}),
    label: const Text('Sidebar'),
    description: const Text('These will be shown in the sidebar.'),
    // {@highlight}
    divider: .full,
    // {@endhighlight}
    children: const [
      .tile(title: Text('Recents'), suffix: Icon(FIcons.timer), value: .recents),
      .tile(title: Text('Home'), suffix: Icon(FIcons.house), value: .home),
      .tile(title: Text('Applications'), suffix: Icon(FIcons.appWindowMac), value: .applications),
    ],
  );
}

@RoutePage()
@Options(include: [Sidebar])
class NoDividerSelectTileGroupPage extends Example {
  NoDividerSelectTileGroupPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  Widget example(BuildContext _) => FSelectTileGroup<Sidebar>(
    control: const .managed(initial: {.recents}),
    label: const Text('Sidebar'),
    description: const Text('These will be shown in the sidebar.'),
    // {@highlight}
    divider: .none,
    // {@endhighlight}
    children: const [
      .tile(title: Text('Recents'), suffix: Icon(FIcons.timer), value: .recents),
      .tile(title: Text('Home'), suffix: Icon(FIcons.house), value: .home),
      .tile(title: Text('Applications'), suffix: Icon(FIcons.appWindowMac), value: .applications),
    ],
  );
}
