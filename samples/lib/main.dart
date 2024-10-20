import 'package:flutter/material.dart' hide DialogRoute;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

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
  Widget child(BuildContext context) => const Placeholder();
}

@AutoRouterConfig()
class _AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: EmptyRoute.page, initial: true),
        AutoRoute(path: '/accordion/default', page: AccordionRoute.page),
        AutoRoute(path: '/alert/default', page: AlertRoute.page),
        AutoRoute(path: '/avatar/default', page: AvatarRoute.page),
        AutoRoute(path: '/avatar/raw', page: AvatarRawRoute.page),
        AutoRoute(path: '/avatar/invalid', page: AvatarInvalidRoute.page),
        AutoRoute(path: '/badge/default', page: BadgeRoute.page),
        AutoRoute(path: '/bottom-navigation-bar/default', page: BottomNavigationBarRoute.page),
        AutoRoute(path: '/button/text', page: ButtonTextRoute.page),
        AutoRoute(path: '/button/icon', page: ButtonIconRoute.page),
        AutoRoute(path: '/button/only-icon', page: ButtonOnlyIconRoute.page),
        AutoRoute(path: '/button/spinner', page: ButtonSpinnerRoute.page),
        AutoRoute(path: '/calendar/default', page: CalendarRoute.page),
        AutoRoute(path: '/calendar/dates', page: DatesCalendarRoute.page),
        AutoRoute(path: '/calendar/unselectable', page: UnselectableCalendarRoute.page),
        AutoRoute(path: '/calendar/range', page: RangeCalendarRoute.page),
        AutoRoute(path: '/card/default', page: CardRoute.page),
        AutoRoute(path: '/checkbox/default', page: CheckboxRoute.page),
        AutoRoute(path: '/checkbox/raw', page: RawCheckboxRoute.page),
        AutoRoute(path: '/checkbox/form', page: FormCheckboxRoute.page),
        AutoRoute(path: '/dialog/default', page: DialogRoute.page),
        AutoRoute(path: '/divider/default', page: DividerRoute.page),
        AutoRoute(path: '/header/default', page: RootHeaderRoute.page),
        AutoRoute(path: '/header/nested', page: NestedHeaderRoute.page),
        AutoRoute(path: '/header/nested-x', page: XNestedHeaderRoute.page),
        AutoRoute(path: '/icon/default', page: IconRoute.page),
        AutoRoute(path: '/icon/comparison', page: ComparisonIconRoute.page),
        AutoRoute(path: '/icon/custom', page: CustomIconRoute.page),
        AutoRoute(path: '/icon/image', page: ImageIconRoute.page),
        AutoRoute(path: '/label/vertical', page: VerticalLabelRoute.page),
        AutoRoute(path: '/label/horizontal', page: HorizontalLabelRoute.page),
        AutoRoute(path: '/popover/default', page: PopoverRoute.page),
        AutoRoute(path: '/progress/default', page: ProgressRoute.page),
        AutoRoute(path: '/radio/default', page: RadioRoute.page),
        AutoRoute(path: '/resizable/default', page: ResizableRoute.page),
        AutoRoute(path: '/resizable/no-cascading', page: NoCascadingResizableRoute.page),
        AutoRoute(path: '/resizable/horizontal', page: HorizontalResizableRoute.page),
        AutoRoute(path: '/resizable/no-thumb', page: NoThumbResizableRoute.page),
        AutoRoute(path: '/resizable/no-divider', page: NoDividerResizableRoute.page),
        AutoRoute(path: '/scaffold/default', page: ScaffoldRoute.page),
        AutoRoute(path: '/select-group/default', page: SelectGroupRoute.page),
        AutoRoute(path: '/select-group/checkbox-form', page: SelectGroupCheckboxFormRoute.page),
        AutoRoute(path: '/select-group/radio-form', page: SelectGroupRadioFormRoute.page),
        AutoRoute(path: '/slider/default', page: SliderRoute.page),
        AutoRoute(path: '/slider/tooltip', page: TooltipSliderRoute.page),
        AutoRoute(path: '/slider/marks', page: MarksSliderRoute.page),
        AutoRoute(path: '/slider/discrete', page: DiscreteSliderRoute.page),
        AutoRoute(path: '/slider/range', page: RangeSliderRoute.page),
        AutoRoute(path: '/slider/vertical', page: VerticalSliderRoute.page),
        AutoRoute(path: '/slider/form', page: SliderFormRoute.page),
        AutoRoute(path: '/switch/default', page: SwitchRoute.page),
        AutoRoute(path: '/switch/form', page: FormSwitchRoute.page),
        AutoRoute(path: '/tabs/default', page: TabsRoute.page),
        AutoRoute(path: '/text-field/default', page: TextFieldRoute.page),
        AutoRoute(path: '/text-field/email', page: EmailTextFieldRoute.page),
        AutoRoute(path: '/text-field/password', page: PasswordTextFieldRoute.page),
        AutoRoute(path: '/text-field/multiline', page: MultilineTextFieldRoute.page),
        AutoRoute(path: '/text-field/form', page: FormTextFieldRoute.page),
        AutoRoute(path: '/tile/default', page: TileRoute.page),
        AutoRoute(path: '/tile/subtitle', page: TileSubtitleRoute.page),
        AutoRoute(path: '/tile/details', page: TileDetailsRoute.page),
        AutoRoute(path: '/tile-group/default', page: TileGroupRoute.page),
        AutoRoute(path: '/tooltip/default', page: TooltipRoute.page),
      ];
}
