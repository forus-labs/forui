import 'package:flutter/material.dart' hide DialogRoute;

import 'package:auto_route/auto_route.dart';
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
        AutoRoute(
          page: EmptyRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/badge/default',
          page: BadgeRoute.page,
        ),
        AutoRoute(
          path: '/button/text',
          page: ButtonTextRoute.page,
        ),
        AutoRoute(
          path: '/button/icon',
          page: ButtonIconRoute.page,
        ),
        AutoRoute(
          path: '/card/default',
          page: CardRoute.page,
        ),
        AutoRoute(
          path: '/dialog/default',
          page: DialogRoute.page,
        ),
        AutoRoute(
          path: '/header/default',
          page: RootHeaderRoute.page,
        ),
        AutoRoute(
          path: '/header/nested',
          page: NestedHeaderRoute.page,
        ),
        AutoRoute(
          path: '/header/nested-x',
          page: XNestedHeaderRoute.page,
        ),
        AutoRoute(
          path: '/tabs/default',
          page: TabsRoute.page,
        ),
        AutoRoute(
          path: '/text-field/default',
          page: TextFieldRoute.page,
        ),
        AutoRoute(
          path: '/text-field/password',
          page: PasswordTextFieldRoute.page,
        ),
        AutoRoute(
          path: '/text-field/multiline',
          page: MultilineTextFieldRoute.page,
        ),
        AutoRoute(
          path: '/text-field/form',
          page: FormTextFieldRoute.page,
        ),
        AutoRoute(
          path: '/scaffold/default',
          page: ScaffoldRoute.page,
        ),
        AutoRoute(
          path: '/separator/default',
          page: SeparatorRoute.page,
        ),
        AutoRoute(
          path: '/switch/default',
          page: SwitchRoute.page,
        ),
      ];
}
