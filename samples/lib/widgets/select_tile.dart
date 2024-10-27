import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SelectTilePage extends SampleScaffold {
  final bool enabled;

  SelectTilePage({
    @queryParam super.theme,
    @queryParam this.enabled = true,
  });

  @override
  Widget child(BuildContext context) => _SelectTilePage(enabled: enabled);
}

class _SelectTilePage extends StatefulWidget {
  final bool enabled;

  const _SelectTilePage({required this.enabled});

  @override
  State<_SelectTilePage> createState() => _SelectTilePageState();
}

class _SelectTilePageState extends State<_SelectTilePage> {
  late final FMultiSelectGroupController<Object?> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController(values: {null});
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: FSelectTileGroup<Object?>(
              controller: controller,
              children: [
                FSelectTile(
                  enabled: widget.enabled,
                  title: const Text('Personalized Ads'),
                  suffixIcon: FIcon(FAssets.icons.user),
                  value: null,
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
class SelectTileSubtitlePage extends SampleScaffold {
  SelectTileSubtitlePage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _SelectTileSubtitlePage();
}

class _SelectTileSubtitlePage extends StatefulWidget {
  const _SelectTileSubtitlePage();

  @override
  State<_SelectTileSubtitlePage> createState() => _SelectTileSubtitlePageState();
}

class _SelectTileSubtitlePageState extends State<_SelectTileSubtitlePage> {
  late final FMultiSelectGroupController<Object?> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController(values: {null});
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: FSelectTileGroup<Object?>(
              controller: controller,
              children: [
                FSelectTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Banners, Sounds, Badges'),
                  suffixIcon: FIcon(FAssets.icons.bell),
                  value: null,
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
class SelectTileDetailsPage extends SampleScaffold {
  SelectTileDetailsPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _SelectTileDetailsPage();
}

class _SelectTileDetailsPage extends StatefulWidget {
  const _SelectTileDetailsPage();

  @override
  State<_SelectTileDetailsPage> createState() => _SelectTileDetailsPageState();
}

class _SelectTileDetailsPageState extends State<_SelectTileDetailsPage> {
  late final FMultiSelectGroupController<Object?> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController(values: {null});
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: FSelectTileGroup<Object?>(
              controller: controller,
              children: [
                FSelectTile(
                  title: const Text('Documents'),
                  details: const Text('2.4 GB'),
                  suffixIcon: FIcon(FAssets.icons.folder),
                  value: null,
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
class SelectTileSuffixPage extends SampleScaffold {
  SelectTileSuffixPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const _SelectTileSuffixPage();
}

class _SelectTileSuffixPage extends StatefulWidget {
  const _SelectTileSuffixPage();

  @override
  State<_SelectTileSuffixPage> createState() => _SelectTileSuffixPageState();
}

class _SelectTileSuffixPageState extends State<_SelectTileSuffixPage> {
  late final FMultiSelectGroupController<Object?> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController(values: {null});
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: FSelectTileGroup<Object?>(
              controller: controller,
              children: [
                FSelectTile.suffix(
                  prefixIcon: FIcon(FAssets.icons.list),
                  title: const Text('List View'),
                  value: null,
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
