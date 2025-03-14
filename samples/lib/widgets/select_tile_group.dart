import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
class SelectTileGroupPage extends StatefulSample {
  final FTileDivider divider;

  SelectTileGroupPage({@queryParam super.theme, @queryParam String divider = 'indented'})
    : divider = switch (divider) {
        'indented' => FTileDivider.indented,
        'none' => FTileDivider.none,
        _ => FTileDivider.full,
      };

  @override
  State<SelectTileGroupPage> createState() => _SelectTileGroupPageState();
}

class _SelectTileGroupPageState extends StatefulSampleState<SelectTileGroupPage> {
  final controller = FSelectTileGroupController(values: {Sidebar.recents});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: FSelectTileGroup(
          selectController: controller,
          label: const Text('Sidebar'),
          description: const Text('These will be shown in the sidebar.'),
          divider: widget.divider,
          children: [
            FSelectTile(title: const Text('Recents'), suffixIcon: FIcon(FAssets.icons.timer), value: Sidebar.recents),
            FSelectTile(title: const Text('Home'), suffixIcon: FIcon(FAssets.icons.house), value: Sidebar.home),
            FSelectTile(
              title: const Text('Applications'),
              suffixIcon: FIcon(FAssets.icons.appWindowMac),
              value: Sidebar.applications,
            ),
          ],
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
class ScrollableSelectTileGroupPage extends StatefulSample {
  ScrollableSelectTileGroupPage({@queryParam super.theme});

  @override
  State<ScrollableSelectTileGroupPage> createState() => _ScrollableSelectTileGroupPageState();
}

class _ScrollableSelectTileGroupPageState extends StatefulSampleState<ScrollableSelectTileGroupPage> {
  final controller = FSelectTileGroupController(values: {Sidebar.recents});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: FSelectTileGroup(
          selectController: controller,
          label: const Text('Sidebar'),
          description: const Text('These will be shown in the sidebar.'),
          maxHeight: 100,
          children: [
            FSelectTile(title: const Text('Recents'), suffixIcon: FIcon(FAssets.icons.timer), value: Sidebar.recents),
            FSelectTile(title: const Text('Home'), suffixIcon: FIcon(FAssets.icons.house), value: Sidebar.home),
            FSelectTile(
              title: const Text('Applications'),
              suffixIcon: FIcon(FAssets.icons.appWindowMac),
              value: Sidebar.applications,
            ),
          ],
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
class LazySelectTileGroupPage extends StatefulSample {
  LazySelectTileGroupPage({@queryParam super.theme});

  @override
  State<LazySelectTileGroupPage> createState() => _LazySelectTileGroupPageState();
}

class _LazySelectTileGroupPageState extends StatefulSampleState<LazySelectTileGroupPage> {
  final controller = FMultiValueNotifier(values: {1});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: FSelectTileGroup.builder(
          selectController: controller,
          label: const Text('Applicable values'),
          maxHeight: 200,
          tileBuilder: (context, index) => FSelectTile(title: Text('Tile $index'), value: index),
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
class SelectTileGroupMultiValuePage extends StatefulSample {
  SelectTileGroupMultiValuePage({@queryParam super.theme});

  @override
  State<SelectTileGroupMultiValuePage> createState() => _SelectTileGroupMultiValuePageState();
}

class _SelectTileGroupMultiValuePageState extends StatefulSampleState<SelectTileGroupMultiValuePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = FSelectTileGroupController<Language>();

  @override
  Widget sample(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FSelectTileGroup(
          selectController: controller,
          label: const Text('Favorite Languages'),
          description: const Text('Your favorite language.'),
          validator: (values) => (values?.isEmpty ?? true) ? 'Please select at least one language.' : null,
          children: [
            FSelectTile(title: const Text('Dart'), value: Language.dart),
            FSelectTile(title: const Text('Java'), value: Language.java),
            FSelectTile(title: const Text('Rust'), value: Language.rust),
            FSelectTile(title: const Text('Python'), value: Language.python),
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

@RoutePage()
class SelectTileGroupRadioPage extends StatefulSample {
  SelectTileGroupRadioPage({@queryParam super.theme});

  @override
  State<SelectTileGroupRadioPage> createState() => _SelectTileGroupRadioPageState();
}

class _SelectTileGroupRadioPageState extends StatefulSampleState<SelectTileGroupRadioPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = FSelectTileGroupController<Notification>.radio();

  @override
  Widget sample(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FSelectTileGroup(
          selectController: controller,
          label: const Text('Notifications'),
          description: const Text('Select the notifications.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
          children: [
            FSelectTile(title: const Text('All new messages'), value: Notification.all),
            FSelectTile(title: const Text('Direct messages and mentions'), value: Notification.direct),
            FSelectTile(title: const Text('Nothing'), value: Notification.nothing),
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

@RoutePage()
class SelectTileGroupSuffixPage extends StatefulSample {
  SelectTileGroupSuffixPage({@queryParam super.theme});

  @override
  State<SelectTileGroupSuffixPage> createState() => _SelectTileGroupSuffixPageState();
}

class _SelectTileGroupSuffixPageState extends StatefulSampleState<SelectTileGroupSuffixPage> {
  final controller = FSelectTileGroupController<String>.radio();

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: FSelectTileGroup(
          selectController: controller,
          label: const Text('Settings'),
          children: [
            FSelectTile.suffix(prefixIcon: FIcon(FAssets.icons.list), title: const Text('List View'), value: 'List'),
            FSelectTile.suffix(
              prefixIcon: FIcon(FAssets.icons.layoutGrid),
              title: const Text('Grid View'),
              value: 'Grid',
            ),
          ],
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
