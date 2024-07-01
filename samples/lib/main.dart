import 'package:flutter/material.dart' hide DialogRoute;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/main.gr.dart';
import 'package:forui_samples/sample_scaffold.dart';

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
  Widget child(BuildContext context) {
    final notifier = ValueNotifier(true);
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, __) => FCheckBox(
            value: value,
            // onChanged: (value) => notifier.value = value,
          ),
        ),
        SizedBox(width: 10),
        Text('I accept the terms and conditions'),
      ],
    );
  }
}


class FCheckBox extends StatefulWidget {
  final String? semanticLabel;
  final bool value;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const FCheckBox({
    required this.value,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  State<FCheckBox> createState() => _FCheckBoxState();
}

class _FCheckBoxState extends State<FCheckBox> {
  @override
  Widget build(BuildContext context) {
    final FThemeData(:style, :colorScheme) = context.theme;

    return Semantics(
      label: widget.semanticLabel,
      checked: widget.value,
      child: SizedBox.square(
        dimension: 18,
        child: FocusableActionDetector(
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          onFocusChange: widget.onFocusChange,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: colorScheme.foreground,
                  width: 0.6,
                ),
                color: widget.value ? colorScheme.foreground : colorScheme.background,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: widget.value ?
                  FAssets.icons.check(
                    height: 14,
                    width: 14,
                    colorFilter:  ColorFilter.mode(
                      colorScheme.background,
                      BlendMode.srcIn,
                    ),
                  ) : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
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
      ];
}
