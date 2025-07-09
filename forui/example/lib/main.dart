import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui_example/sandbox.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();

  runApp(const Application());
}

List<Widget> _pages = [
  const Text('Home'),
  const Text('Categories'),
  const Text('Search'),
  const Text('Settings'),
  const Sandbox(),
];

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with SingleTickerProviderStateMixin {
  int index = 4;
  late FPopoverController controller = FPopoverController(vsync: this);

  @override
  void initState() {
    super.initState();
    controller.show();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en', 'US'),
    localizationsDelegates: FLocalizations.localizationsDelegates,
    supportedLocales: FLocalizations.supportedLocales,
    theme: FThemes.zinc.light.toApproximateMaterialTheme(),
    builder: (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
    home: Builder(
      builder: (context) {
        return FScaffold(
          sidebar: FSidebar(
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FDivider(style: context.theme.dividerStyles.horizontalStyle.copyWith(padding: EdgeInsets.zero)),
                ],
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FCard.raw(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    spacing: 10,
                    children: [
                      FAvatar.raw(child: Icon(FIcons.userRound, size: 18, color: context.theme.colors.mutedForeground)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              'Dash',
                              style: context.theme.typography.sm.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.colors.foreground,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'dash@forui.dev',
                              style: context.theme.typography.xs.copyWith(color: context.theme.colors.mutedForeground),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            children: [
              FSidebarGroup(
                label: const Text('Overview'),
                children: [
                  FSidebarItem(
                    icon: const Icon(FIcons.school),
                    label: const Text('Getting Started'),
                    initiallyExpanded: true,
                    onPress: () {},
                    children: [
                      FSidebarItem(label: const Text('Installation'), selected: true, onPress: () {}),
                      FSidebarItem(label: const Text('Themes'), onPress: () {}),
                      FSidebarItem(label: const Text('Typography'), onPress: () {}),
                    ],
                  ),
                  FSidebarItem(icon: const Icon(FIcons.code), label: const Text('API Reference'), onPress: () {}),
                  FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Pub Dev'), onPress: () {}),
                ],
              ),
              FSidebarGroup(
                action: const Icon(FIcons.plus),
                onActionPress: () {},
                label: const Text('Widgets'),
                children: [
                  FSidebarItem(icon: const Icon(FIcons.circleSlash), label: const Text('Divider'), onPress: () {}),
                  FSidebarItem(icon: const Icon(FIcons.scaling), label: const Text('Resizable'), onPress: () {}),
                  FSidebarItem(icon: const Icon(FIcons.layoutDashboard), label: const Text('Scaffold'), onPress: () {}),
                ],
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                FBreadcrumb(
                  children: [
                    FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
                    FBreadcrumbItem.collapsed(
                      menu: [
                        FItemGroup(
                          children: [
                            FItem(title: const Text('Documentation'), onPress: () {}),
                            FItem(title: const Text('Themes'), onPress: () {}),
                          ],
                        ),
                      ],
                    ),
                    FBreadcrumbItem(onPress: () {}, child: const Text('Overview')),
                    const FBreadcrumbItem(current: true, child: Text('Installation')),
                  ],
                ),
                Expanded(child: FDateField.calendar()),
                Expanded(
                  flex: 3,
                  child: FPopover(
                    controller: controller,
                    popoverBuilder: (context, _) => SizedBox.square(dimension: 100, child: FTextField()),
                    child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
