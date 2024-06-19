import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide DialogRoute;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:forui_samples/main.gr.dart';

void main() {
  usePathUrlStrategy();
  runApp(ForuiSamples());
}

class ForuiSamples extends StatelessWidget {
  final _router = _AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Forui Samples',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      useMaterial3: true,
    ),
    routerConfig: _router.config(),
  );
}

@RoutePage()
class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Placeholder();
}

@AutoRouterConfig()
class _AppRouter extends $_AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: EmptyRoute.page, initial: true),
    AutoRoute(
      path: '/badge',
      page: BadgeRoute.page,
    ),
    AutoRoute(
      path: '/button',
      page: EmptyRoute.page,
      children: [
        AutoRoute(
          path: 'text',
          page: ButtonTextRoute.page,
        ),
        AutoRoute(
          path: 'icon',
          page: ButtonIconRoute.page,
        ),
      ],
    ),
    AutoRoute(
      path: '/card',
      page: CardRoute.page,
    ),
    AutoRoute(
      path: '/dialog',
      page: DialogRoute.page,
    ),
    AutoRoute(
      path: '/header',
      page: HeaderRoute.page,
    ),
    AutoRoute(
      path: '/text-field',
      page: TextFieldRoute.page,
    ),
    AutoRoute(
      path: '/separator',
      page: SeparatorRoute.page,
    ),
    AutoRoute(
      path: '/switch',
      page: SwitchRoute.page,
    )
  ];
}
