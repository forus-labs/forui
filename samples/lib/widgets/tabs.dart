import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TabsPage extends SampleScaffold {
  TabsPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: FTabs(
          tabs: [
            FTabEntry(
              label: 'Account',
              content: FCard(
                title: 'Account',
                subtitle: 'Make changes to your account here. Click save when you are done.',
                child: Column(
                  children: [
                    Container(
                      color: Colors.red,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            FTabEntry(
              label: 'Password',
              content: FCard(
                title: 'Password',
                subtitle: 'Change your password here. After saving, you will be logged out.',
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
