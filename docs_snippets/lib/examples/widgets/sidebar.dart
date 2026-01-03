import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class SidebarPage extends Example {
  SidebarPage({@queryParam super.theme}) : super(maxWidth: 1000);

  @override
  Widget example(BuildContext context) => FScaffold(
    sidebar: FSidebar(
      header: Padding(
        padding: const .symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const .fromLTRB(16, 8, 16, 16),
              child: SvgPicture.network(
                context.theme.colors.brightness == .light
                    ? 'https://forui.dev/light_logo.svg'
                    : 'https://forui.dev/dark_logo.svg',
                height: 24,
                colorFilter: ColorFilter.mode(context.theme.colors.foreground, .srcIn),
              ),
            ),
            FDivider(style: context.theme.dividerStyles.horizontalStyle.copyWith(padding: .zero)),
          ],
        ),
      ),
      footer: Padding(
        padding: const .symmetric(horizontal: 16),
        child: FCard.raw(
          child: Padding(
            padding: const .symmetric(vertical: 12, horizontal: 16),
            child: Row(
              spacing: 10,
              children: [
                FAvatar.raw(child: Icon(FIcons.userRound, size: 18, color: context.theme.colors.mutedForeground)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 2,
                    children: [
                      Text(
                        'Dash',
                        style: context.theme.typography.sm.copyWith(
                          fontWeight: .bold,
                          color: context.theme.colors.foreground,
                        ),
                        overflow: .ellipsis,
                      ),
                      Text(
                        'dash@forui.dev',
                        style: context.theme.typography.xs.copyWith(color: context.theme.colors.mutedForeground),
                        overflow: .ellipsis,
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
      padding: const .symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: .start,
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colors.muted,
                borderRadius: context.theme.style.borderRadius,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colors.muted,
                borderRadius: context.theme.style.borderRadius,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@RoutePage()
class SheetSidebarPage extends Example {
  SheetSidebarPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => Center(
    child: FButton(
      child: const Text('Open Sidebar'),
      onPress: () => showFSheet(
        context: context,
        side: .ltr,
        builder: (context) => DecoratedBox(
          decoration: BoxDecoration(color: context.theme.colors.background),
          child: FSidebar(
            style: (s) => s.copyWith(constraints: s.constraints.copyWith(minWidth: 300, maxWidth: 300)),
            header: Padding(
              padding: const .symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const .fromLTRB(16, 8, 16, 16),
                    child: SvgPicture.network(
                      context.theme.colors.brightness == .light
                          ? 'https://forui.dev/light_logo.svg'
                          : 'https://forui.dev/dark_logo.svg',
                      height: 24,
                      colorFilter: ColorFilter.mode(context.theme.colors.foreground, .srcIn),
                    ),
                  ),
                  FDivider(style: context.theme.dividerStyles.horizontalStyle.copyWith(padding: EdgeInsets.zero)),
                ],
              ),
            ),
            footer: Padding(
              padding: const .symmetric(horizontal: 16),
              child: FCard.raw(
                child: Padding(
                  padding: const .symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    spacing: 10,
                    children: [
                      FAvatar.raw(child: Icon(FIcons.userRound, size: 18, color: context.theme.colors.mutedForeground)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 2,
                          children: [
                            Text(
                              'Dash',
                              style: context.theme.typography.sm.copyWith(
                                fontWeight: .bold,
                                color: context.theme.colors.foreground,
                              ),
                              overflow: .ellipsis,
                            ),
                            Text(
                              'dash@forui.dev',
                              style: context.theme.typography.xs.copyWith(color: context.theme.colors.mutedForeground),
                              overflow: .ellipsis,
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
        ),
      ),
    ),
  );
}

@RoutePage()
class CustomWidthSidebarPage extends Example {
  CustomWidthSidebarPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FSidebar(
    // {@highlight}
    style: (s) => s.copyWith(constraints: s.constraints.copyWith(minWidth: 500, maxWidth: 500)),
    // {@endhighlight}
    children: [
      FSidebarGroup(
        children: [
          FSidebarItem(
            icon: const Icon(FIcons.layoutDashboard),
            label: const Text('Dashboard'),
            selected: true,
            onPress: () {},
          ),
          FSidebarItem(icon: const Icon(FIcons.chartLine), label: const Text('Analytics'), onPress: () {}),
          FSidebarItem(
            icon: const Icon(FIcons.chartBar),
            label: const Text('Reports'),
            initiallyExpanded: true,
            children: [
              FSidebarItem(label: const Text('Daily'), onPress: () {}),
              FSidebarItem(label: const Text('Weekly'), onPress: () {}),
              FSidebarItem(label: const Text('Monthly'), onPress: () {}),
            ],
          ),
        ],
      ),
    ],
  );
}

@RoutePage()
class NestedSidebarPage extends Example {
  NestedSidebarPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FSidebar(
    style: (s) => s.copyWith(constraints: s.constraints.copyWith(minWidth: 300, maxWidth: 300)),
    children: [
      FSidebarGroup(
        children: [
          FSidebarItem(
            icon: const Icon(FIcons.userRound),
            label: const Text('Account'),
            initiallyExpanded: true,
            children: [
              FSidebarItem(
                label: const Text('Profile'),
                children: [
                  FSidebarItem(label: const Text('Personal Info'), onPress: () {}),
                  FSidebarItem(label: const Text('Preferences'), onPress: () {}),
                ],
              ),
              FSidebarItem(
                label: const Text('Security'),
                initiallyExpanded: true,
                children: [
                  FSidebarItem(
                    label: const Text('Password'),
                    initiallyExpanded: true,
                    children: [
                      FSidebarItem(label: const Text('Change Password'), onPress: () {}),
                      FSidebarItem(label: const Text('Password History'), onPress: () {}),
                    ],
                  ),
                  FSidebarItem(label: const Text('Two-Factor Authentication'), onPress: () {}),
                  FSidebarItem(label: const Text('Device History'), onPress: () {}),
                ],
              ),
              FSidebarItem(label: const Text('Notifications'), onPress: () {}),
            ],
          ),
          FSidebarItem(icon: const Icon(FIcons.palette), label: const Text('Appearance'), onPress: () {}),
          FSidebarItem(icon: const Icon(FIcons.settings), label: const Text('System'), onPress: () {}),
        ],
      ),
    ],
  );
}
