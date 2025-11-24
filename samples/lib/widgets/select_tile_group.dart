import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
class SelectTileGroupPage extends StatefulSample {
  final FItemDivider divider;

  SelectTileGroupPage({@queryParam super.theme, @queryParam String divider = 'indented'})
    : divider = switch (divider) {
        'indented' => .indented,
        'none' => .none,
        _ => .full,
      };

  @override
  State<SelectTileGroupPage> createState() => _SelectTileGroupPageState();
}

class _SelectTileGroupPageState extends StatefulSampleState<SelectTileGroupPage> {
  final controller = FSelectTileGroupController(value: {Sidebar.recents});

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
        child: FSelectTileGroup<Sidebar>(
          selectController: controller,
          label: const Text('Sidebar'),
          description: const Text('These will be shown in the sidebar.'),
          divider: widget.divider,
          children: const [
            .tile(title: Text('Recents'), suffix: Icon(FIcons.timer), value: .recents),
            .tile(title: Text('Home'), suffix: Icon(FIcons.house), value: .home),
            .tile(title: Text('Applications'), suffix: Icon(FIcons.appWindowMac), value: .applications),
          ],
        ),
      ),
    ],
  );
}

@RoutePage()
class ScrollableSelectTileGroupPage extends StatefulSample {
  ScrollableSelectTileGroupPage({@queryParam super.theme});

  @override
  State<ScrollableSelectTileGroupPage> createState() => _ScrollableSelectTileGroupPageState();
}

class _ScrollableSelectTileGroupPageState extends StatefulSampleState<ScrollableSelectTileGroupPage> {
  final controller = FSelectTileGroupController(value: {Sidebar.recents});

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
        child: FSelectTileGroup<Sidebar>(
          selectController: controller,
          label: const Text('Sidebar'),
          description: const Text('These will be shown in the sidebar.'),
          maxHeight: 100,
          children: const [
            .tile(title: Text('Recents'), suffix: Icon(FIcons.timer), value: .recents),
            .tile(title: Text('Home'), suffix: Icon(FIcons.house), value: .home),
            .tile(title: Text('Applications'), suffix: Icon(FIcons.appWindowMac), value: .applications),
          ],
        ),
      ),
    ],
  );
}

@RoutePage()
class LazySelectTileGroupPage extends StatefulSample {
  LazySelectTileGroupPage({@queryParam super.theme});

  @override
  State<LazySelectTileGroupPage> createState() => _LazySelectTileGroupPageState();
}

class _LazySelectTileGroupPageState extends StatefulSampleState<LazySelectTileGroupPage> {
  final controller = FMultiValueNotifier(value: {1});

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
        child: FSelectTileGroup.builder(
          selectController: controller,
          label: const Text('Applicable values'),
          maxHeight: 200,
          tileBuilder: (context, index) => .tile(title: Text('Tile $index'), value: index),
        ),
      ),
    ],
  );
}

@RoutePage()
class SelectTileGroupMultiValuePage extends StatefulSample {
  SelectTileGroupMultiValuePage({@queryParam super.theme});

  @override
  State<SelectTileGroupMultiValuePage> createState() => _SelectTileGroupMultiValuePageState();
}

class _SelectTileGroupMultiValuePageState extends StatefulSampleState<SelectTileGroupMultiValuePage> {
  final _key = GlobalKey<FormState>();
  final _controller = FSelectTileGroupController<Language>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        FSelectTileGroup<Language>(
          selectController: _controller,
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

@RoutePage()
class SelectTileGroupRadioPage extends StatefulSample {
  SelectTileGroupRadioPage({@queryParam super.theme});

  @override
  State<SelectTileGroupRadioPage> createState() => _SelectTileGroupRadioPageState();
}

class _SelectTileGroupRadioPageState extends StatefulSampleState<SelectTileGroupRadioPage> {
  final _key = GlobalKey<FormState>();
  final _controller = FSelectTileGroupController<Notification>.radio();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        FSelectTileGroup<Notification>(
          selectController: _controller,
          label: const Text('Notifications'),
          description: const Text('Select the notifications.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
          children: const [
            .tile(title: Text('All new messages'), value: .all),
            .tile(title: Text('Direct messages and mentions'), value: .direct),
            .tile(title: Text('Nothing'), value: .nothing),
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

@RoutePage()
class SelectTileGroupSuffixPage extends StatefulSample {
  SelectTileGroupSuffixPage({@queryParam super.theme});

  @override
  State<SelectTileGroupSuffixPage> createState() => _SelectTileGroupSuffixPageState();
}

class _SelectTileGroupSuffixPageState extends StatefulSampleState<SelectTileGroupSuffixPage> {
  final _controller = FSelectTileGroupController<String>.radio();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: FSelectTileGroup(
          selectController: _controller,
          label: const Text('Settings'),
          children: const [
            FSelectTile.suffix(prefix: Icon(FIcons.list), title: Text('List View'), value: 'List'),
            FSelectTile.suffix(prefix: Icon(FIcons.layoutGrid), title: Text('Grid View'), value: 'Grid'),
          ],
        ),
      ),
    ],
  );
}
