import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
class SelectTileGroupPage extends SampleScaffold {
  final FTileDivider divider;

  SelectTileGroupPage({
    @queryParam super.theme,
    @queryParam String divider = 'indented',
  }) : divider = switch (divider) {
          'indented' => FTileDivider.indented,
          'none' => FTileDivider.none,
          _ => FTileDivider.full,
        };

  @override
  Widget child(BuildContext context) => _SelectTileGroupPage(divider: divider);
}

class _SelectTileGroupPage extends StatefulWidget {
  final FTileDivider divider;

  const _SelectTileGroupPage({required this.divider});

  @override
  State<_SelectTileGroupPage> createState() => _SelectTileGroupPageState();
}

class _SelectTileGroupPageState extends State<_SelectTileGroupPage> {
  late final FMultiSelectGroupController<Sidebar> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController(values: {Sidebar.recents});
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: FSelectTileGroup(
              controller: controller,
              label: const Text('Sidebar'),
              description: const Text('These will be shown in the sidebar.'),
              divider: widget.divider,
              children: [
                FSelectTile(
                  title: const Text('Recents'),
                  suffixIcon: FIcon(FAssets.icons.timer),
                  value: Sidebar.recents,
                ),
                FSelectTile(
                  title: const Text('Home'),
                  suffixIcon: FIcon(FAssets.icons.house),
                  value: Sidebar.home,
                ),
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
class SelectTileGroupMultiValuePage extends SampleScaffold {
  SelectTileGroupMultiValuePage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _SelectTileGroupMultiValuePage();
}

class _SelectTileGroupMultiValuePage extends StatefulWidget {
  const _SelectTileGroupMultiValuePage();

  @override
  State<_SelectTileGroupMultiValuePage> createState() => _SelectTileGroupMultiValuePageState();
}

class _SelectTileGroupMultiValuePageState extends State<_SelectTileGroupMultiValuePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FMultiSelectGroupController<Language> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController(values: {});
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FSelectTileGroup(
              controller: controller,
              label: const Text('Favorite Languages'),
              description: const Text('Your favorite language.'),
              validator: (values) => (values?.isEmpty ?? true) ? 'Please select at least one language.' : null,
              children: [
                FSelectTile(
                  title: const Text('Dart'),
                  value: Language.dart,
                ),
                FSelectTile(
                  title: const Text('Java'),
                  value: Language.java,
                ),
                FSelectTile(
                  title: const Text('Rust'),
                  value: Language.rust,
                ),
                FSelectTile(
                  title: const Text('Python'),
                  value: Language.python,
                ),
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
class SelectTileGroupRadioPage extends SampleScaffold {
  SelectTileGroupRadioPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _SelectTileGroupRadioPage();
}

class _SelectTileGroupRadioPage extends StatefulWidget {
  const _SelectTileGroupRadioPage();

  @override
  State<_SelectTileGroupRadioPage> createState() => _SelectTileGroupRadioPageState();
}

class _SelectTileGroupRadioPageState extends State<_SelectTileGroupRadioPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FRadioSelectGroupController<Notification> controller;

  @override
  void initState() {
    super.initState();
    controller = FRadioSelectGroupController();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FSelectTileGroup(
              controller: controller,
              label: const Text('Notifications'),
              description: const Text('Select the notifications.'),
              validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
              children: [
                FSelectTile(
                  title: const Text('All new messages'),
                  value: Notification.all,
                ),
                FSelectTile(
                  title: const Text('Direct messages and mentions'),
                  value: Notification.direct,
                ),
                FSelectTile(
                  title: const Text('Nothing'),
                  value: Notification.nothing,
                ),
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
class SelectTileGroupSuffixPage extends SampleScaffold {
  SelectTileGroupSuffixPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _SelectTileGroupSuffixPage();
}

class _SelectTileGroupSuffixPage extends StatefulWidget {
  const _SelectTileGroupSuffixPage();

  @override
  State<_SelectTileGroupSuffixPage> createState() => _SelectTileGroupSuffixPageState();
}

class _SelectTileGroupSuffixPageState extends State<_SelectTileGroupSuffixPage> {
  late final FRadioSelectGroupController<String> controller;

  @override
  void initState() {
    super.initState();
    controller = FRadioSelectGroupController();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: FSelectTileGroup(
              controller: controller,
              label: const Text('Settings'),
              children: [
                FSelectTile.suffix(
                  prefixIcon: FIcon(FAssets.icons.list),
                  title: const Text('List View'),
                  value: 'List',
                ),
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
