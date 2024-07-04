import 'package:flutter/material.dart' hide DialogRoute;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/main.gr.dart';
import 'package:forui_samples/sample_scaffold.dart';
import 'package:sugar/sugar.dart';

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
class EmptyPage extends SampleScaffold {
  @override
  Widget child(BuildContext context) => const Testing();
}

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
            height: 36,
            width: 36,
            child: EnabledDay(
              style: FDayStateStyle(
                decoration: const BoxDecoration(),
                textStyle: context.theme.typography.sm.copyWith(
                  color: context.theme.colorScheme.mutedForeground.withOpacity(0.5),
                ),
                focusedTextStyle: context.theme.typography.sm.copyWith(
                  color: context.theme.colorScheme.mutedForeground,
                ),
              ),
              date: DateTime(2024, 3, 31),
              onPress: print,
              today: true,
              selected: true,
            ),
          ),
      SizedBox(
        height: 36,
        width: 36,
        child: EnabledDay(
          style: FDayStateStyle(
            decoration: const BoxDecoration(),
            textStyle: context.theme.typography.sm.copyWith(
              color: context.theme.colorScheme.mutedForeground.withOpacity(0.5),
            ),
            // focusedTextStyle: context.theme.typography.sm.copyWith(
            //   color: context.theme.colorScheme.mutedForeground,
            // ),
          ),
          date: DateTime(2024, 4),
          onPress: print,
          today: true,
          selected: true,
        ),
      ),
    ],
  );
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
          path: '/checkbox/default',
          page: CheckboxRoute.page,
        ),
        AutoRoute(
          path: '/checkbox/form',
          page: FormCheckboxRoute.page,
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
          path: '/progress/default',
          page: ProgressRoute.page,
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
        AutoRoute(
          path: '/switch/form',
          page: FormSwitchRoute.page,
        ),
      ];
}
