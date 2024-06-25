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
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      const FTextField(
                        label: 'Name',
                        hint: 'John Renalo',
                      ),
                      const SizedBox(height: 10),
                      const FTextField(
                        label: 'Email',
                        hint: 'john@doe.com',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 16),
                        child: FButton(
                          label: 'Save',
                          onPress: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FTabEntry(
              label: 'Password',
              content: FCard(
                title: 'Password',
                subtitle: 'Change your password here. After saving, you will be logged out.',
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      const FTextField(label: 'Current password'),
                      const SizedBox(height: 10),
                      const FTextField(label: 'New password'),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 16),
                        child: FButton(
                          label: 'Save',
                          onPress: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
