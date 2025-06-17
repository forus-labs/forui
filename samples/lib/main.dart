import 'package:flutter/material.dart' hide DialogRoute;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/main.gr.dart';
import 'package:forui_samples/sample.dart';

void main() {
  usePathUrlStrategy();
  runApp(ForuiSamples());
}

class ForuiSamples extends StatelessWidget {
  final _router = _AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Forui Samples',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white), useMaterial3: true),
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    routerConfig: _router.config(),
  );
}

@RoutePage()
class EmptyPage extends Sample {
  @override
  Widget sample(BuildContext context) => const Placeholder();
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
    AutoRoute(path: '/breadcrumb/default', page: BreadcrumbRoute.page),
    AutoRoute(path: '/breadcrumb/divider', page: BreadcrumbDividerRoute.page),
    AutoRoute(path: '/button/text', page: ButtonTextRoute.page),
    AutoRoute(path: '/button/icon', page: ButtonIconRoute.page),
    AutoRoute(path: '/button/only-icon', page: ButtonOnlyIconRoute.page),
    AutoRoute(path: '/button/circular-progress', page: ButtonCircularProgressRoute.page),
    AutoRoute(path: '/calendar/default', page: CalendarRoute.page),
    AutoRoute(path: '/calendar/dates', page: DatesCalendarRoute.page),
    AutoRoute(path: '/calendar/unselectable', page: UnselectableCalendarRoute.page),
    AutoRoute(path: '/calendar/range', page: RangeCalendarRoute.page),
    AutoRoute(path: '/card/default', page: CardRoute.page),
    AutoRoute(path: '/checkbox/default', page: CheckboxRoute.page),
    AutoRoute(path: '/checkbox/raw', page: RawCheckboxRoute.page),
    AutoRoute(path: '/checkbox/form', page: FormCheckboxRoute.page),
    AutoRoute(path: '/collapsible/default', page: CollapsibleRoute.page),
    AutoRoute(path: '/date-field/default', page: DateFieldRoute.page),
    AutoRoute(path: '/date-field/clearable', page: ClearableDateFieldRoute.page),
    AutoRoute(path: '/date-field/calendar', page: CalendarDateFieldRoute.page),
    AutoRoute(path: '/date-field/input', page: InputDateFieldRoute.page),
    AutoRoute(path: '/date-field/validator', page: ValidatorDateFieldRoute.page),
    AutoRoute(path: '/date-field/form', page: FormDateFieldRoute.page),
    AutoRoute(path: '/dialog/default', page: DialogRoute.page),
    AutoRoute(path: '/dialog/blurred', page: BlurredDialogRoute.page),
    AutoRoute(path: '/divider/default', page: DividerRoute.page),
    AutoRoute(path: '/focused-outline/default', page: FocusedOutlineRoute.page),
    AutoRoute(path: '/header/default', page: RootHeaderRoute.page),
    AutoRoute(path: '/header/nested', page: NestedHeaderRoute.page),
    AutoRoute(path: '/header/nested-x', page: XNestedHeaderRoute.page),
    AutoRoute(path: '/label/vertical', page: VerticalLabelRoute.page),
    AutoRoute(path: '/label/horizontal', page: HorizontalLabelRoute.page),
    AutoRoute(path: '/line-calendar/default', page: LineCalendarRoute.page),
    AutoRoute(path: '/modal-sheet/default', page: ModalSheetRoute.page),
    AutoRoute(path: '/modal-sheet/blurred', page: BlurredModalSheetRoute.page),
    AutoRoute(path: '/modal-sheet/draggable', page: DraggableModalSheetRoute.page),
    AutoRoute(path: '/pagination/default', page: PaginationRoute.page),
    AutoRoute(path: '/pagination/custom-icon', page: PaginationCustomIconRoute.page),
    AutoRoute(path: '/pagination/page-view', page: PaginationWithViewRoute.page),
    AutoRoute(path: '/picker/default', page: PickerRoute.page),
    AutoRoute(path: '/picker/multiple', page: MultiPickerRoute.page),
    AutoRoute(path: '/picker/separator', page: SeparatedPickerRoute.page),
    AutoRoute(path: '/popover/default', page: PopoverRoute.page),
    AutoRoute(path: '/popover/blurred', page: BlurredPopoverRoute.page),
    AutoRoute(path: '/popover-menu/default', page: PopoverMenuRoute.page),
    AutoRoute(path: '/portal/default', page: PortalRoute.page),
    AutoRoute(path: '/progress/default', page: LinearProgressRoute.page),
    AutoRoute(path: '/progress/linear', page: DeterminateLinearProgressRoute.page),
    AutoRoute(path: '/progress/circular', page: CircularProgressRoute.page),
    AutoRoute(path: '/radio/default', page: RadioRoute.page),
    AutoRoute(path: '/resizable/default', page: ResizableRoute.page),
    AutoRoute(path: '/resizable/no-cascading', page: NoCascadingResizableRoute.page),
    AutoRoute(path: '/resizable/horizontal', page: HorizontalResizableRoute.page),
    AutoRoute(path: '/resizable/no-thumb', page: NoThumbResizableRoute.page),
    AutoRoute(path: '/resizable/no-divider', page: NoDividerResizableRoute.page),
    AutoRoute(path: '/scaffold/default', page: ScaffoldRoute.page),
    AutoRoute(path: '/select/default', page: SelectRoute.page),
    AutoRoute(path: '/select/section', page: SectionSelectRoute.page),
    AutoRoute(path: '/select/sync', page: SyncSelectRoute.page),
    AutoRoute(path: '/select/async', page: AsyncSelectRoute.page),
    AutoRoute(path: '/select/async-loading', page: AsyncLoadingSelectRoute.page),
    AutoRoute(path: '/select/async-error', page: AsyncErrorSelectRoute.page),
    AutoRoute(path: '/select/toggleable', page: ToggleableSelectRoute.page),
    AutoRoute(path: '/select/clearable', page: ClearableSelectRoute.page),
    AutoRoute(path: '/select/format', page: FormatSelectRoute.page),
    AutoRoute(path: '/select/scroll-handles', page: ScrollHandlesSelectRoute.page),
    AutoRoute(path: '/select/form', page: FormSelectRoute.page),
    AutoRoute(path: '/select-group/default', page: SelectGroupRoute.page),
    AutoRoute(path: '/select-group/checkbox-form', page: SelectGroupCheckboxFormRoute.page),
    AutoRoute(path: '/select-group/radio-form', page: SelectGroupRadioFormRoute.page),
    AutoRoute(path: '/select-menu-tile/default', page: SelectMenuTileRoute.page),
    AutoRoute(path: '/select-menu-tile/scrollable', page: ScrollableSelectMenuTileRoute.page),
    AutoRoute(path: '/select-menu-tile/lazy', page: LazySelectMenuTileRoute.page),
    AutoRoute(path: '/select-menu-tile/form', page: SelectMenuTileFormRoute.page),
    AutoRoute(path: '/select-tile-group/default', page: SelectTileGroupRoute.page),
    AutoRoute(path: '/select-tile-group/scrollable', page: ScrollableSelectTileGroupRoute.page),
    AutoRoute(path: '/select-tile-group/lazy', page: LazySelectTileGroupRoute.page),
    AutoRoute(path: '/select-tile-group/multi-value', page: SelectTileGroupMultiValueRoute.page),
    AutoRoute(path: '/select-tile-group/radio', page: SelectTileGroupRadioRoute.page),
    AutoRoute(path: '/select-tile-group/suffix', page: SelectTileGroupSuffixRoute.page),
    AutoRoute(path: '/persistent-sheet/default', page: PersistentSheetRoute.page),
    AutoRoute(path: '/persistent-sheet/draggable', page: DraggablePersistentSheetRoute.page),
    AutoRoute(path: '/sidebar/default', page: SidebarRoute.page),
    AutoRoute(path: '/sidebar/sheet', page: SheetSidebarRoute.page),
    AutoRoute(path: '/sidebar/custom-width', page: CustomWidthSidebarRoute.page),
    AutoRoute(path: '/sidebar/nested', page: NestedSidebarRoute.page),
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
    AutoRoute(path: '/tappable/default', page: TappableRoute.page),
    AutoRoute(path: '/text-field/default', page: TextFieldRoute.page),
    AutoRoute(path: '/text-field/clearable', page: ClearableTextFieldRoute.page),
    AutoRoute(path: '/text-field/email', page: EmailTextFieldRoute.page),
    AutoRoute(path: '/text-field/password', page: PasswordTextFieldRoute.page),
    AutoRoute(path: '/text-field/multiline', page: MultilineTextFieldRoute.page),
    AutoRoute(path: '/text-form-field/default', page: TextFormFieldRoute.page),
    AutoRoute(path: '/tile/default', page: TileRoute.page),
    AutoRoute(path: '/tile/subtitle', page: TileSubtitleRoute.page),
    AutoRoute(path: '/tile/details', page: TileDetailsRoute.page),
    AutoRoute(path: '/tile-group/default', page: TileGroupRoute.page),
    AutoRoute(path: '/tile-group/scrollable', page: ScrollableTileGroupRoute.page),
    AutoRoute(path: '/tile-group/lazy', page: LazyTileGroupRoute.page),
    AutoRoute(path: '/tile-group/merge', page: MergeTileGroup.page),
    AutoRoute(path: '/time-field/default', page: TimeFieldRoute.page),
    AutoRoute(path: '/time-field/picker', page: PickerTimeFieldRoute.page),
    AutoRoute(path: '/time-field/validator', page: ValidatorTimeFieldRoute.page),
    AutoRoute(path: '/time-field/form', page: FormTimeFieldRoute.page),
    AutoRoute(path: '/time-picker/default', page: TimePickerRoute.page),
    AutoRoute(path: '/time-picker/interval', page: IntervalTimePickerRoute.page),
    AutoRoute(path: '/time-picker/animated', page: AnimatedTimePickerRoute.page),
    AutoRoute(path: '/toast/default', page: ToastRoute.page),
    AutoRoute(path: '/toast/no-auto-dismiss', page: NoAutoDismissToastRoute.page),
    AutoRoute(path: '/toast/raw', page: RawToastRoute.page),
    AutoRoute(path: '/toast/behavior', page: BehaviorToastRoute.page),
    AutoRoute(path: '/toast/swipe', page: SwipeToastRoute.page),
    AutoRoute(path: '/tooltip/default', page: TooltipRoute.page),
  ];
}
